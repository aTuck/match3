class Board {
  Matchable[][] board;
  int boardWidth, boardHeight, matchableSize, score;
  Matchable activeMatchable;
  boolean activeHasSwapped = true;
  ArrayList<Matchable> matchCheckerQueue = new ArrayList<Matchable>();

  int counter = 0;

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
        counter = 0;
        println("\n\nAttempting swap...");

        boolean isMatches;

        swap(activeMatchable, candidateMatchable);
        isMatches = (matchChecker.checkForMatches(activeMatchable) || matchChecker.checkForMatches(candidateMatchable));

        if (!isMatches) {
          println("...swapped back");
          swap(activeMatchable, candidateMatchable);
          return;
        } else {
          checkAndClearMatches(activeMatchable);
          checkAndClearMatches(candidateMatchable);

          activeMatchable.toggleOff();
          candidateMatchable.toggleOff();
          activeHasSwapped = true;
          activeMatchable = null;
        }
      }
      while (matchCheckerQueue.size() > 0) {
        Matchable m = popMatchableFromQueue();
        println("Checking from queue for: "+ m);
        checkAndClearMatches(m);
      }
    }
  }
  
  Matchable popMatchableFromQueue() {
    Matchable tempMatchable = matchCheckerQueue.get(0);
    matchCheckerQueue.remove(0);
    return tempMatchable;
  }
  
  void checkAndClearMatches(Matchable m) {
    println("Checking matches for: "+m);
    if (matchChecker.checkForMatches(m)) {
      for (Matchable mm : matchChecker.matchSet) {
        println("Pulling down from: "+mm);
        score += mm.POINTS;
        pullDown(board[mm.x][mm.y]);
      }
    }
    println("...done checkAndclear()");
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
  
  void updateBoardArrayIndex(Matchable matchable) {
    board[matchable.x][matchable.y] = matchable;
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
  
  void pullDown(Matchable m) {
    println("Pulldown #"+counter++);
    if (m == null) {
      return;
    }
    if (m.y-1 < 0 || board[m.x][m.y] == null) {
      Matchable temp = new Matchable(m.x, m.y, matchableSize, (int)random(7));
      board[m.x][m.y] = temp;
      println("Created new matchable: " + temp);
      matchCheckerQueue.add(temp);
      return;
    } else {
      Matchable aboveMatchable;
      aboveMatchable = board[m.x][m.y-1];
      matchCheckerQueue.add(aboveMatchable);
      pullDown(aboveMatchable);
  
      aboveMatchable.y++;
      updateBoardArrayIndex(aboveMatchable);
    }
  }
}