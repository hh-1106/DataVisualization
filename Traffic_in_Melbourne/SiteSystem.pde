import java.util.*;

class SiteSystem {

  String dataPath = "ml.CSV";
  Table dataCSV;
  ArrayList<Site> sites;
  String timeStr = " ";
  int time = 1;
  int maxTime;
  float halo = 0.4;
  float[] dts;

  SiteSystem() {
    dataCSV = loadTable(dataPath, "header, csv");
    maxTime = dataCSV.getRowCount();
    generateSites();
    getRowDataByTime(0);
    metaballShader.set("u_resolution", width*1., height*1.);
    metaballShader.set("halo", halo);
  }

  void update() {
    for (Site s : sites) {
      s.update();
    }
    setAttr();

    if (time < maxTime) {
      getRowDataByTime(time);
      if (frameCount % 5==0)  time++;
    }
  }

  public void setAttr() {
    for (int i = 0; i < MB; i++) {
      mbs[i*ATTR] = sites.get(i).pos.x;
      mbs[i*ATTR + 1] = sites.get(i).pos.y;
      mbs[i*ATTR + 2] = sites.get(i).traffic;
      mbs[i*ATTR + 3] = sites.get(i).phase;
    }
    metaballShader.set("metaballs", mbs, ATTR);
  }

  void show() {
    //if (this.sites==null ||this.sites.size() == 0) return;
    fill(255, 0, 255, 100);
    noStroke();
    for (Site s : sites) {
      s.show();
    }
  }

  void showTime() {
    fill(250, 80);
    text(timeStr, width*0.5, height*0.95);
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

  private void generateSites() {
    println("data loaded!!");
    this.sites = new ArrayList<Site>();
    for (int i=0; i<18; i++) {
      this.sites.add(new Site(names[i], ls[i]));
    }
  }

  public ArrayList<Integer> getTargets() {
    ArrayList<Integer> targets = new ArrayList<Integer>();
    dts = new float[18];
    for (int i=0; i<this.sites.size(); i++) {
      Site s = this.sites.get(i);
      dts[i] = s.getDt();
      for (int j=0; j<dts[i]; j++) {
        targets.add(i);
      }
    }
    return targets;
  }

  public void getRowDataByTime(int t) {
    TableRow r = dataCSV.getRow(t);
    timeStr = r.getString("Month") +" " + r.getString("Mdate") +" " + r.getString("Hour");
    //print("\nrow:", str);
    for (Site s : this.sites) {
      s.setTraffic(r.getFloat(s.name));
      //s.setTime(timeStr);
      //System.out.printf("%7d", s.traffic);
    }
  }
}
