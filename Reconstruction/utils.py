import numpy as np
from mayavi import mlab
from tvtk.api import tvtk

import os
os.environ['QT_API'] = 'pyqt5'
from pyface.qt import QtGui, QtCore
from traits.api import HasTraits, Instance, on_trait_change
from traitsui.api import View, Item, Handler
from mayavi.core.ui.api import MayaviScene, MlabSceneModel, SceneEditor
from PyQt5.QtCore import pyqtSignal, QThread
from PyQt5.QtCore import (QEvent, Qt)


from PIL import Image
def load_bmp(dir_path):
    print(dir_path)
    files = os.listdir(dir_path)
    num = 0
    data3 = np.zeros((512, 512, 100))
    for f in files:
        im = Image.open("../data/" + f)
        data = im.getdata()
        data = np.matrix(data, dtype='float')
        data = np.reshape(data, im.size)
        data3[:, :, num] = data
        num += 1
    # print(data3)
    print(data3.shape)
    return data3, [1, 1, 1]


class Visualization(HasTraits):
    # 可视化类, 用于搭建场景,以及设定一些scene参数

    def __init__(self, data, spacing):
        super(Visualization, self).__init__()
        self.data = data
        self.spacing = spacing
        self.ipw = None

    scene = Instance(MlabSceneModel, ())    # mayavi 场景

    @on_trait_change('scene.activated')
    def update_plot(self):
        # view开启时被调用
        if(self.data != None):
            self.reconstrucion(self.data, self.spacing)
        self.scene.background = (0, 0, 0)

    view = View(Item('scene', editor=SceneEditor(scene_class=MayaviScene),
                     height=250, width=300, show_label=False),
                resizable=True
                )

    def reconstrucion(self, data, spacing):
        '''
        resample, threshold, filter, display
        :param data: a 3d array with channel last
        :param spacing: PixelSpacing
        :return: none
        '''

        mlab.clf()
        self.scene.disable_render = True  # 以加快渲染速度
        src = mlab.pipeline.scalar_field(data)
        # 重采样
        src.spacing = spacing
        src.update_image_data = True

        # 提取心脏
        # thresh_filter = tvtk.ImageThreshold()
        # thresh_filter.threshold_between(lower_thr, upper_thr)
        # thresh = mlab.pipeline.user_defined(src, filter=thresh_filter)
        # 中值滤波
        median_filter = tvtk.ImageMedian3D()
        # median_filter.SetKernelSize(3, 3, 3)
        median = mlab.pipeline.user_defined(src, filter=median_filter)
        # 各项异性扩散滤波
        diffuse_filter = tvtk.ImageAnisotropicDiffusion3D(
            diffusion_factor=1.0,
            diffusion_threshold=25.0,
            number_of_iterations=3, )
        diffuse = mlab.pipeline.user_defined(median, filter=diffuse_filter)

        # 提取表面
        contour = mlab.pipeline.contour(diffuse, )
        contour.filter.contours = [110, ]

        # 网格抽取
        dec = mlab.pipeline.decimate_pro(contour)
        dec.filter.feature_angle = 60.
        dec.filter.target_reduction = 0.7

        # 网格平滑
        smooth_ = tvtk.SmoothPolyDataFilter(
            number_of_iterations=10,
            relaxation_factor=0.1,
            feature_angle=60,
            feature_edge_smoothing=False,
            boundary_smoothing=False,
            convergence=0.,
        )
        smooth = mlab.pipeline.user_defined(dec, filter=smooth_)

        # 获取最大连通区
        connect_ = tvtk.PolyDataConnectivityFilter(extraction_mode=4)
        connect = mlab.pipeline.user_defined(smooth, filter=connect_)

        # 计算法线
        compute_normals = mlab.pipeline.poly_data_normals(connect)
        compute_normals.filter.feature_angle = 80

        self.surf = mlab.pipeline.surface(compute_normals,
                                     color=(0.9, 0.72, 0.62),
                                     opacity=0.9)

        # Display a cut plane of the raw data
        self.ipw = mlab.pipeline.image_plane_widget(src,
                                               colormap='bone',
                                               plane_orientation='x_axes',
                                               slice_index=5)

        self.ipw.ipw.margin_size_x = 0
        self.ipw.ipw.margin_size_y = 0

        self.scene.disable_render = False

    def update_axis(self, which):
        '''
        设置可视切片的方向
        :param which: 字符串 如:'x_axes'
        '''
        self.ipw.ipw.plane_orientation = which
        pass

    def get_index(self):
        '''
        获取当前选中切片的index
        '''
        return int(self.ipw.ipw.slice_index)

    def set_opacity(self, value):
        self.surf.actor.property.opacity = value*0.01


class DisableToolbarHandler(Handler):
    def position(self, info):
        editor = info.ui.get_editors('scene')[0]
        editor._scene._tool_bar.setVisible(False)


class MayaviQWidget(QtGui.QWidget):
    # mayavi窗口, 以嵌入Qt
    singal_index = pyqtSignal(int)      # 切片信号

    def __init__(self, data, spacing, parent=None):
        self.data = data
        self.spacing = spacing
        super(MayaviQWidget, self).__init__(parent)
        self.initUi()

    def initUi(self):
        self.layout = QtGui.QVBoxLayout(self)
        self.layout.setContentsMargins(0, 0, 0, 0)
        self.layout.setSpacing(0)

        self.visualer = Visualization(self.data, self.spacing)
        self.ui = self.visualer.edit_traits(parent=self, kind='subpanel').control
        # self.ui = self.visualer.edit_traits(handler=DisableToolbarHandler(), kind='subpanel').control
        self.layout.addWidget(self.ui)
        self.ui.setParent(self)


    def release_callback(self, vtk_obj, event):
        self.singal_index.emit(self.visualer.get_index())
        # print('released!!')

    def update_data(self, data, spacing):
        self.visualer.data = data
        self.visualer.spacing = spacing
        self.visualer.reconstrucion(data, spacing)
        # image_plane_widget设置鼠标回调
        self.visualer.ipw.ipw.add_observer('StartInteractionEvent', self.release_callback)
        # self.visualer.ipw.ipw.add_observer('InteractionEvent', self.release_callback)
        self.visualer.ipw.ipw.add_observer('EndInteractionEvent', self.release_callback)
