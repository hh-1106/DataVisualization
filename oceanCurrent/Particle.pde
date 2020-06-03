class Particle {
  PVector loc;
  PVector vel;
  PVector acc;
  color col;
  Boolean isDead = false;


  Particle() {
    acc = new PVector(0, 0);
    float vx = 0;
    float vy = 0;
    vel = new PVector(vx, vy);
    loc = new PVector(random(uv_w-1), random(uv_h-1));
  }

  void applyForce(PVector f) {
    acc.add(f);
  }

  // Method to update position
  void update() {
    vel.add(acc);
    loc.add(vel);
    acc.mult(0);
    if (Float.isNaN(acc.x)) {
      isDead=true;
    }
    check();
  }

  void check() {
    loc.x = loc.x<1         ?uv_w-1   :loc.x;
    loc.x = loc.x>uv_w-1    ?0        :loc.x;
    loc.y = loc.y<1         ?uv_h-1   :loc.y;
    loc.y = loc.y>uv_h-1    ?0        :loc.y;
  }

  void render(PGraphics pg) {
    if (isDead) return;
    //int x = (int)map(loc.x,    0, uv_w,   0, 1200);
    //int y = (int)map(loc.y+69, 0, uv_w/2, 0, 600);
    //x = constrain(x, 0 ,1199);
    //y = constrain(y, 0, 599);
    //color col = ocean.get(x, y);
    pg.stroke(0, 75, 175, 170);
     //pg.stroke(255, 170);
    
    pg.point(loc.x, 600-loc.y);
  }
}
