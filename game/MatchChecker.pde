class MatchChecker {
  Matchable[][] boardArray;

  MatchChecker(Board board) {
    boardArray = board.board;
  }

  void checkForMatches(Matchable m) {
    ArrayList<Matchable> hMatch = new ArrayList<Matchable>();
    ArrayList<Matchable> vMatch = new ArrayList<Matchable>();
    //Matchable[][] b = board.board;
    //int xLastColor, yLastColor, xStartPos, xEndPos, yStartPos, yEndPos;
    //boolean isNewCol;

    int goRightOrDown = 1;
    int goLeftOrUp = -1;

    findHorizontalMatch(m, goRightOrDown, hMatch); //Right
    findHorizontalMatch(m, goLeftOrUp, hMatch); //Left

    for (Matchable mm : hMatch) {
      println(mm.boardPos);
    }
    println("\n\n");


    //// Horizontal index out of bounds prevention
    //if (m.x-2 >= 0) {
    //  xStartPos = m.x-2;
    //} else if (m.x-1 >= 0) {
    //  xStartPos = m.x-1;
    //} else {
    //  xStartPos = m.x;
    //}

    //if (m.x+2 < board.boardWidth) {
    //  xEndPos = m.x+2;
    //} else if (m.x+1 < board.boardWidth) {
    //  xEndPos = m.x+1;
    //} else {
    //  xEndPos = m.x;
    //}

    //// Vertical index out of bounds prevention
    //if (m.y-2 >= 0) {
    //  yStartPos = m.y-2;
    //} else if (m.y-1 >= 0) {
    //  yStartPos = m.y-1;
    //} else {
    //  yStartPos = m.y;
    //}

    //if (m.y+2 < board.boardHeight) {
    //  yEndPos = m.y+2;
    //} else if (m.y+1 < board.boardHeight) {
    //  yEndPos = m.y+1;
    //} else {
    //  yEndPos = m.y;
    //}


    //xLastColor = 0;
    //yLastColor = 0;
    //// Horizontal matches
    //for (int i = xStartPos; i <= xEndPos; i++) {
    //  isNewCol = true;
    //  // First check
    //  if (i == xStartPos) {
    //    xLastColor = b[i][m.y].colorID;
    //    hMatch.add(b[i][m.y]);
    //  }
    //  // Matches last color
    //  else if (b[i][m.y].colorID == xLastColor) {
    //    hMatch.add(b[i][m.y]);
    //  }
    //  // Doesn't match
    //  else {
    //    xLastColor = b[i][m.y].colorID;
    //    hMatch.clear();
    //    hMatch.add(b[i][m.y]);
    //  }
    //  if (hMatch.size() >= 3) {
    //    fallDown(hMatch, "h");
    //    break;
    //  }
    //  // Vertical matches
    //  for (int j = yStartPos; j <= yEndPos; j++) {
    //    if (isNewCol) {
    //      vMatch.clear(); 
    //      isNewCol = false;
    //    }
    //    // First check
    //    if (j == yStartPos) {
    //      yLastColor = b[i][j].colorID;
    //      vMatch.add(b[i][j]);
    //    }
    //    // Matches last color
    //    else if (b[i][j].colorID == yLastColor) {
    //      vMatch.add(b[i][j]);
    //    }
    //    // Doesn't match
    //    else {
    //      yLastColor = b[i][j].colorID;
    //      vMatch.clear();
    //      vMatch.add(b[i][j]);
    //    }
    //    if (vMatch.size() >= 3) {
    //      fallDown(vMatch, "v");
    //      break;
    //    }
    //  }
    //}
  }

  void findHorizontalMatch(Matchable m, int i, ArrayList<Matchable> hMatch) {
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
    findHorizontalMatch(m, i, hMatch);
  }

  Matchable getHorzMatchable(Matchable m, int j) {
    return boardArray[m.x + j][m.y];
  }

  void fallDown(ArrayList<Matchable> match, String dir) {
    for (int i = 0; i < match.size(); i++) {
      println("my "+dir+" match: "+match.get(i).boardPos);
    }
  }
}