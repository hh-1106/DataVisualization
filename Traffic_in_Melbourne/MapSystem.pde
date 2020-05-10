import de.fhpotsdam.unfolding.*;
import de.fhpotsdam.unfolding.geo.*;
import de.fhpotsdam.unfolding.utils.*;
import de.fhpotsdam.unfolding.providers.*;


class MapSystem {
  UnfoldingMap map;

  MapSystem(PApplet P) {
    // init
    map = new UnfoldingMap(P);  // style
    MapUtils.createDefaultEventDispatcher(P, map);

    // zooming & panning the map
    Location melbourneLocation = new Location(-37.817, 144.956);
    map.zoomAndPanTo(15, melbourneLocation);
    // restrictions
    map.setZoomRange(13, 19);
    map.setPanningRestriction(melbourneLocation, 2);   // km

    map.setTweening(true);
  }

  void show() {
    tint(80, 100);
    map.draw();
  }
}
