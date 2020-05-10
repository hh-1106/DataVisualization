class Site {
  PVector pos;
  Location target;
  String name;
  float traffic, ptraffic;
  float phase;
  Location loc;    // Latitude, Longitude
  int id;
  boolean moving = false;
  float speed = random(0.01, 0.3);

  Site(int id) {
    this.id = id;
    loc = ls[id];
    init();
  }

  Site(String _name, Location _loc) {
    name = _name;
    loc = _loc;
    init();
  }

  void init() {
    ScreenPosition p = MS.map.getScreenPosition(loc);
    this.pos = new PVector(p.x, height-p.y);
    phase = random(TWO_PI);
    traffic = random(2, 5);
  }

  void setTraffic(float v) {
    ptraffic = traffic;
    traffic = map(log(v+1), 0, 9, 0, 50);
  }

  float getDt() {
    float dt = traffic - ptraffic;
    return max(dt, 0);
  }

  void setTarget(Location lo) {
    this.target = lo;
    moving = true;
  }

  void moveTo() {
    if (target == null) return;

    PVector tar = MS.map.getScreenPosition(target);
    tar.y = height-tar.y;
    pos.lerp(tar, speed);
    float d = pos.dist(tar);

    if (d<10)  moving = false;
  }

  void update() {
    ScreenPosition p = MS.map.getScreenPosition(loc);
    this.pos = new PVector(p.x, height - p.y);
  }

  void show() {
    float r = map(log(traffic+1), 0, 9, 0, 100);
    ellipse(pos.x, height-pos.y, r, r);
  }
}
