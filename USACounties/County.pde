public class County extends HShape {
  String name;
  float num;
  float z = 0;
  float cz = 0;
  float rate;    // 1.2 - 30.1
  public ArrayList<County> counties;

  County(RShape r) {
    super(r);
    this.counties = new ArrayList<County>();
  }

  County(RShape r, String name_, float num_, float rate_) {
    super(r);
    this.name = name_;
    this.num = num_;
    this.rate = rate_;
    initStyle();
  }

  private void initStyle() {
    if (frameCount > 150) return;

    float n = 0.1;
    float num = map(pow(this.num, n)
      , pow(6, n), pow(3000, n)
      , 0, 100);
    this.z = num;

    this.H.setStroke(false);
    float p = 0.2;
    float hue = map(pow(this.rate, p)
      , 1, 2
      //pow(30, p),
      , 80, -50);
    this.fCol = color((hue+360)%360, 100, 100);
  }

  private void showText3D() {

    if (rate > RATE_T) {
      textSize(rate*1.1);

      if (isRed) {
        float r = map(hue(fCol), 0, 360, 15, -5);
        fill((360+r)%360, 100, 100, z*0.3);
      } else
        fill(200+hue(fCol), rate*2);
      pushMatrix();
      //translate(pos.x, pos.y);
      //rotateZ(HALF_PI);

      text(rate, pos.x, pos.y);
      popMatrix();
    }
  }

  public void showText() {
    textSize(24);
    text(this.name + "-" + this.rate, svgW, -20);
  }


  public void show() {
    initStyle();

    if (this.sCol == -1)   this.H.setStroke(false);
    else                   this.H.setStroke(this.sCol);
    if (this.fCol == -1)   this.H.setFill(false);
    else                   this.H.setFill(this.fCol);


    //this.H.setStrokeWeight(this.sWt);
    //this.H.scale(this.scl, this.pos);

    showText3D();
    //this.H.draw();
  }

  public void lerpTo3d() {
    this.cz = lerp(cz, z, 0.05);
  }

  public void backTo2d() {
    this.cz = lerp(cz, 0, 0.05);
  }
}
