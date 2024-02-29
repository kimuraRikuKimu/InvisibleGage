import deadpixel.keystone.*;
import processing.video.*;
//import processing.net.*;
import gab.opencv.*;
import kinect4WinSDK.Kinect;
import kinect4WinSDK.SkeletonData;

//画像処理の定数
final int POSTERIZE_PARAM = 3;
Movie myMovie;
Kinect kinect;
OpenCV opencv;

PImage img;

ArrayList<Contour> contours;//可変長配列用　
ArrayList<PVector> points;//輪郭のポイントを格納
//変える場所
int scene;


void setup() {
  //size(512, 424);
  fullScreen(P2D);
  initKeystone();
  initGage();
  scene = 2;
  
  //画像のサイズをフルスクリーンにする
  //img  = loadImage("onsen1.jpg");
  img  = loadImage("onsen99999.png");
  //img.filter(POSTERIZE, POSTERIZE_PARAM); // POSTERIZE_PARAMを増やしたり減らすと綺麗になるかも！
  //img.filter(GRAY);      //画像ｉｍｇをグレイスケール画像に変換する。１画素の赤成分、緑成分、青成分は同じ値になる。
  img.resize(width, height);

  myMovie = new Movie( this, "onsen99999.mp4"); //動画を読み込みMovie変数「myMovie」に格納
  kinect = new Kinect(this);
  //赤外線取ってきていれる
  opencv = new OpenCV(this, kinect.GetDepth().width, kinect.GetDepth().height);//領域の指定
  points = new ArrayList<PVector>();
  //myMovie.play();
  frameRate(30);
  //kinect.run();
}

void draw() {
  println("scene: ", scene);
  println("gage: ", gageR, " / ", width);
  smalloffscreen.beginDraw();

  if (scene == 1) {
    drawDebugMode();
  } else if (scene == 2) {
    smalloffscreen.background(0);
    contours = getContours();
    smalloffscreen.image(img, 0, 0);
    println("contours: ", contours.size());
    for (Contour contour : contours) {//配列の長さ分まわす　毎回contoursをcontourに代入
      float sumX=0;
      float sumY=0;
      for (PVector point : contour.getPolygonApproximation().getPoints()) {//輪郭のポイント一つ一つをまわす
        sumX += point.x;
        sumY += point.y;
      }

      int pointsNum = contour.getPolygonApproximation().numPoints();
      PVector center = new PVector(sumX/pointsNum, sumY/pointsNum);//ポイントの平均

      //img.filter(POSTERIZE, POSTERIZE_PARAM); // POSTERIZE_PARAMを増やしたり減らすと綺麗になるかも！
      //image(img, 0, 0);

      /*
      pushStyle();//ポイント表示のためのコード
       fill(255, 0, 0);
       ellipse(center.x, center.y, 30, 30);
       popStyle();
       */

      float d = dist(center.x, center.y, 512/2, 424/2);
      /*
      if (locksyoki == 1) {  //ロックさせて反応したらそのままにしとく
       fill(255, 255, 255);
       //stroke(0, 0, 0);
       //strokeWeight(5);
       noStroke();
       rect(50, height/2-50, width, 50); //画面サイズに合わせている
       }
       */
      updateGage(d);
    }
    drawGage();
  } else if (scene == 3) {
    smalloffscreen.background(255);
    
    if (abs(myMovie.duration() - myMovie.time()) < 0.1) {
      initGage();
      scene = 2;
      myMovie.jump(0);
      myMovie.stop();
    }
    smalloffscreen.image(myMovie, 0, 0, smalloffscreen.width, smalloffscreen.height); //image関数で映像を表示
  }
  smalloffscreen.endDraw();
  background(0);

  drawDebugText();
  smallsurface.render(smalloffscreen);
}



void keyPressed() {
  if (key == 'w') thresVal = constrain(thresVal+10, 1, 255);
  if (key == 's') thresVal = constrain(thresVal-10, 1, 255);
  if (key == 'a') blurVal = constrain(blurVal-5, 1, 50);
  if (key == 'd') blurVal = constrain(blurVal+5, 1, 50);
  if (key == '1') scene = 1;
  if (key == '2') scene = 2;
  if (key == 'c') ks.toggleCalibration();
  println("threshold:" + thresVal + ", blur:" + blurVal);
  println("------------------------------");
}

void movieEvent(Movie m) {
  m.read();
}

void exit() {
  if (myMovie != null) {
    myMovie.stop();
  }
  super.exit();
}
