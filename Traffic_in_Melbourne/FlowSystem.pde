// TODO:继承老出错?

class FlowSystem {
  ArrayList<Site> sites;
  
  FlowSystem() {
    generateSites();
  }

  void update() {
    if (this.sites==null ||this.sites.size() == 0) return;

    choseTarget();
    for (Site s : sites) {
      s.moveTo();
    }
    setAttr();
  }

  void render(PGraphics pg) {
    pg.shader(metaballShader);
    pg.beginShape(QUADS);
    pg.vertex(0, 0);
    pg.vertex(width, 0);
    pg.vertex(width, height);
    pg.vertex(0, height);
    pg.endShape();
  }

  void show() {
    fill(255, 0, 255, 100);
    noStroke();
    for (Site s : sites) {
      s.show();
    }
  }
  
  public void setAttr() {
    for (int i = 18; i < 18+FLOW; i++) {
      mbs[i*ATTR] = sites.get(i-18).pos.x;
      mbs[i*ATTR + 1] = sites.get(i-18).pos.y;
      mbs[i*ATTR + 2] = sites.get(i-18).traffic;
      mbs[i*ATTR + 3] = sites.get(i-18).phase;
    }
    metaballShader.set("metaballs", mbs, ATTR);
  }

  private void choseTarget() {
    ArrayList<Integer> ts;
    ts = SS.getTargets();
    if (ts.size() == 0) return;

    for (Site s : sites) {
      int id = ts.get(floor(random(ts.size())));
      if (!s.moving)
        s.setTarget(ls[id]);
    }
    //printArray(ts);
  }

  private void generateSites() {
    println("generateSites");
    this.sites = new ArrayList<Site>();
    for (int i=0; i<FLOW; i++) {
      this.sites.add(new Site(floor(random(18))));
    }
  }
}
