class ImageData {
  PImage img;
  PVector [][]pos;
  PVector [][]new_pos;
  color [][] c;

  ImageData(PImage _img) {
    img = _img;

    setData();
    calcMatrix();
  }

  //カラーデータと座標を記録
  void setData() {
    pos = new PVector[img.width][img.height];
    new_pos = new PVector[img.width][img.height];

    c = new color[img.width][img.height];

    for (int i = 0; i < img.width; i++) {
      for (int j = 0; j < img.height; j++) {

        pos[i][j] = new PVector(i-300, j-300);
        c[i][j] = img.get(i, j);
      }
    }
  }


  //ベクトルを演算
  void calcMatrix() {

    for (int i = 0; i < img.width; i++) {
      for (int j = 0; j < img.height; j++) {

        new_pos[i][j] = f.moveByMatrix(pos[i][j]);
      }
    }
  }

  PGraphics graphics() {
    PGraphics  g = createGraphics(600, 600);

    g.beginDraw();

    g.translate(g.width/2, g.height/2);

    g.background(0);
    for (int i = 0; i < img.width; i++) {
      for (int j = 0; j < img.height; j++) {
        float x = new_pos[i][j].x;
        float y = new_pos[i][j].y;


        g.stroke(c[i][j]);
        g.point(x, y);
      }
    }
    g.endDraw();

    return g;
  }
}