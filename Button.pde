/*
*ボタンを作成
 */

class PButton {

  int mode_posx;
  int mode_posy;
  int value_posx;
  int value_posy;
  int size_x;
  int size_y;

  PButton() {
    mode_posx = 900;
    mode_posy = 650;
    value_posx = 380;
    value_posy = 730;
    size_x = 100;
    size_y = 50;
  }

  /*
   *ボタンを描画 
   */
  void draw() {
    drawModeButton(mode_posx, mode_posy, size_x, size_y);
    imageModeButton(mode_posx+120, mode_posy, size_x, size_y);
    valueInputButton(value_posx, value_posy, size_x, size_y);
  }


  void drawModeButton(float x, float y, float size_x, float size_y) {

    pushMatrix();
    pushStyle();

    strokeWeight(2);
    stroke(#00aaff);
    if (rangeOfButton(x, y, size_x, size_y)) {
      fill(255, 0, 0);
    } else {
      fill(0, 0, 255);
    }

    rect(x, y, size_x, size_y);

    textAlign(CENTER, CENTER);
    textFont(font);
    fill(-1);
    text("お絵かき", x+size_x/2, y+size_y/2);

    popStyle();
    popMatrix();
  }

  void imageModeButton(float x, float y, float size_x, float size_y) {

    pushMatrix();
    pushStyle();
    strokeWeight(2);
    stroke(#00aaff);
    if (rangeOfButton(x, y, size_x, size_y)) {
      fill(255, 0, 0);
    } else {
      fill(0, 0, 255);
    }

    rect(x, y, size_x, size_y);

    textAlign(CENTER, CENTER);
    textFont(font);
    fill(-1);
    text("画像", x+size_x/2, y+size_y/2);

    popStyle();
    popMatrix();
  }

  void valueInputButton(float x, float y, float size_x, float size_y) {

    pushMatrix();
    pushStyle();
    strokeWeight(2);
    stroke(#00aaff);

    textAlign(CENTER, CENTER);
    textSize(50);
    if (rangeOfButton(x, y, size_x, size_y)) {
      fill(255, 0, 0);
      rect(x, y, size_x, size_y);
      fill(-1);
      text("＝", x+size_x/2, y+size_y/3);
    } else {
      fill(-1);
      rect(x, y, size_x, size_y);
      fill(0);
      text("＝", x+size_x/2, y+size_y/3);
    }



    popStyle();
    popMatrix();
  }


  /*
   *マウスイベントで使う関数
   */

  void mousePressed() {
    drawModeChange(mode_posx, mode_posy, size_x, size_y);
    imageModeChange(mode_posx+120, mode_posy, size_x, size_y);
    setMatrixValue(value_posx, value_posy, size_x, size_y);
  }


  void drawModeChange(float x, float y, float size_x, float size_y) {
    if (rangeOfButton(x, y, size_x, size_y)) {
      img = null;
      drawMode = true;
      imageMode = false;

      //お絵かきを初期化
      p = new ArrayList<path>();
      q = new ArrayList<path>();
    }
  }


  void imageModeChange(float x, float y, float size_x, float size_y) {
    if (rangeOfButton(x, y, size_x, size_y) ) {
      selectImage();
    }
  }

  void setMatrixValue(float x, float y, float size_x, float size_y) {
    if (rangeOfButton(x, y, size_x, size_y)) {
      String []values = new String[4];
      boolean value_change = true;

      for (int i = 0; i < 2; i++ ) {

        if (!value_change)break;

        for (int j = 0; j < 2; j++) {
          values[j+i*2] = cp5.get(Textfield.class, "value"+str(j+1)+str(i+1)).getText();

          if (values[j+i*2] != null)continue;
          value_change = false;
          break;
        }
      }

      if (value_change)matrix_value = float(values);
    }
  }

  boolean rangeOfButton(float x, float y, float size_x, float size_y) {
    float left_x = x;
    float right_x = x + size_x;
    float top_y = y;
    float bottom_y = y + size_y;

    return mouseX > left_x && mouseX < right_x&& mouseY > top_y && mouseY < bottom_y;
  }
}