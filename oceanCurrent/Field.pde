class Field {
  PVector[][] uv;

  Field() {
    uv = new PVector[uv_w][uv_h];

    String[] lines1 = loadStrings("U.csv");
    String[] lines2 = loadStrings("V.csv");
    for (int i = 0; i < lines1.length; i++) {
      String[] pieces1 = split(lines1[i], ',');
      String[] pieces2 = split(lines2[i], ',');
      for (int j=0; j < pieces1.length; j++) {
        PVector p = new PVector(float(pieces1[j]), float(pieces2[j]));
        uv[j][i] = p;
      }
    }
  }


  void show() {
    
    translate(0,69);

    for (int i = 0; i < 1440; i+=5) {
      for (int j = 0; j < 632; j+=5) {
        PVector v = uv[i][j];
        if (v != null) {
          //println(v);
          stroke(255, 50+v.mag()*50);
          strokeWeight(1);
          pushMatrix();
          translate(i, j);
          rotate(v.heading());
          line(0, 0, 25*v.mag(), 0);
          popMatrix();
        }
      }
    }
  }
}
