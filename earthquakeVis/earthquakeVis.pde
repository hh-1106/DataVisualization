import peasy.*;
PeasyCam cam;

LightsMaker LM;
Earth earth;
PImage lights;

void settings() {
  size(1600, 900, P3D);
  //fullScreen(P3D);
  smooth(4);
}

void setup() {
  frameRate(30);

  LM = new LightsMaker();

  setFont();
  cam = new PeasyCam(this, 1200);
  cam.setMinimumDistance(2);
  thread("loadTexture");
  earth = new Earth();
  gui = new GUI(this);
}

void draw() {
  background(12);
  cheakCam();
  cam.beginHUD();
  gui.draw();
  cam.endHUD();

  //lights();
  //fill(256, 20);
  //rect(0, 0, width, height);

  LM.update();
  LM.render();

  if (1 - percent > EPSILON) {
    loading();
  } else {
    earth.show();
  }

  surface.setTitle("" + frameRate);
  //image(LM.pg, 0, 0);
}
