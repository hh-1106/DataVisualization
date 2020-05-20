class ColorSystem {
  private ArrayList<Colorbeing> colorSequences;
  private HashMap<Integer, Colorbeing> colorMap;
  private float total;

  ColorSystem() {
    colorMap = new HashMap<Integer, Colorbeing>();
    colorSequences = new ArrayList<Colorbeing>();
  }

  void update(int[] ps) {
    clean();
    addNewFrame(ps);
    colorSequences = new ArrayList<Colorbeing>(colorMap.values());
    //println(colorSequences.size());
    try {
      Collections.sort(colorSequences, new CountComparator());
    }
    catch(Exception e) {
      println("sort wrong");
    }
  }

  void show(float R) {

    float lastAngle = -PI/2.0;
    noStroke();

    //for (Colorbeing cb : colorSequences) {    // sb
    for (int i=0; i<colorSequences.size(); i++) {
      Colorbeing cb = colorSequences.get(i);

      cb.r = (cb.r==0) ? cb.lastR :cb.r;
      float angle = (float)cb.r/total*TWO_PI;

      fill(cb.col);

      arc(0, 0, R, R, lastAngle, lastAngle+angle);

      textTop(R, angle, lastAngle);
      lastAngle += angle;
    }

    float r = map(mouseY, 0, height, 1, 0);
    fill(0);
    //ellipse(0, 0, R*0.88, R*0.88);
    ellipse(0, 0, R*r, R*r);
  }

  private void textTop(float R, float angle, float lastAngle) {
    if (angle > 0.01*TWO_PI) {

      pushMatrix();
      rotate(lastAngle + angle/2.0);

      translate(R*0.5, 0);
      stroke(255);
      line(3, 0, 8, 0);
      noStroke();
      fill(255);

      float size = map(pow(angle, 0.4), 0.01, 1, 0, 40);
      //println(angle, size);
      size = constrain(size, 0, R*0.1);
      textSize(size);


      translate(R*0.05, 0);
      String percent = String.format("%.2f%%", angle/TWO_PI*100.0);

      if (lastAngle+angle/2.0<PI/2.0) {
        textAlign(LEFT, CENTER);
      } else {
        rotate(PI);
        textAlign(RIGHT, CENTER);
      }

      text(percent, 0, 0);
      popMatrix();
    }
  }

  private void clean() {
    for (Colorbeing cb : colorSequences) {
      cb.num = 0;
      cb.lastR = cb.r;
      cb.r = 0.0;
    }
  }

  private void addNewFrame(int[] ps) {
    for (int c : ps) {
      Colorbeing cb = colorMap.get(c);
      if (cb==null)
        colorMap.put(c, new Colorbeing(c));
      else {
        cb.num++;
      }
    }
    calculateRatio(ps.length);
  }

  private void calculateRatio(float len) {
    total = 0;
    for (Colorbeing cb : colorSequences) {
      float ratio = cb.num/len;
      cb.r += ratio;
      total += cb.r;
    }
  }
}
