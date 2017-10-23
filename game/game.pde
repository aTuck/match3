float framerate = 60;
boolean hasSwapped = false;
Board board; 


void setup() {
  size(500, 500);
  frameRate(framerate);
  background(30);
  strokeWeight(1);
  
  board = new Board(9, 9, 50);
  board.setup();
}

void draw() {
  board.display();
}

void mousePressed(){
  Matchable m1 = board.lookForMatchable(mouseX, mouseY);
  board.setActiveMatchable(m1);
  hasSwapped = false;
}

void mouseDragged(){
  if(!hasSwapped)
  {
    Matchable m2 = board.lookForMatchable(mouseX, mouseY);
    if(board.isValidSwap(m2)){
      board.swap(m2);
      hasSwapped = true;
    };
  }
}

class Board{
  Matchable[][] board;
  int boardWidth, boardHeight, matchableSize;
  Matchable activeMatchable;
  
  Board(int x, int y, int size){
    boardWidth = x;
    boardHeight = y;
    matchableSize = size;
    
    board = new Matchable[x][y];  
  }
  
  void setup(){
    int thisColor = 0;
    int lastColor = 0;
    int repeats   = 0;
    
    for (int i = 0; i < boardWidth; i++){
      for (int j = 0; j < boardHeight; j++){
        do {
          thisColor = (int)random(7);
          if (thisColor == lastColor){
            repeats++;
          }
          else{
            repeats = 0;
          }
          lastColor = thisColor;
        } while (repeats > 1 || (i>0 && (board[i-1][j].colorID != thisColor)));
        
        board[i][j] = new Matchable(i, j, matchableSize, thisColor);
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
    int tx, ty, tsize, tc;
    
    //Matchable temp = new Matchable();
    //temp = board[m.x][m.y];
    //board[m.x][m.y] = board[activeMatchable.x][activeMatchable.y];
    //board[activeMatchable.x][activeMatchable.y] = temp;
    
    Matchable a = board[m.x][m.y];
    Matchable b = board[activeMatchable.x][activeMatchable.y];
    
    tx = a.x;
    a.x = b.x;
    b.x = tx;
    
    ty = a.y;
    a.y = b.y;
    b.y = ty;
    
    tsize = a.size;
    a.size = b.size;
    b.size = tsize;
    
    tc = a.colorID;
    a.colorID = b.colorID;
    b.colorID = tc;
    
    a.isClicked = false;
    b.isClicked = false;
    
    board[a.x][a.y] = new Matchable(b.x, b.y, b.size, b.colorID);
    board[b.x][b.y] = new Matchable(a.x, a.y, a.size, a.colorID);
    
    activeMatchable = null;
    display();
  }
  
  boolean isValidSwap(Matchable m){
    if (m == null){
      return false;
    }
    else if (activeMatchable == null){
      return false;
    }
    else if (m.c == activeMatchable.c){
      return false;
    }
    else if (isAdjacent(m)){
      return true;
    }
    return false;
  }
  
  private boolean isAdjacent(Matchable m){
    // left -> right swap
    if(m.x > activeMatchable.x && m.x < (activeMatchable.x + 2)){
      return true;
    }
    // down -> up swap
    else if (m.y < activeMatchable.y && m.y > (activeMatchable.y - 2)){
      return true;
    }
    // right -> left swap
    else if (m.x < activeMatchable.x && m.x > (activeMatchable.x - 2)){
      return true;
    }
    // up -> down swap
    else if(m.y > activeMatchable.y && m.y < (activeMatchable.y + 2)){
      return true;
    }
    return false;
  }
  
  void setActiveMatchable(Matchable m){
    if (activeMatchable != null){activeMatchable.toggleClicked();}
    activeMatchable = m;
    m.toggleClicked();
  }
  
  Matchable lookForMatchable(int x, int y){
    for (int i = 0; i < boardWidth; i++){
      for (int j = 0; j < boardHeight; j++){
        if (x > i*matchableSize && x < (i+1)*matchableSize && y > j*matchableSize && y < (j+1)*matchableSize){
          return board[i][j];
        }
      }
    }
    return null;
  }
}

class Matchable{
  int x, y, size, colorID;
  boolean isClicked;
  
  private color c;
  
  // Default
  Matchable(){
    x = 0;
    y = 0;
    size = 0;
    colorID = 0;
    isClicked = false;
  }
  
  // Copy constructor
  Matchable(Matchable aMatchable){
    this(aMatchable.x, aMatchable.y, aMatchable.size, aMatchable.colorID);
    println("made a copy");
  }
  
  // Paramterized
  Matchable(int x, int y, int size, int c){
    this.x = x;
    this.y = y;
    this.size = size;
    this.colorID = c;
    
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
  
  void toggleClicked(){
    isClicked = !isClicked;
  }
  
  boolean isClicked(){
    return isClicked;
  }
  
  void display(){ 
    if(isClicked){
      strokeWeight(4);
    }
    else{
      strokeWeight(1);
    }
    
    fill(c);
    rect(x*size, y*size, size, size);
    fill(0);
    text(colorID, x*size+(size/2), y*size+(size/2));

  }
}