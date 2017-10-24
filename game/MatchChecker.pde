static class MatchChecker {
  static void boardOperation(Board board, Matchable m) {
    ArrayList<Matchable> hMatch = new ArrayList<Matchable>();
    ArrayList<Matchable> vMatch = new ArrayList<Matchable>();
    Matchable[][] b = board.board;
    int lastColor, startPos, endPos;
    
    if (m.x-2 >= 0){
      startPos = m.x-2;
    }
    else if (m.x-1 >= 0){
      startPos = m.x-1;
    }
    else{
      startPos = m.x;
    }
    
    if (m.x+2 < board.boardWidth){
      endPos = m.x+2;
    }
    else if (m.x+1 < board.boardWidth){
      endPos = m.x+1;
    }
    else{
      endPos = m.x;
    }

    lastColor = 0;
    for (int i = startPos; i <= endPos; i++){
      // First check
      if (i == startPos){
        lastColor = b[i][m.y].colorID;
        hMatch.add(b[i][m.y]);
      }
      // Matches last color
      else if (b[i][m.y].colorID == lastColor){
        hMatch.add(b[i][m.y]);  
      }
      // Doesn't match
      else{
        lastColor = b[i][m.y].colorID;
        hMatch.clear();
        hMatch.add(b[i][m.y]);
      }
      if (hMatch.size() >= 3){
        fallDown(hMatch);
        break;
      }
    }
    
    //for (int j = m.y-3; j < m.y+2; j++){
    //  if (board.board[i][j] != null){
        
    //  }
    }
  }
  
  static void fallDown(ArrayList<Matchable> match){
    for (int i = 0; i < match.size(); i++){
      println("my match: "+match.get(i).boardPos);
    }
  }