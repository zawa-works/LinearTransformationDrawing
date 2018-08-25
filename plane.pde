class plane {
  int cX, cY;
  int unit;

  plane() {
    cX=0;
    cY=0;
    unit=1;
  }

  int X(float a) {
    return int(cX+a*unit);
  }

  int Y(float a) {
    return int(cY-a*unit);
  }
}