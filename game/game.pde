float framerate = 60;
Board board; 

void setup() {
  size(500, 500);
  frameRate(framerate);
  background(30);
  
  board = new Board(6, 8, 50);
  board.setup();
}

void draw() {
  board.display();
}

void mousePressed(){
  Matchable m1 = board.lookForMatchable(mouseX, mouseY);
  board.setActiveMatchable(m1);
}

void mouseDragged(){
  Matchable m2 = board.lookForMatchable(mouseX, mouseY);
  if(board.validSwap(m2)){
    board.swap(m2);
  };
}

class Board{
  Matchable[][] board;
  int boardWidth, boardHeight, size;
  Matchable activeMatchable;
  
  Board(int x, int y, int size){
    boardWidth = x;
    boardHeight = y;
    this.size = size;
    
    board = new Matchable[x][y];  
  }
  
  void setup(){
    for (int i = 0; i < boardWidth; i++){
      for (int j = 0; j < boardHeight; j++){
        board[i][j] = new Matchable(i, j, size, (int)random(7));
        board[i][j].display();
      }
    }
  }
  
  void display(){
    for (int i = 0; i < boardWidth; i++){
      for (int j = 0; j < boardHeight; j++){
        board[i][j].display();
      }
    }
  }
  
  void swap(Matchable m){
    color temp = m.c;
    m.c = activeMatchable.c;
    activeMatchable.c = temp;
  }
  
  boolean validSwap(Matchable m){
    if (m == null){
      println("m is null");
      return false;
    }
    if(activeMatchable == null){
      println("activeMatchable is null");
    }
    if (m.getX() > activeMatchable.getX()){
      return true;
    }
    return false;
  }
  
  void setActiveMatchable(Matchable m){
    activeMatchable = m;
    m.isClicked();
  }
  
  Matchable lookForMatchable(int x, int y){
    for (int i = 0; i < boardWidth; i++){
      for (int j = 0; j < boardHeight; j++){
        if (x > i*size && x < (i+1)*size && y > j*size && y < (j+1)*size){
          return board[i][j];
        }
      }
    }
    return null;
  }
}

class Matchable{
  int x, y, size;
  boolean isClicked;
  color c;

  Matchable(int x, int y, int size, int c){
    this.x = x;
    this.y = y;
    this.size = size;
    
    if (c == 1){
      this.c = color(255, 0, 0);
    }
    else if (c == 2){
      this.c = color(0, 255, 0);
    }
    else if (c == 3){
      this.c = color(0, 0, 255);
    }
    else if (c == 4){
      this.c = color(0, 255, 255);
    }
    else if (c == 5){
      this.c = color(255, 0, 255);
    }
    else if (c == 6){
      this.c = color(255, 255, 0);
    }
    else{
      this.c = color(255);
    }
  }
  
  int getX(){
    return this.x;
  }
  int getY(){
    return this.y;
  }
  void isClicked(){
    isClicked = true;
  }
  
  void display(){
    fill(c);
    rect(x*size, y*size, size, size);
  }
}