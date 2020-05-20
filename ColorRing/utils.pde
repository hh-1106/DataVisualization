void fileSelected(File file) {
  if (file == null) {
    selectInput("Select a video file:", "fileSelected");
  } else {
    println(file.getName() + " loaded!!");
    m = new Movie(this, file.getAbsolutePath());
    m.loop();

    //m.jump(0);    // sb
  }
}


class CountComparator implements Comparator {
  int compare(Object o1, Object o2) {
    float int1 = ((Colorbeing) o1).r;
    float int2 = ((Colorbeing) o2).r;
    return (int1<int2) ? -1 : (int1==int2) ? 0 : 1;
  }
}

void setFont() {
  //String[] fontList = PFont.list();
  //printArray(fontList);
  //noLoop();
  PFont font = createFont("Mouse.otf", 48);
  textFont(font);
  textAlign(LEFT, TOP);
}

void showTimeLine() {
  if (m == null) return;
  pushStyle();
  pushMatrix();
  strokeWeight(2);
  stroke(255, 80);
  translate(-width*0.5, -height*0.5-1);
  line(0, height, width, height);
  stroke(255);
  float x = m.time()*1.0 / (float)m.duration() * width;
  line(0, height, x, height);
  popMatrix();
  popStyle();
}
