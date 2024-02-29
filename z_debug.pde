void drawDebugText() {
  textAlign(CENTER);
  fill(255);
  textSize(20);
  text("scene: "+ scene, width/2, height-100, 0);
  text("gage: "+ gageR+ " / "+ width, width/2, height-50, 0);
  text(frameRate, width/2-200, height-50, 0);
}

void drawDebugMode() {
  //動作確認のためのコード
  smalloffscreen.background(0);
  smalloffscreen.image(kinect.GetDepth(), 0, 0, smalloffscreen.width, smalloffscreen.height);
  smalloffscreen.pushStyle();
  
  contours = getContours();
  smalloffscreen.fill(255);
  smalloffscreen.text(contours.size(), 100, 100);
  smalloffscreen.text(blurVal, 100, 200);
  smalloffscreen.text(thresVal, 100, 300);
  smalloffscreen.popStyle();  

  for (Contour contour : contours) {//配列の長さ分まわす　毎回contoursをcontourに代入
    float sumX=0;
    float sumY=0;
    smalloffscreen.noFill();
    smalloffscreen.stroke(255);
    smalloffscreen.beginShape();
    for (PVector point : contour.getPolygonApproximation().getPoints()) {//輪郭のポイント一つ一つをまわす
      smalloffscreen.vertex(point.x, point.y);
      sumX += point.x;
      sumY += point.y;
    }
    smalloffscreen.endShape(CLOSE);
    int pointsNum = contour.getPolygonApproximation().numPoints();
    PVector center = new PVector(sumX/pointsNum, sumY/pointsNum);//ポイントの平均
    smalloffscreen.stroke(255, 0, 0);
    //fill(205, 161, 111);
    smalloffscreen.stroke(116, 80, 48);
    smalloffscreen.strokeWeight(3);

    /*
      ellipse(width/2, height/2, 500, 500);
     ellipse(width/2, height/2, 375, 375);
     ellipse(width/2, height/2, 250, 250);
     ellipse(width/2, height/2, 125, 125);
     */


    //シーンに行くための判定
    smalloffscreen.stroke(255, 0, 0, 100);
    smalloffscreen.strokeWeight(3);
    smalloffscreen.ellipse(50, 50, 50, 50);//全体の長さが第三、第四引数の値！半径ではない！半径は1/2！

    smalloffscreen.pushStyle();
    smalloffscreen.fill(255, 0, 0);
    smalloffscreen.ellipse(center.x, center.y, 30, 30);
    smalloffscreen.popStyle();

    float d = dist(center.x, center.y, 50, 50);  //後半は円の座標を入れてあげる 座標
    if (d < 50 / 2) {   //円の半径を指定してあげる！　円の直径/2
      scene = 2;
    }
    /*
      float d = dist(center.x, center.y, width / 2, height / 2);
     if (d < 125 / 2) {
     scene = 2;
     }
     */
  }
}
