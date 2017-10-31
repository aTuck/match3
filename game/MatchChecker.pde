class MatchChecker {
  Matchable[][] boardArray;
  final int DOWN = 1;
  final int RIGHT = 1;
  final int UP = -1;
  final int LEFT = -1;
  private ArrayList<Matchable> hMatch = new ArrayList<Matchable>();
  private ArrayList<Matchable> vMatch = new ArrayList<Matchable>();

  Matchable willBePowerup;
  ArrayList<Matchable> matchSet;

  MatchChecker(Board board) {
    boardArray = board.board;
  }

  boolean checkForMatches(Matchable m) {
    hMatch.clear();
    vMatch.clear();

    findHorizontalMatch(m, RIGHT);
    findVerticalMatch(m, UP); //!important: up before down
    findHorizontalMatch(m, LEFT);
    findVerticalMatch(m, DOWN);

    if (hMatch.size() >= 2 || vMatch.size() >= 2) {
      mergeIntoMatchSet(m);
      return true;
    }
    return false;
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

  void mergeIntoMatchSet(Matchable m) {
    matchSet= new ArrayList<Matchable>();
    //for (Matchable mm : hMatch) {
    //  println("hMatch: " + mm.boardPos);
    //}
    //for (Matchable mm : vMatch) {
    //  println("vMatch: " + mm.boardPos);
    //}
    willBePowerup = m;
    // Both vertical and horizontal matches
    if (hMatch.size() >= 2 && vMatch.size() >= 2) {
      matchSet.add(m);
      for (Matchable mm : hMatch) {
        println("Merging: " + mm.boardPos);
        matchSet.add(mm);
      }
      for (Matchable mm : vMatch) {
        println("Merging: " + mm.boardPos);
        matchSet.add(mm);
      }
    }
    // Just horizontal
    else if (hMatch.size() >= 2 && vMatch.size() < 2) {
      hMatch.add(m);
      matchSet = hMatch;
    }
    // Just vertical
    if (vMatch.size() >= 2 && hMatch.size() < 2) {
      vMatch.add(m);
      matchSet = vMatch;
    }
    if (matchSet.size() >= 4){
      makePowerup(m);
    }
    
    // Clear a whole row
    if (m.isPowerup4){
      println("ROW CLEAR!");
      matchSet.clear();
      for (int y = 0; y < board.boardWidth; y++){
        matchSet.add(board.board[m.x][y]);
      }
    }
    // Clear all of one color
    else if (m.isPowerup5){
      println ("COLOR CLEAR!");
      matchSet.clear();
      for (int i = 0; i < board.boardWidth; i++) {
        for (int j = 0; j < board.boardHeight; j++) {
          if (board.board[i][j].colorID == m.colorID){
            matchSet.add(board.board[i][j]);
          }
        }
      }
    } 
  }
  
  void makePowerup(Matchable m){
    int powerLevel = matchSet.size();
    matchChecker.matchSet.remove(m);
    m.turnIntoPowerup(powerLevel);
  }
}