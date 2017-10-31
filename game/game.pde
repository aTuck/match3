import java.awt.Color;
import java.util.concurrent.TimeUnit;

Board board;
MatchChecker matchChecker;
PFont f;
int lastTime = 0;
boolean isTime = false;
Timer t = new Timer();

void setup() {
  final float FRAMERATE = 60;
  final int BOARD_SIZE = 9;
  final int MATCHABLE_SIZE = 50;
  

  size(500, 500);
  frameRate(FRAMERATE);
  
  strokeWeight(1);
  
  f = createFont("Arial", 16, true);
  
  board = new Board(BOARD_SIZE, BOARD_SIZE, MATCHABLE_SIZE);
  board.initialize();

  
  t.start();
  
  matchChecker = new MatchChecker(board);
}

void draw() {
  background(30);
  board.display();
  board.animateMatchables();
  textFont(f, 29);
  fill(255,0,0);
  text("0"+t.hour()+":0"+t.minute()+":"+t.second(), 350, 480);
}

int timer(int timerLength) {
  int remainingTime = timerLength-millis();
 
  if(remainingTime/1000>0){
    int actualTime = (remainingTime/1000);
    return actualTime;
   }
  else {
    isTime = false;
    return 0;     
  }
}