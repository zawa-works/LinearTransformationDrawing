class GL2R {
  float a, b, c, d;
  GL2R(float _a, float _b, float _c, float _d) {
    a=_a;
    b=_b;
    c=_c;
    d=_d;
  }
  
  boolean isGL2R() {
    if(a*d-b*c!=0) return true;
    else return false;
  }
  
  PVector moveByMatrix(PVector v) {
    return new PVector(a*(v.x)+b*(v.y),c*(v.x)+d*(v.y));
  }
  
  path moveByMatrix(path pth) {
    PVector q0 = moveByMatrix(pth.p0);
    PVector q1 = moveByMatrix(pth.p1);
    path q = new path(q0,q1);
    return q;
  }

}