float percent = 0;

void loading() {
  cam.beginHUD();
  fill(200);
  percent = lerp(percent, loadState/4.0, 0.02);
  text("Loading ...", width*0.9, height*0.95);

  stroke(200);
  pushMatrix();
  translate(width*0.05, height*0.9);
  line(0, 0, percent*width*0.9, 0);
  popMatrix();
  cam.endHUD();
}

void setFont() {
  //String[] fontList = PFont.list();
  //printArray(fontList);
  //noLoop();
  PFont font = createFont("Mouse.otf", 48);
  textFont(font);
  textSize(20);
  textAlign(CENTER, CENTER);
}

void cheakCam() {
  if (mouseX > gui.x) {
    cam.setActive(false);
  } else {
    cam.setActive(true);
  }
}
