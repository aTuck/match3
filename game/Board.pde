class Board {
  Matchable[][] board;
  int boardWidth, boardHeight, matchableSize;
  Matchable activeMatchable;

  Board(int x, int y, int size) {
    boardWidth = x;
    boardHeight = y;
    matchableSize = size;
    board = new Matchable[x][y];
  }

  //Board Operations

  void initialize() {
    int thisColor = 0;
    boolean repeats;

    for (int i = 0; i < boardWidth; i++) {
      for (int j = 0; j < boardHeight; j++) {
        do {
          thisColor = (int)random(7);
          repeats = false;
          if (i > 1) {
            if (thisColor == board[i-1][j].colorID) {
              if (thisColor == board[i-2][j].colorID) {
                repeats = true;
              }
            }
          }
          if (j > 1 && !repeats) {
            if (thisColor == board[i][j-1].colorID) {
              if (thisColor == board[i][j-1].colorID) {
                repeats = true;
              }
            }
          }
        } while (repeats);

        board[i][j] = new Matchable(i, j, matchableSize, thisColor);
        board[i][j].display();
      }
    }
  }

  void display() {
    for (int i = 0; i < boardWidth; i++) {
      for (int j = 0; j < boardHeight; j++) {
        board[i][j].display();
      }
    }
  }

  //Matchable Operations

  Matchable lookForMatchable(int x, int y) {
    for (int i = 0; i < boardWidth; i++) {
      for (int j = 0; j < boardHeight; j++) {
        if (x > i*matchableSize && x < (i+1)*matchableSize && y > j*matchableSize && y < (j+1)*matchableSize) {
          return board[i][j];
        }
      }
    }
    return null;
  }

  void setActiveMatchable(Matchable matchable) {
    if (activeMatchable != null) {
      activeMatchable.toggleClicked();
    }
    if (matchable != null) {
      activeMatchable = matchable;
      matchable.toggleClicked();
    }
  }

  void swap(Matchable m) {
    int tx, ty;

    Matchable a = board[m.x][m.y];
    Matchable b = board[activeMatchable.x][activeMatchable.y];

    tx = a.x;
    a.x = b.x;
    b.x = tx;

    ty = a.y;
    a.y = b.y;
    b.y = ty;

    a.isClicked = false;
    b.isClicked = false;

    board[a.x][a.y] = a;
    board[b.x][b.y] = b;

    activeMatchable = null;
    display();
  }

  boolean isValidSwap(Matchable m) {
    if (m == null) {
      return false;
    } else if (activeMatchable == null) {
      return false;
    } else if (m.c == activeMatchable.c) {
      return false;
    } else if (isAdjacent(m)) {
      return true;
    }
    return false;
  }

  private boolean isAdjacent(Matchable m) {
    // left -> right swap
    if (m.x > activeMatchable.x && m.x < (activeMatchable.x + 2)) {
      return true;
    }
    // down -> up swap
    else if (m.y < activeMatchable.y && m.y > (activeMatchable.y - 2)) {
      return true;
    }
    // right -> left swap
    else if (m.x < activeMatchable.x && m.x > (activeMatchable.x - 2)) {
      return true;
    }
    // up -> down swap
    else if (m.y > activeMatchable.y && m.y < (activeMatchable.y + 2)) {
      return true;
    }
    return false;
  }
}