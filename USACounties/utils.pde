void setFont() {
  //String[] fontList = PFont.list();
  //printArray(fontList);
  //noLoop();
  PFont font = createFont("Mouse.otf", 48);
  textFont(font);
  textSize(4);
  textAlign(CENTER, CENTER);
}



float RATE_T = 1;
boolean mode3 = false;
boolean isRed = false;

void keyPressed(){
  if(keyCode == UP)    RATE_T++;
  if(keyCode == DOWN)  RATE_T *= 0.95;
  if(keyCode == RIGHT) {RATE_T = 1;mode3=false;}
  
  
  if(key == ' ')  isRed = !isRed;
  
  println(RATE_T);
}


void mouseDragged(){
  mode3 = true;
}
