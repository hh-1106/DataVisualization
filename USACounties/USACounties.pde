import peasy.*;                      
PeasyCam cam;

final int svgW = 278;
final int svgH = 176;

RShape shapes;        
String scaleFlag1;
String scaleFlag2;
float savColr, savK;
Table table;

SVGSystem SS;
String svgPath = "USA_Counties_with_FIPS_and_names.svg";
String csvPath = "unemployment09.csv";

void setup() {
  size(1280, 720, P3D);
  cam = new PeasyCam(this, 400);
  RG.init(this);
  shapes = RG.loadShape(svgPath);
  SS = new SVGSystem(this, svgPath);
  table = loadTable(csvPath, "header");
  colorMode(HSB, 360, 100, 100, 100);
  setFont();
}

void draw() {
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
