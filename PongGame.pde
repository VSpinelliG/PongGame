import processing.serial.*;

Serial myPort;
String val;
int strPort;
String str;
float ballX = 350;
float ballY = 200;
float ballR = 10;
float dX = random(1, 2);
float dY = random(1, 2);
float paddleXLeft; //Ponto localizado no canto inferior direito da barra esquerda
float paddleYLeft = 10; //Ponto localizado no canto inferior direito da barra esquerda
float paddleXRight; //Ponto localizado no canto inferior esquerdo da barra direita
float paddleYRight = 10; //Ponto localizado no canto inferior esquerdo da barra direita
float paddleW = 10; 
float paddleH = 50; //Altura da barra
int score1 = 0;
int score2 = 0;
int frameR = 80;
boolean ballColision = true; //Se for true acabou de colidir na esquerda

void setup() {
  print(Serial.list());
  String portName = Serial.list()[0];
  myPort = new Serial(this, portName, 3600);
  size(700, 450);
  paddleXLeft = 5;
  paddleXRight = width - 15;
  frameRate(frameR);
}
 
void draw() {
  
  background(100, 100, 100);
  textSize(26);
  text(score1, 250, 30);
  text(score2, 450, 30);
  scale(1, -1);
  translate(0, -height);
  stroke(255);
  line(350,0,350,450);
  stroke(0);
  ellipse(ballX, ballY, 2 * ballR, 2 * ballR);
  
  //line(paddleXRight,0,paddleXRight,400); //Linha da esquerda
  //line(paddleXRight,paddleYRight,paddleXLeft, paddleYLeft); //Linha de baixo
  //line(paddleXRight,paddleYRight+paddleH,paddleXLeft, paddleYLeft+paddleH); //Linha de cima
  //line(paddleW/2, 200, paddleW/2, 250);
  //line(ballX+ballR, 0, ballX+ballR, 400);
  //point(paddleXRight, 0);
  //point(paddleXLeft, 0);
  //point(0, paddleYRight);
  //point(0, paddleYLeft);
 
  rect(paddleXLeft, paddleYLeft, paddleW, paddleH);
  rect(paddleXRight, paddleYRight, paddleW, paddleH);
  
  /*if ( myPort.available() > 0) {  
    val = myPort.readStringUntil('\n');
    if ( val != null ) {
      print(val);
      //paddleYRight = float(val);
      paddleYLeft = float(val);
    }
  }*/
  
  if((myPort != null) && (myPort.available()>0)) { //Integrando ao arduino, pegando os valores dos potenciômetros
    String message = myPort.readStringUntil('\n');
    //print(message);
    String[] num = split(message, ' ');
    if(message != null) {
      //int value = int(message.trim());
      //print(value, "\n");
      paddleYLeft = map(float(num[0]),0,1024,0, height); //map() converte os valores do potênciometro para as coordenadas da tela
      paddleYRight = map(float(num[1]),0,1024,0, height);
    }
  }
  
  if (score1 != 7 && score2 != 7) { //Conferindo se há algum player que já fez 7 pontos
    if (ballRight() > width && ballColision) {
      ++score1;
      dX = -dX;
      ballColision = false;
    }
    
    if (ballLeft() < 0 && !ballColision) {
      ++score2;
      dX = -dX;
      ballColision = true;
    }
    
   //Para os três seguintes if, se houver colisão a direção da bola será invertida
    if (collision()) {
      dX = -dX; 
    }
   
    if (ballTop() > height) {
      dY = -dY; 
    }
   
    if (ballBottom() < 0) {
      dY = -dY;
    }
    
    //Movimento da bola
    ballX = ballX + dX;
    ballY = ballY + dY;
    
  }else{ //Caso o jogo não tenha encerrado ainda
    scale(1, -1);
    translate(0, -height);
    if (score1 == 7){
      text("Player 1 venceu!", 100, 100);
    }else{
      text("Player 2 venceu!", 450, 100);
    }
    noLoop();
  }
}

//A seguinte função fere alguns conceitos de clean code mediante a duplicação de código.
boolean collision() { //Função que trata das colisões da bola
  boolean returnValue = false;
  if ((ballRight() > paddleXRight) && ballColision) { //Se houver colisão na parede (ponto) à direita
    if ((ballBottom()-2 < paddleYRight + paddleH) && (ballTop()+2 > paddleYRight)) { //Se houver colisão nas partes superior e inferior direita
      ballColision = false;
      returnValue = true;
      frameR = frameR + 50; //Aumentado a velocidade da bola
      frameRate(frameR); 
    }
   }
    
  if ((ballLeft() < paddleXLeft+paddleW) && !ballColision) { //Se houver colisão na parede (ponto) à esquerda
    if ((ballBottom()-2 < paddleYLeft + paddleH) && (ballTop()+2 > paddleYLeft)) { //Se houver colisão nas partes superior e inferior esquerda
      ballColision = true;
      returnValue = true;
      frameR = frameR + 50;
      frameRate(frameR);
    }
  }
  return returnValue;
}
 
float ballLeft() { //Valor do lado esquerdo da bola
  return ballX - ballR;
}
 
float ballRight() { //Valor do lado direito da bola
  return ballX + ballR;
}
 
float ballTop() { //Valor do topo da bola
  return ballY + ballR;
}
 
float ballBottom() { //Valor de baixo da bola
  return ballY - ballR;
}

/*void keyPressed() {
  if (key == CODED) {
    if (keyCode == UP && paddleYRight < (height-paddleH)) {
      paddleYRight = paddleYRight + paddleH;
      paddleYLeft = paddleYLeft + paddleH;
    } else if (keyCode == DOWN && paddleYRight > paddleH) {
      paddleYRight = paddleYRight - paddleH;
      paddleYLeft = paddleYLeft - paddleH;
    }
  } 
}*/
