import peasy.*;
PeasyCam cam;
Earth earth;
PImage lights;

ParticleSystem ps;
PGraphics pg_ps;
Field ff;

void settings() {
  size(1600, 900, P3D);
  //fullScreen(P3D);
  smooth(4);
}

void setup() {
  pg_ps = createGraphics(1440, 720);
  ps = new ParticleSystem();

  //ff = new Field();
  cam = new PeasyCam(this, 1200);
  cam.setMinimumDistance(2);
  thread("loadTexture");
  earth = new Earth();
  setFont();
  gui = new GUI(this);
  background(0);
  frameRate(30);
}


void draw() {
  background(20);
  //ff.show();

  cheakCam();
  cam.beginHUD();
  gui.draw();
  cam.endHUD();

  ps.update();
  ps.render(pg_ps);

  //image(pg_ps, 0, 0);

  if (1 - percent > EPSILON) {
    loading();
  } else {
    earth.show();
  }


  surface.setTitle("" + frameRate);
}
