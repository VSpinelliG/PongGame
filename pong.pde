float ballX = 20;
float ballY = 20;
float ballR = 10;
float dX = random(1, 2);
float dY = random(1, 2);
float paddleX;
float paddleY = 10;
float paddleW = 10;
float paddleH = 30;
int score1 = 0;
int score2 = 0;
float difficulty = 1.5;
int speed = 2;
int frameR = 80; 
 
void setup() {
  size(700, 400);
  paddleX = width - 15;
  frameRate(frameR);
}
 
void draw() {
  background(100, 100, 100);
  text(score1, 310, 30);
  text(score2, 390, 30);
  scale(1, -1);
  translate(0, -height);
  ellipse(ballX, ballY, 2 * ballR, 2 * ballR);
 
  rect(paddleX, paddleY, paddleW, paddleH);
 
  if (ballRight() > width) {
    ++score1;
    dX = -dX;
  }
 
  if (collision()) {
    dX = -dX; // if dX == 2, it becomes -2; if dX is -2, it becomes 2
  }
 
  if (ballLeft() < 0) {
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
}
 
boolean collision() {
  boolean returnValue = false; // assume there is no collision
  if ((ballRight() >= paddleX) && (ballLeft() <= paddleX + paddleW)) {
    if ((ballBottom() >= paddleY) && (ballTop() <= paddleY + paddleH)) {
      returnValue = true;
      frameR = frameR + 20;
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
      paddleY = paddleY + paddleH;
    } else if (keyCode == DOWN) {
      paddleY = paddleY - paddleH;
    }
  }
}
