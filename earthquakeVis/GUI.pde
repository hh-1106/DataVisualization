import controlP5.*;
import java.util.*;
GUI gui;


float rotateSpeed = 0.0;
float cloudBrightness = 1.0;
float fresnel = 5.0;
float fresnelStrength = 2.5;

class GUI {
  ControlP5 cp5;
  Slider rotateSpeedSlider, cloudBrightnessSlider, fresnelSlider, fresnelStrengthSlider;
  int w = 100;
  int h = 16;
  float x = width*0.88;
  float y = 20;
  CColor col = new CColor(
    color(50), // Foreground
    color(30), // Background
    color(75), // Active
    color(255), // CaptionLabel
    color(255));  // ValueLabel

  GUI(PApplet app) {
    cp5 = new ControlP5(app);
    this.setup();
    cp5.setAutoDraw(false);
  }

  void setup() {
    cp5.setColor(col);

    rotateSpeedSlider = cp5.addSlider("rotateSpeed")
      .setPosition(x, y)
      .setScrollSensitivity(0.3)
      .setSize(w, h)
      .setRange(0, 0.3)
      .setValue(0.01)
      ;

    cloudBrightnessSlider = cp5.addSlider("cloudBrightness")
      .setPosition(x, y+20)
      .setScrollSensitivity(0.5)
      .setSize(w, h)
      .setRange(0, 2.0)
      .setValue(1.0)
      ;

    fresnelSlider = cp5.addSlider("fresnel")
      .setPosition(x, y+40)
      .setScrollSensitivity(1.0)
      .setSize(w, h)
      .setRange(1., 10.)
      .setValue(5.0)
      ;

    fresnelStrengthSlider = cp5.addSlider("fresnelStrength")
      .setPosition(x, y+60)
      .setScrollSensitivity(0.5)
      .setSize(w, h)
      .setRange(1., 3.)
      .setValue(2.5)
      ;
  }

  void draw() {
    resetShader();
    cp5.draw();
  }
}

public void rotateSpeed(float val) {
  rotateSpeed = val;
}

public void cloudBrightness(float val) {
  cloudBrightness = val;
}

public void fresnel(float val) {
  fresnel = val;
}

public void fresnelStrength(float val) {
  fresnelStrength = val;
}
