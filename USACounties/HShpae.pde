public class HShape extends RShape {
  public RPoint pos;
  public RShape H;
  public ArrayList<HShape> children;
  public color sCol = 360;
  public color fCol = 360;
  public float sWt = 1;
  public float scl = 1;

  public HShape(RShape r) {
    this.H = new RShape();
    this.H = r;
    this.pos = this.H.getCenter();

    //println(r.width*0.5, r.height*0.5);
    //initChildren();
    // initStyle();
  }

  private void initStyle() {
    this.H.setStroke(this.sCol);
    this.H.setFill(false);
    this.H.setStrokeWeight(this.sWt);
    //this.H.scale(2, H.getCenter());
  }

  public void setHue(float hue) {
    this.fCol = color(hue, 100, 100);
    this.H.setFill(fCol);
  }

  private void initChildren() {
    this.children = new ArrayList<HShape>();
    if (this.H.countChildren() > 0) {
      for (RShape r : this.H.children) {
        children.add(new HShape(r));
      }
    }
  }

  public RShape getChildById(String id) {
    return this.H.getChild(id);
  }

  public void show() {
    if (this.children != null) {
      for (HShape c : children) {
        c.show();
      }
    } else {
      pushMatrix();

      //this.H.scale(1, H.getCenter());
      //this.H.setStroke(this.sCol);
      //this.H.setFill(this.fCol);
      //this.H.setStrokeWeight(this.sWt);
      this.H.draw();

      //stroke(360, 75);
      //strokeWeight(2);
      //point(pos.x, pos.y);
      popMatrix();
    }
  }
}
