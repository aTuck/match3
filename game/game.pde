import java.awt.Color;
import java.util.concurrent.TimeUnit;

Board board;
MatchChecker matchChecker;
PFont f;
int lastTime = 0;

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
  
  matchChecker = new MatchChecker(board);
}

void draw() {
  background(30);
  board.display();
  int currentTime = millis();

  if (currentTime > lastTime+100) {
    
    lastTime = currentTime;
  }
  
}