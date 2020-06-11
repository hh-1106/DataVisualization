import java.io.File;

// Two images
PImage a;
PImage b;

String imgPath = "FGNET/images/";
String ptsPath = "FGNET/points/";

String A = "001A43a";
String B = "001A43b";
String[] fileNames;


// A Morphing object
Morpher morph;

// How much to morph, 0 is image A, 1 is image B, everything else in between
float amt =  0;
// Morph bar position
float x = 100;


int index = 0;
void setup() {
  size(960, 700, P2D);

  File file = new File("F:/New/Desktop/FaceMorph/FGNET/images");
  fileNames = file.list();
  printArray(fileNames);

  // Load the images
  a = loadImage(imgPath + A + ".JPG");
  b = loadImage(imgPath + B + ".JPG");

  // Create the morphing object
  morph = new Morpher(a, b);
  morph.load2Points(A.toLowerCase() + ".pts", B.toLowerCase() + ".pts");
}

void draw() {

  scale(0.5);
  background(0);

  pushMatrix();

  // Show Image A and its triangles
  morph.displayImageA();
  morph.displayTrianglesA();

  // Show Image B and its triangles
  translate(a.width, 0);
  morph.displayImageB();
  morph.displayTrianglesB();


  translate(-a.width, a.height);

  // Update the amount according to mouse position when pressed
  if (mousePressed && mouseY > a.height) {
    x = constrain(mouseX, 100, width-100);
    amt = map(x, 100, width-100, 0, 1);
  }

  // Morph an amount between 0 and 1 (0 being all of A, 1 being all of B)
  morph.drawMorph(amt);


  popMatrix();

  // Have you clicked on the images?
  if (va != null) {
    fill(255, 0, 0);
    ellipse(va.x, va.y, 8, 8);
  }
  if (vb != null) {
    fill(255, 0, 0);
    ellipse(vb.x, vb.y, 8, 8);
  }


  scale(2);

  // Draw bar at bottom
  stroke(255);
  line(100, height-50, width-100, height-50);
  stroke(255);
  line(x, height-75, x, height-25);


  counter += 0.05;
  if (frameCount %10 == 0) {
    switch2Next(index++);
  }
}

// Save or load points based on key presses
void keyPressed() {
  if (key == 's') {
    morph.savePoints();
  } else if (key == 'n') {
    morph.load2Points(A.toLowerCase() + ".pts", B.toLowerCase() + ".pts");
  }
}

// Variables to keep track of mouse interaction
int counter = 0;
PVector va;
PVector vb;

void mousePressed() {

  // If we clicked on an image
  if (mouseY < a.height) {
    // Point on image A first
    if (counter == 0) {
      va = new PVector(mouseX, mouseY);
    }
    // Corresponding point on image B
    else if (counter == 1) {
      PVector vb = new PVector(mouseX-a.width, mouseY);
      morph.addPair(va, vb);
    }
    // Increment click counter
    counter++;
    if (counter == 2) {
      // Start over
      counter = 0;
      va = null;
      vb = null;
    }
  }
}

void switch2Next(int i) {
  
  PImage a = loadImage(imgPath + fileNames[i]);
  PImage b = loadImage(imgPath + fileNames[i+1]);

  morph = new Morpher(a, b);
  morph.load2Points(A.toLowerCase() + ".pts", B.toLowerCase() + ".pts");
  counter = 0;
}
