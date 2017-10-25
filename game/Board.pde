class Board {
  Matchable[][] board;
  int boardWidth, boardHeight, matchableSize;
  Matchable activeMatchable;
  boolean activeHasSwapped = true;

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

  void attemptSwap(int mx, int my) {
    if (!activeHasSwapped) {
      Matchable candidateMatchable = lookForMatchable(mx, my);
      if (isValidSwap(activeMatchable, candidateMatchable)) {
        swap(activeMatchable, candidateMatchable);
        deselectMatchable(activeMatchable);
        deselectMatchable(candidateMatchable);
        activeMatchable = null;
        activeHasSwapped = true;
      };
    }
  }

  //Matchable Operations

  void selectMatchable(int mx, int my) {
    Matchable clickedMatchable = lookForMatchable(mx, my);
    setActiveMatchable(clickedMatchable);
    activeHasSwapped = false;
  }

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

  boolean isValidSwap(Matchable matchable1, Matchable matchable2) {
    if (matchable2 == null || matchable1 == null || matchable2.c == matchable1.c) {
      return false;
    } else if (isAdjacent(matchable1, matchable2)) {
      return true;
    }
    return false;
  }

  boolean isAdjacent(Matchable matchable1, Matchable matchable2) {
    if (matchable1.x > matchable2.x && matchable1.x < (matchable2.x + 2)) {
      return true; // left -> right swap
    } else if (matchable1.y < matchable2.y && matchable1.y > (matchable2.y - 2)) {
      return true; // down -> up swap
    } else if (matchable1.x < matchable2.x && matchable1.x > (matchable2.x - 2)) {
      return true; // right -> left swap
    } else if (matchable1.y > matchable2.y && matchable1.y < (matchable2.y + 2)) {
      return true; // up -> down swap
    }
    return false;
  }

  void swap(Matchable matchable1, Matchable matchable2) {
    int tempX, tempY;

    tempX = matchable1.x;
    matchable1.x = matchable2.x;
    matchable2.x = tempX;

    tempY = matchable1.y;
    matchable1.y = matchable2.y;
    matchable2.y = tempY;

    updateBoardArrayIndex(matchable1);
    updateBoardArrayIndex(matchable2);
  }

  void updateBoardArrayIndex(Matchable matchable) {
    board[matchable.x][matchable.y] = matchable;
  }

  void deselectMatchable(Matchable matchable) {
    matchable.isClicked = false;
  }
}