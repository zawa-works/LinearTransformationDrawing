/*
 *フォルダから画像を選択させる
 */

void selectImage() {
  selectInput("フォルダから画像を指定してください:", "selectImage");
}

/*
 *画像を選択したときに処理される関数
 *ファイルが画像でなければもう一度選択させる
 */

void selectImage(File selection) {

  if (selection == null) {
    println("Window was closed or the user hit cancel.");
    return;
  } 

  //取得したファイルパス
  String imagePath = selection.getAbsolutePath();

  if (loadImage(imagePath) == null) {
    println("対応している画像ファイルではありません");
    selectInput("もう一度画像ファイルを指定してください:", "selectImage");
    return;
  }

  //画像読み込み
  img = loadImage(imagePath);
  imageMode = true;
  drawMode = false;
  imagedata = new ImageData(img);

  player = imagedata.graphics();

  println("User selected " + selection.getAbsolutePath());
}