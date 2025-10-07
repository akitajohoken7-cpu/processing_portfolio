void setup() {
  size(1000, 600);
  noStroke();
}

float pieceX = 170;  // かけらの初期位置
float pieceY = 170;
float progress = 0;  // 進行度 0〜1

// 棒人間の座標（変数で管理）
float stickX = 900;
float stickY = 550;

void draw() {
  background(255);

  // ===== アンパンマンの体 =====
  fill(0);
  rect(490, 300, 400, 50); //軸棒
  rect(560, 310, 20, 220); //右腕
  rect(560, 110, 20, 220); //左腕
  
  fill(255);
  rect(760, 323, 128, 3);//足の境目分断線
  
  fill(175, 45, 45);
  rect(530, 260, 270, 130); // マント

  // == アンパンマンの顔 ==
  fill(255, 200, 150);
  ellipse(300, 300, 500, 500); 

  // 目
  fill(0);
  ellipse(240, 230, 60, 90); 
  ellipse(360, 230, 60, 90); 
  fill(255);
  ellipse(230, 210, 20, 20); 
  ellipse(350, 210, 20, 20); 

  // 鼻
  fill(255, 80, 80);
  ellipse(300, 330, 110, 110);
  fill(255, 200, 200);
  ellipse(320, 300, 30, 20); 

  // ほっぺ
  fill(255, 100, 100);
  ellipse(170, 330, 120, 120);
  ellipse(430, 330, 120, 120);

  // 口
  fill(0);
  ellipse(300, 430,120,12);

  // ===== 棒人間 =====
  stickhuman(stickX, stickY);

  // ===== 吹き出し =====
  humancall(800, 350, "I am hungry.\nHelp me, Anpanman!");

  // ===== かけらのアニメーション =====
  progress += 0.01; // 進行度を増やす
  progress = min(progress, 1);

  float targetX, targetY;

  if (progress < 0.5) {
    // 棒人間に向かうフェイク
    targetX = lerp(pieceX, stickX, progress*2);
    targetY = lerp(pieceY, stickY - 50, progress*2);
  } else {
    // アンパンマンの口に向かう
    targetX = lerp(stickX, 300, (progress-0.5)*2);
    targetY = lerp(stickY - 50, 430, (progress-0.5)*2);
  }

  // かけらを描く
  anpan(targetX, targetY);
}

// ========================
// かけら（アンパン）描画
// ========================
void anpan(float x, float y) {
  // 外側
  fill(255, 210, 160);  
  stroke(0);
  beginShape();
  vertex(x, y);
  bezierVertex(x + 50, y - 20, x + 60, y + 30, x + 20, y + 40);
  bezierVertex(x - 10, y + 50, x - 30, y + 10, x, y);
  endShape(CLOSE);

  // 中の餡子
  fill(90, 20, 50);
  noStroke();
  beginShape();
  vertex(x + 5, y + 5);
  bezierVertex(x + 35, y - 5, x + 40, y + 25, x + 15, y + 30);
  bezierVertex(x - 5, y + 30, x - 10, y + 10, x + 5, y + 5);
  endShape(CLOSE);
}

// ========================
// 棒人間描画
// ========================
void stickhuman(float x, float y) {
  stroke(0);
  strokeWeight(3);
  line(x, y, x, y-50);
  ellipse(x, y-70, 30, 30);
  line(x, y-50, x-20, y-20);
  line(x, y-50, x+20, y-20);
  line(x, y, x-15, y+30);
  line(x, y, x+15, y+30);
}

// ========================
// 吹き出し
// ========================
void humancall(float x, float y, String msg) {
  fill(255);
  stroke(0);
  strokeWeight(2);
  rect(x, y, 200, 80, 20);
  triangle(x+50, y+80, x+80, y+80, x+70, y+100);

  fill(0);
  textSize(18);
  text(msg, x+20, y+25, 160, 60); // ←はみ出さないように範囲指定
}
