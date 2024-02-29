Keystone ks;
CornerPinSurface smallsurface;
PGraphics smalloffscreen;


void initKeystone() {
  ks = new Keystone(this);
  smallsurface = ks.createCornerPinSurface(1366, 768, 20);
  smalloffscreen = createGraphics(1366, 768, P2D);
}
