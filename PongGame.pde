float ballX = 350;
float ballY = 200;
float ballR = 10;
float dX = random(1, 2);
float dY = random(1, 2);
float paddleXLeft; //ponto localizado no canto inferior direito da barra esquerda
float paddleYLeft = 10; //ponto localizado no canto inferior direito da barra esquerda
float paddleXRight; //ponto localizado no canto inferior esquerdo da barra direita
float paddleYRight = 10; //ponto localizado no canto inferior esquerdo da barra direita
float paddleW = 10; //
float paddleH = 50; //altura da barra
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
  stroke(0);
  line(350,0,350,400);
  //line(paddleXRight,0,paddleXRight,400); //linha da esquerda
  //line(paddleXRight,paddleYRight,paddleXLeft, paddleYLeft); //linha de baixo
  //line(paddleXRight,paddleYRight+paddleH,paddleXLeft, paddleYLeft+paddleH); //linha de cima
  //line(paddleW/2, 200, paddleW/2, 250);
  line(ballX+ballR, 0, ballX+ballR, 400);
  point(paddleXRight, 0);
 
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
   
    if (ballTop() > height) {
      dY = -dY; // if dY == 2, it becomes -2; if dY is -2, it becomes 2
    }
   
    if (ballBottom() < 0) {
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
  //if ((ballRight() >= paddleXLeft) && (ballLeft() <= paddleXLeft + paddleW) || (ballLeft() <= paddleXRight) && (ballRight() >= paddleXRight)) {
  if ((ballLeft() < paddleXLeft+paddleW) || (ballRight() > paddleXRight)) {
    //if ((ballBottom() >= paddleYLeft) && (ballTop() <= paddleYLeft + paddleH) || (ballBottom() >= paddleYRight) && (ballTop() <= paddleYRight + paddleH)) {
    if ((ballBottom() >= paddleYLeft) && (ballTop() <= paddleYLeft + paddleH) || (ballBottom() >= paddleYRight) && (ballTop() <= paddleYRight + paddleH)) {
      returnValue = true;
      //frameR = frameR + 10;
      //frameRate(frameR);
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
  return ballY + ballR;
}
 
float ballBottom() {
  return ballY - ballR;
}
 
// based on code from http://processing.org/reference/keyCode.html
void keyPressed() {
  if (key == CODED) {
    if (keyCode == UP && paddleYRight <= (height-paddleH)) {
      paddleYRight = paddleYRight + paddleH;
      paddleYLeft = paddleYLeft + paddleH;
    } else if (keyCode == DOWN && paddleYRight >= paddleH) {
      paddleYRight = paddleYRight - paddleH;
      paddleYLeft = paddleYLeft - paddleH;
    }
  }
}
