class Colorbeing {
  color col;
  int num;
  float r;            // ratio
  float lastR = 0;    // to avoid r=0 and draw nothing

  Colorbeing(color col_) {
    col = col_;
    num = 1;
    r = 0.0;
  }
}
