int uv_w = 1440; //<>// //<>// //<>// //<>//
int uv_h = 632;
PImage ocean;

class ParticleSystem {
  ArrayList<Particle> particles;
  int num = 50000;
  PVector[][] uv;


  ParticleSystem() {
    ocean = loadImage("1.png");
    ocean.resize(uv_w, uv_w/2);
    uv = new PVector[uv_w][uv_h];
    initUV();
    particles = new ArrayList<Particle>();

    for (int i = 0; i < num; i++) {
      particles.add(new Particle());
    }
  }

  void initUV() {
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

  void update() {
    applyForce(uv);
    for (int i = particles.size()-1; i >= 0; i--) {
      Particle p = particles.get(i);
      p.update();
      if (p.isDead) {
        particles.remove(p);
        addParticle();
      }
    }
  }

  void render(PGraphics pg) {
    pg.beginDraw();
    pg.pushMatrix();
    pg.fill(20, 50);
    pg.noStroke();
    pg.rect(0, 0, pg.width, pg.height);
    pg.translate(0, 60);
    pg.strokeWeight(0.8);
    pg.noFill();
    //pg.stroke(0, 75, 175, 150);
    for (Particle p : particles) {
      p.render(pg);
    }
    pg.popMatrix();
    pg.endDraw();
  }


  void applyForce(PVector[][] dir) {
    for (Particle p : particles) {
      p.applyForce(dir[int(p.loc.x)][int(p.loc.y)]);
    }
  }

  void addParticle() {
    particles.add(new Particle());
  }
}
