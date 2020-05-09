import peasy.*;
PeasyCam cam;

final int svgW = 278;
final int svgH = 176;

SVGSystem SS;
String svgPath = "USA_Counties_with_FIPS_and_names.svg";
String csvPath = "unemployment09.csv";

void setup() {
  size(1280, 720, P3D);
  //fullScreen(P3D);
  cam = new PeasyCam(this, 400);
  RG.init(this);
  SS = new SVGSystem(this, svgPath);
  colorMode(HSB, 360, 100, 100, 100);
  setFont();
}


float aX = 0;
float aY = 0;
float aZ = 0;
void draw() {

  /*
  translate(0, -100+aZ*100, 0);
   rotateX(-PI*0.5);
   //rotateZ(-PI*0.5 - aZ);
   aZ += 0.01;
   aZ = 0;
   if(aZ >= 1)
   aZ = 1;
   */

  if (isRed)
    background(320, 100);
  else
    background(30, 100);
  translate(-svgW, -svgH);
  //SS.highlight();
  SS.show();

  String txt_fps = String.format("[frame %d]   [fps %6.2f]", frameCount, frameRate);
  surface.setTitle(txt_fps);
}
