//ゲージの変数
float gageR = 0;
float gageW = 0;
float gageG = 0;
int countgage = 0;

/***
 * ゲージの初期化
 */
void initGage() {
  gageR = 0;
  gageW = 0;
  gageG = 0;
}

/***
 * ゲージの更新
 */
void updateGage(float d) {
  float gageSpeedplus = 10;
  float gageSpeedminus = 15;


  //if (d < 125 / 2 && gageR < width) {  //この範囲のときに人がいると作動する これは円の中心からの距離が125/2未満のとき
  if (d < 125 && gageR < smalloffscreen.width) {  //この範囲のときに人がいると作動する これは円の中心からの距離が125/2未満のとき
    //↑範囲かつゲージがその長さ未満のときは長さを増やしていくそれ以上のときはとまる
    /*
        locksyoki = 1;  //ロックさせて反応したらそのままにしとく
     */
    gageR += gageSpeedplus;
  } else if (gageR > 0 && countgage > 40) {

    gageR -= gageSpeedminus;
  }
  if (d < 125 && gageW < smalloffscreen.width) {  //この範囲のときに人がいると作動する これは円の中心からの距離が125/2未満のとき
    //↑範囲かつゲージがその長さ未満のときは長さを増やしていくそれ以上のときはとまる
    //locksyoki = 1;  //ロックさせて反応したらそのままにしとく
    gageW += gageSpeedplus;
  } else if (gageW > 0 && countgage > 40) {

    gageW -= gageSpeedminus;
  }
  if (d < 125 && gageG < smalloffscreen.width) {  //この範囲のときに人がいると作動する これは円の中心からの距離が125/2未満のとき
    //↑範囲かつゲージがその長さ未満のときは長さを増やしていくそれ以上のときはとまる
    //locksyoki = 1;  //ロックさせて反応したらそのままにしとく
    gageG += gageSpeedplus;
  } else if (gageG > 0 && countgage > 40) {

    gageG -= gageSpeedminus;
    countgage = 0;
  } else {
    countgage ++ ;
  }
}

/***
 * ゲージの描画
 */
void drawGage() {
  //赤
  if (gageR <  smalloffscreen.width) { //gage+=4と、初期設定のゲージ枠の座標を見て範囲を決めてる
    smalloffscreen.fill(205, 42, 62);
    smalloffscreen.noStroke();
    smalloffscreen.rect(0, smalloffscreen.height*0/3, gageR, smalloffscreen.height*1/3); //ゲージ 画面サイズに合わせている
  }
  //白
  if (gageW <  smalloffscreen.width) { //gage+=4と、初期設定のゲージ枠の座標を見て範囲を決めてる
    smalloffscreen.fill(255);
    smalloffscreen.noStroke();
    smalloffscreen.rect(0, smalloffscreen.height*1/3, gageW, smalloffscreen.height*2/3); //ゲージ 画面サイズに合わせている
  }
  //緑
  if (gageG <  smalloffscreen.width) { //gage+=4と、初期設定のゲージ枠の座標を見て範囲を決めてる
    smalloffscreen.fill(67, 111, 77);
    smalloffscreen.noStroke();
    smalloffscreen.rect(0, smalloffscreen.height*2/3, gageG, smalloffscreen.height*3/3); //ゲージ 画面サイズに合わせている
  }

  //println(height);
  //println();

  if (gageR >= smalloffscreen.width) {  //RWGは今一緒にしてるのでRだけにしてる
    /*
        if (myMovie.available()) {
     myMovie.read(); //映像を読み取る
     }
     image(myMovie, 0, 0, width, height); //image関数で映像を表示
     */
    myMovie.play();
    scene = 3;
  }
}
