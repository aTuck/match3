Board board;

void setup() {
  final float FRAMERATE = 60;
  final int BOARD_SIZE = 9;
  final int MATCHABLE_SIZE = 20;

  size(500, 500);
  frameRate(FRAMERATE);
  background(30);
  strokeWeight(1);

  board = new Board(BOARD_SIZE, BOARD_SIZE, MATCHABLE_SIZE);
  board.initialize();
}

void draw() {
  board.display();
}