Board board;

void setup() {
  final float framerate = 60;
  final int boardSize = 9;
  final int matchableSize = 50;

  size(500, 500);
  frameRate(framerate);
  background(30);
  strokeWeight(1);

  board = new Board(boardSize, boardSize, matchableSize);
  board.initialize();
}

void draw() {
  board.display();
}