class path {
  PVector p0;
  PVector p1;

  path() {
    p0 = new PVector();
    p1 = new PVector();
  }

  path(PVector v0, PVector v1) {
    p0 = v0;
    p1 = v1;
  }

  float x0() {
    return p0.x;
  }

  float x1() {
    return p1.x;
  }

  float y0() {
    return p0.y;
  }

  float y1() {
    return p1.y;
  }

  void drawPath() {
    line(p0.x, p0.y, p1.x, p1.y);
  }
}