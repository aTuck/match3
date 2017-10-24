class Board {
  Matchable[][] board;
  int boardWidth, boardHeight, matchableSize;
  Matchable activeMatchable;
  boolean hasSwapped = false;

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

  boolean isValidSwap(Matchable candidateMatchable) {
    if (candidateMatchable == null ||
      activeMatchable == null ||
      candidateMatchable.c == activeMatchable.c) {
      return false;
    } else if (activeMatchable.isAdjacent(candidateMatchable)) {
      return true;
    }
    return false;
  }

  void swap(Matchable candidateMatchable) {
    activeMatchable.swap(candidateMatchable);

    updateBoardArrayIndex(activeMatchable);
    updateBoardArrayIndex(candidateMatchable);

    activeMatchable = null;
    display();
  }

  void updateBoardArrayIndex(Matchable matchable) {
    board[matchable.x][matchable.y] = matchable;
  }
}