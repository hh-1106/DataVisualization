import processing.video.*;
import java.util.*;

Movie m;
ColorSystem CS;

void settings() {
  size(1200, 1000);
}

void setup() {
  selectInput("Select a video file:", "fileSelected");
  CS = new ColorSystem();
  frameRate(24);
  imageMode(CENTER);
  setFont();
}

void draw() {
  background(0);
  translate(width*0.5, height*0.5);
  CS.show(600);

  if (m!=null)
    image(m, 0, 0, m.width*0.33, m.height*0.33);

  // 进度条
  if (mouseX > 0 || mouseX < width)
    showTimeLine();
}

void movieEvent(Movie m) {
  try {
    m.read();
  }
  catch(Exception e) {
    println("read wrong");
  }
  m.filter(POSTERIZE, 20);
  CS.update(m.pixels);
}

void mouseClicked() {
  int frame = (int)map(mouseX, 0, width, 0, getLength());
  setFrame(frame);
}

void setFrame(int n) { 
  float frameDuration = 1.0 / m.frameRate;
  float where = (n + 0.5) * frameDuration; 
  float diff = m.duration() - where;
  if (diff < 0) {
    where += diff - 0.25 * frameDuration;
  }  
  m.jump(where);
}  

int getLength() {
  return int(m.duration() * m.frameRate);
}
