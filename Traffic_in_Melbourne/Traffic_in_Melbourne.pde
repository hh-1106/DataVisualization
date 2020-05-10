PShader metaballShader; //<>//
PGraphics molb, flows;
final int ATTR = 4;         // vec4
final int MB = 18;          // 18个地点
final int FLOW = 110;       // 128个人流
float[] mbs = new float[ATTR*(MB+FLOW)];    // 修改shader的宏定义

MapSystem MS;
SiteSystem SS;
FlowSystem FS;

void settings() {
  size(1280, 720, P2D);
  smooth();
}

void setup() {
  metaballShader = loadShader("metaball.glsl");
  molb = createGraphics(width, height, P2D);
  flows = createGraphics(width, height, P2D);

  setFont();
  MS = new MapSystem(this);
  SS = new SiteSystem();
  FS = new FlowSystem();
  frameRate(60);
}

void draw() {
  MS.show();
  SS.update();
  FS.update();
  SS.render(molb);
  FS.render(flows);
  image(molb, 0, 0);
  image(flows, 0, 0);
  //FS.show();
  //SS.show();

  SS.showTime();
  fps();
}

void mouseDragged() {
  if (mouseButton==CENTER)
    metaballShader.set("halo", map(mouseY, 0, height, 0., 2.));
}
