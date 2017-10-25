class MatchChecker {
  Matchable[][] boardArray;
  final int DOWN = 1;
  final int RIGHT = 1;
  final int UP = -1;
  final int LEFT = -1;
  ArrayList<Matchable> hMatch = new ArrayList<Matchable>();
  ArrayList<Matchable> vMatch = new ArrayList<Matchable>();
  
  MatchChecker(Board board) {
    boardArray = board.board;
  }

  void checkForMatches(Matchable m) {
    hMatch.clear();
    vMatch.clear();
    
    findHorizontalMatch(m, RIGHT);
    findHorizontalMatch(m, LEFT); 

    findVerticalMatch(m, DOWN);
    findVerticalMatch(m, UP);

    println("h");
    for (Matchable mm : hMatch) {
      println(mm.boardPos);
    }
    println("v");
    for (Matchable mm : vMatch) {
      println(mm.boardPos);
    }
    println();
  }

  void findHorizontalMatch(Matchable m, int i) {
    if (i > 0) { //if going right
      if (m.x + i >= board.boardWidth) { //check out of bounds
        return;
      }
    } else if (i < 0) { //if going left
      if (m.x + i < 0) { // check out of bounds
        return;
      }
    }
    if (boardArray[m.x + i][m.y].colorID != m.colorID) { //check colour
      return;
    }
    m = boardArray[m.x + i][m.y];
    hMatch.add(m);
    findHorizontalMatch(m, i);
  }

  void findVerticalMatch(Matchable m, int i) {
    if (i > 0) { //if going down
      if (m.y + i >= board.boardHeight) { //check out of bounds
        return;
      }
    } else if (i < 0) { //if going up
      if (m.y + i < 0) { // check out of bounds
        return;
      }
    }
    if (boardArray[m.x][m.y + i].colorID != m.colorID) { //check colour
      return;
    }
    m = boardArray[m.x][m.y + i];
    vMatch.add(m);
    findVerticalMatch(m, i);
  }

  boolean isMatches(){
    if (hMatch.size() >= 2 || vMatch.size() >= 2){
      return true;
    }
    return false;
  }
}