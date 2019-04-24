float ballX = 350;
float ballY = 200;
float ballR = 10;
float dX = random(1, 2);
float dY = random(1, 2);
float paddleXLeft;
float paddleYLeft = 10;
float paddleXRight;
float paddleYRight = 10;
float paddleW = 10;
float paddleH = 50;
int score1 = 0;
int score2 = 0;
int frameR = 80; 
 
void setup() {
  size(700, 400);
  paddleXLeft = 5;
  paddleXRight = width - 15;
  frameRate(frameR);
}
 
void draw() {
  background(100, 100, 100);
  text(score1, 310, 30);
  text(score2, 390, 30);
  scale(1, -1);
  translate(0, -height);
  ellipse(ballX, ballY, 2 * ballR, 2 * ballR);
 
  rect(paddleXLeft, paddleYLeft, paddleW, paddleH);
  rect(paddleXRight, paddleYRight, paddleW, paddleH);
  
  if (score1 != 7 && score2 != 7) {
    if (ballRight() > width) {
      ++score1;
      dX = -dX;
    }
    
    if (ballLeft() < 0) {
      ++score2;
      dX = -dX;
    }
   
    if (collision()) {
      dX = -dX; // if dX == 2, it becomes -2; if dX is -2, it becomes 2
    }
   
    if (ballBottom() > height) {
      dY = -dY; // if dY == 2, it becomes -2; if dY is -2, it becomes 2
    }
   
    if (ballTop() < 0) {
      dY = -dY; // if dY == 2, it becomes -2; if dY is -2, it becomes 2
    }
   
    ballX = ballX + dX;
    ballY = ballY + dY;
  }else{
    scale(1, -1);
    translate(0, -height);
    if (score1 == 7){
      text("Player 1 venceu!", 310, 100);
    }else{
      text("Player 2 venceu!", 310, 100);
    }
    noLoop();
  }
}
 
boolean collision() {
  boolean returnValue = false; // assume there is no collision
  if ((ballRight() >= paddleXLeft) && (ballLeft() <= paddleXLeft + paddleW) || (ballLeft() <= paddleXRight) && (ballRight() >= paddleXRight)) {
    if ((ballBottom() >= paddleYLeft) && (ballTop() <= paddleYLeft + paddleH) || (ballBottom() >= paddleYRight) && (ballTop() <= paddleYRight + paddleH)) {
      returnValue = true;
      frameR = frameR + 10;
      frameRate(frameR);
    }
  }
  return returnValue;
}
 
float ballLeft() {
  return ballX - ballR;
}
 
float ballRight() {
  return ballX + ballR;
}
 
float ballTop() {
  return ballY - ballR;
}
 
float ballBottom() {
  return ballY + ballR;
}
 
// based on code from http://processing.org/reference/keyCode.html
void keyPressed() {
  if (key == CODED) {
    if (keyCode == UP) {
      paddleYRight = paddleYRight + paddleH;
      paddleYLeft = paddleYLeft + paddleH;
    } else if (keyCode == DOWN) {
      paddleYRight = paddleYRight - paddleH;
      paddleYLeft = paddleYLeft - paddleH;
    }
  }
}
