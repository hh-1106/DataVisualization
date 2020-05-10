String[] names = {
  "Town_Hall-West",
  "Collins Place-South",
  "Australia on Collins",
  "Bourke Street Mall-South",
  "Bourke Street Mall-North",
  "Melbourne Central",
  "Flagstaff Station",
  "State Library",
  "Collins Place-North",
  "Southern Cross Station",
  "Victoria Point",
  "New Quay",
  "Waterfront City",
  "Webb Bridge",
  "Birrarung Marr",
  "Princes Bridge",
  "Flinders St Station Underpass",
  "Sandridge Bridge"
};

Location[] ls = {
  new Location(-37.815056, 144.966909),
  new Location(-37.814304, 144.972648),
  new Location(-37.815712, 144.965110),
  new Location(-37.813808, 144.964563),
  new Location(-37.812701, 144.959704),
  new Location(-37.810056, 144.962754),
  new Location(-37.812138, 144.955995),
  new Location(-37.809809, 144.965190),
  new Location(-37.812620, 144.972577),
  new Location(-37.818285, 144.952775),
  new Location(-37.818556, 144.946919),
  new Location(-37.814519, 144.942702),
  new Location(-37.815423, 144.939177),
  new Location(-37.823352, 144.947305),
  new Location(-37.818752, 144.974262),
  new Location(-37.819240, 144.968346),
  new Location(-37.818301, 144.967080),
  new Location(-37.820034, 144.963055)
};

void setFont() {
  //String[] fontList = PFont.list();
  //printArray(fontList);
  PFont font = createFont("Lot", 48);
  textFont(font);
  textAlign(CENTER, CENTER);
}

void fps() {
  String txt_fps = String.format("[frame %d]   [fps %6.2f]", frameCount, frameRate);
  surface.setTitle(txt_fps);
}
