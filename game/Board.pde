class Board {
  Matchable[][] board;
  int boardWidth, boardHeight, matchableSize, score;
  Matchable activeMatchable;
  boolean activeHasSwapped = true;
  ArrayList<Matchable> matchCheckerQueue = new ArrayList<Matchable>();
  
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
      }
    }
  }

  void display() {
    for (int i = 0; i < boardWidth; i++) {
      for (int j = 0; j < boardHeight; j++) {
        if (board[i][j] != null) {
          board[i][j].display();
        }
      }
    }
    textFont(f, 16);
    fill(255);
    text(""+score, 250, 480); 
  }


  //Matchable Operations
  void attemptSwap(int mx, int my) {
    if (!activeHasSwapped) {
      Matchable candidateMatchable = lookForMatchable(mx, my);
      if (isValidSwap(activeMatchable, candidateMatchable)) {
        boolean isMatches;
        
        swap(activeMatchable, candidateMatchable);
        isMatches = (matchChecker.checkForMatches(activeMatchable) || matchChecker.checkForMatches(candidateMatchable));
        
        if (!isMatches){
          swap(activeMatchable, candidateMatchable);
          return;
        }
        else{
          for (Matchable m : matchChecker.hMatch){
            score += m.POINTS;
          }
          for (Matchable m : matchChecker.vMatch){
            score += m.POINTS;
          }
          activeMatchable.toggleOff();
          candidateMatchable.toggleOff();
          
          activeHasSwapped = true;
          
          matchCheckerQueue.add(activeMatchable);
        //matchCheckerQueue.add(candidateMatchable);
        handleMatches();
        
          activeMatchable = null;
        }
      };
    }
  }

  void handleMatches() {
    Matchable currMatchable;
    while (matchCheckerQueue.size() > 0) {
      currMatchable = popMatchableFromQueue();
      matchChecker.checkForMatches(currMatchable);
      if (matchChecker.hasMatches()) {
        
        //kinda works maybe
        //matchChecker.queueAffectedMatchables(currMatchable);
        
        matchChecker.deleteMatches();
        deleteMatchable(currMatchable);
        
        //TODO: move down ()
        
      }
    }
  }
  
  void queueAffectedMatchable(Matchable matchable) {
    for (int i = 0; i < matchable.y; i++) {
      matchCheckerQueue.add(board[matchable.x][i]);
    }
    
  }

  void deleteMatchable(Matchable m) {
    board[m.x][m.y] = null;
  }

  Matchable popMatchableFromQueue() {
    Matchable tempMatchable = matchCheckerQueue.get(0);
    matchCheckerQueue.remove(0);
    return tempMatchable;
  }

  void selectMatchable(int mx, int my) {
    Matchable clickedMatchable = lookForMatchable(mx, my);
    setActiveMatchable(clickedMatchable);
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
      activeMatchable.toggleOff();
    }
    if (matchable != null) {
      activeMatchable = matchable;
      matchable.toggleOn();
      activeHasSwapped = false;
    }
  }

  boolean isValidSwap(Matchable matchable1, Matchable matchable2) {
    if (matchable2 == null || matchable1 == null || matchable2.c == matchable1.c) {
      return false;
    }
    if (isAdjacent(matchable1, matchable2)) {
      return true;
    }
    return false;
  }

  boolean isAdjacent(Matchable matchable1, Matchable matchable2) {
    if (matchable1.x > matchable2.x && matchable1.x < (matchable2.x + 2) && matchable1.y == matchable2.y) {
      return true; // left -> right swap
    } else if (matchable1.y < matchable2.y && matchable1.y > (matchable2.y - 2) && matchable1.x == matchable2.x) {
      return true; // down -> up swap
    } else if (matchable1.x < matchable2.x && matchable1.x > (matchable2.x - 2) && matchable1.y == matchable2.y) {
      return true; // right -> left swap
    } else if (matchable1.y > matchable2.y && matchable1.y < (matchable2.y + 2) && matchable1.x == matchable2.x) {
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
}