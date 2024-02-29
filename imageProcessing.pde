int thresVal = 180;//二値化
int blurVal = 11;//ぼかす

ArrayList<Contour> getContours() {
  opencv.loadImage(kinect.GetDepth());//画像処理に使う画像を渡す
  opencv.gray(); //グレースケール変換
  opencv.blur(blurVal);
  opencv.threshold(thresVal);
  // PImage dst = opencv.getOutput();//二値化した画像出力
  return opencv.findContours();//輪郭抽出処理　専用の型
}
