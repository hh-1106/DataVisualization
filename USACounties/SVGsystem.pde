import geomerative.*;           //<>//

public class SVGSystem {
  County USA;
  Table data;
  public String selectedID = " ", pselectedID = " ";
  boolean highlighting = false;

  SVGSystem(PApplet P, String path) {
    RG.init(P);
    USA = new County(RG.loadShape(path));
    loadChildren();
  }

  public void show() {
    for (County c : USA.counties) {
      pushMatrix();
      if (mode3) {
        c.lerpTo3d();
        translate(0, 0, c.cz);
      }else{
        c.backTo2d();
        translate(0, 0, c.cz);
      }
      //println(c.name, c.num, c.rate);
      c.show();
      popMatrix();
    }
  }
    
  // Inspired by Kanvases
  public void highlight() {

    County c1 = null;
    County c2 = null;
    for (County c : USA.counties) {
      if (c.H.contains(mouseX+svgW-width*0.5, mouseY+svgH-height*0.5)) {
        selectedID = c.name;
        c1 = c;
        highlighting = true;
        //println("selected!", c1, c1.pos.x, c1.pos.y);
        //break;
      } else {
        c.sCol = -1;
      }
    }

    if (!highlighting)  selectedID = "-1";

    if (selectedID != pselectedID) {
      c2 = findCountyByName(pselectedID);
      //println(c2);
      if (c2 != null) {
        c2.H.scale(0.5, c2.pos);
        //c2.scl = 0.5;
      }
      if (c1 != null) {
        c1.H.scale(2, c1.pos);
        //c1.scl = 2;
      }
      pselectedID = selectedID;
    }

    if (c1 != null) {
      //println(c1, c2);
      c1.sCol = color(70, 100, 100);
      c1.sWt = 3;
      c1.showText();
      //c1.H.draw();
    }

    //println(c1, c2);
  }

  private County findCountyByName(String n) {
    for (County c : USA.counties) {
      if (c.name == n)
        return c;
    }
    return null;
  }


  private void loadChildren() {
    data = loadTable(csvPath, "header");
    for (TableRow row : data.rows()) {

      String id = row.getString("1") + row.getString("2");
      String name = row.getString("3");
      float num = row.getFloat("7");
      float rate = row.getFloat("8");

      // println(id, name, num, rate);

      RShape r = USA.getChildById(id);
      if (r != null) {
        County c = new County(r, name, num, rate);
        USA.counties.add(c);
      }
    }
    //println(USA.children.size());
  }
}
