final int ATTR = 4;    // vec4
final int MB = 128;    // 128个点

class LightsMaker {
  PShader shader;    // metaballShader
  int w = textureSize;
  int h = textureSize/2;
  PGraphics pg;      // earthquake heatmap
  float[] mbs;       // metaballs
  Table data;
  String path = "all_2000s_M6plus.csv";
  int maxRow;
  int ctr = 0;       // current row
  //PImage img;

  LightsMaker() {
    shader = loadShader("metaball.glsl");
    shader.set("u_resolution", w*1., h*1.);
    mbs  = new float[ATTR * MB];
    pg   = createGraphics(w, h, P2D);
    data = loadTable(path, "header");
    maxRow = data.getRowCount();
    //img = loadImage("earth.jpg");
  }

  public void update() {
    //println(ctr);
    if (ctr >= maxRow-MB)  ctr=0;

    //if (frameCount%60 == 0)
    for (int i = 0; i < MB; i++) {
      TableRow r = data.getRow(ctr++);
      float lat  = r.getFloat("latitude");
      float lon  = r.getFloat("longitude");
      float mag  = r.getFloat("mag");

      lat = map(lat, -90, 90, 0, h);
      lon = map(lon, -180, 180, 0, w);
      mag = map(pow(10, mag), 1000000, 1000000000, 1, 16);
      //println(lon, lat);
      mbs[i*ATTR    ] = lon;
      mbs[i*ATTR + 1] = lat;
      mbs[i*ATTR + 2] = mag;
      mbs[i*ATTR + 3] = 0.;
    }
    shader.set("metaballs", mbs, ATTR);
  }

  public void render() {
    pg.beginDraw();
    //pg.image(img, 0, 0, width, height);
    pg.shader(shader);
    pg.beginShape(QUADS);
    pg.vertex(0, 0);
    pg.vertex(w, 0);
    pg.vertex(w, h);
    pg.vertex(0, h);
    pg.endShape();
    pg.endDraw();
  }
}
