import controlP5.*;

ControlP5 cp5;

PFont font;
PImage img;
PButton button;
ImageData imagedata;

//モードを切り替えるフラグ
boolean drawMode;
boolean imageMode;

ArrayList<path> p;
ArrayList<path> q;

PGraphics player;
PGraphics editer;

float []matrix_value = new float[4];

GL2R f;

plane myp;

void setup() {
  size(1200, 900);

  cp5 = new ControlP5(this); 
  myp=new plane();
  font = createFont("Yu gothic", 20);

  matrix_value[0] = 2;
  matrix_value[1] = 0;
  matrix_value[2] = 1;
  matrix_value[3] = 1;

  f=new GL2R(
    matrix_value[0], matrix_value[1], 
    matrix_value[2], matrix_value[3]
    );

  button = new PButton();

  //最初はお絵かきモード
  drawMode = true;
  imageMode = false;

  //初期化
  init();

  inputField();
}



void draw() {

  background(-1);

  if (mousePressed &&   mouseX > width/2&& mouseY < 600) {
    PVector mouse_pos = new PVector(mouseX- 3*width/4, mouseY - editer.height/2);
    PVector pre_mouse_pos = new PVector(pmouseX- 3*width/4, pmouseY - editer.height/2);
    path new_path = new path(mouse_pos, pre_mouse_pos);
    p.add(new_path);
  }


  editerDraw();

  f=new GL2R(
    matrix_value[0], matrix_value[1], 
    matrix_value[2], matrix_value[3]
    );

  //行列計算
  q = new ArrayList<path>();
  for (int i=0; i<p.size(); i++) {
    q.add(f.moveByMatrix(p.get(i)));
  }

  playerDraw();

  stroke(-1);
  line(width/2, 0, width/2, 600);

  //ボタンを描画
  button.draw();


  noFill();
  stroke(0);
  strokeWeight(10);
  arc(210, 765, 300, 250, -PI/4, PI/4);
  arc(210, 765, 300, 250, 3*PI/4, 5*PI/4);


  arc(210 + 450, 765, 300, 250, -PI/4, PI/4);
  arc(210 + 450, 765, 300, 250, 3*PI/4, 5*PI/4);

  fill(0);
  textAlign(CENTER, CENTER);
  text(matrix_value[0], 210 + 450 - 300/4, 765 - 250/8);
  text(matrix_value[1], 210 + 450 + 300/4, 765 - 250/8);
  text(matrix_value[2], 210 + 450 - 300/4, 765 + 250/8);
  text(matrix_value[3], 210 + 450 + 300/4, 765 + 250/8);
}

void mousePressed() {
  button.mousePressed();
}



/*
 *初期化する関数
 */
void init() {
  p = new ArrayList<path>();
  q = new ArrayList<path>();

  //プレイヤー画面
  player = createGraphics(600, 600);
  player.beginDraw();
  player.background(0);
  player.textFont(font);
  player.textAlign(LEFT, TOP);
  player.fill(-1);
  player.text("player", 10, 10);
  player.endDraw();

  //エディター画面
  editer = createGraphics(600, 600);
  editer.beginDraw();
  editer.background(0);
  editer.textFont(font);
  editer.textAlign(LEFT, TOP);
  editer.fill(-1);
  editer.text("editer", 10, 10);
  editer.endDraw();
}


void editerDraw() {
  //描画した内容を再生
  editer.beginDraw();
  editer.translate(editer.width/2, editer.height/2);

  if (drawMode) {
    editer.background(0);
    editer.strokeWeight(1);
    editer.stroke(-1);
    editer.line(0, -editer.height/2, 0, editer.height/2);
    editer.line(-editer.width/2, 0, editer.width/2, 0);
    editer.strokeWeight(3);
    editer.stroke(200, 200, 255);
    for (path pth : p) {

      float x0 = pth.x0() ;
      float y0 = pth.y0();
      float x1 = pth.x1() ;
      float y1 = pth.y1();

      editer.line(x0, y0, x1, y1);
    }
  }
  editer.fill(-1);
  editer.text("editer", 10 - editer.width/2, 10 - editer.height/2);

  if (imageMode) {

    float width_size = img.width;
    float height_size = img.height;

    if (width_size >= height_size) {
      height_size = map(height_size, 0, width_size, 0, editer.width);
      width_size = editer.width;
    }

    if (width_size < height_size) {
      width_size = map(width_size, 0, height_size, 0, editer.height);
      height_size = editer.height;
    }

    img.resize((int)width_size, (int)height_size);

    editer.imageMode(CENTER);
    editer.image(img, 0, 0);
  }
  editer.endDraw();


  image(editer, width/2, 0);
}

void playerDraw() {

  if (drawMode) {
    player.beginDraw();
    player.translate(editer.width/2, editer.height/2);

    player.background(0);
    player.strokeWeight(1);
    player.stroke(-1);
    player.line(0, -player.height/2, 0, player.height/2);
    player.line(-player.width/2, 0, player.width/2, 0);
    player.stroke(255, 128, 128);
    player.strokeWeight(3);
    for (path pth : q) {

      float x0 = pth.x0();
      float y0 = pth.y0();
      float x1 = pth.x1();
      float y1 = pth.y1();

      player.line(x0, y0, x1, y1);
    }
    player.fill(-1);
    player.text("player", 10 - player.width/2, 10 - player.height/2);
    player.endDraw();
  }

  image(player, 0, 0);
}

void inputField() {

  for (int i = 0; i < 2; i++ ) {
    for (int j = 0; j < 2; j++) {
      cp5.addTextfield("value"+str(j+1)+str(i+1))
        .setPosition(100 + i*120, 700 + 80*j )
        .setSize(100, 50)
        .setFont(font)
        .setAutoClear(false);
    }
  }
}