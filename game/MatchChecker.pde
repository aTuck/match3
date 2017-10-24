static class MatchChecker {
  static void boardOperation(Board board, Matchable m) {
    ArrayList<Matchable> hMatch = new ArrayList<Matchable>();
    ArrayList<Matchable> vMatch = new ArrayList<Matchable>();
    Matchable[][] b = board.board;
    int lastColor = 0;
    
    for (int i = m.x-2; i < m.x+4; i++){
      if (board.board[i][m.y] != null){
        // First check
        if (i == m.x-2){
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
          b[i][m.y].c = (0);
        }
      }
      if (hMatch.size() > 3){
        fallDown(hMatch);
        break;
      }
      for (int j = m.y-3; j < m.y+2; j++){
        if (board.board[i][j] != null){
          
        }
      }
    }
  }
  
  static void fallDown(ArrayList<Matchable> match){
    for (int i = 0; i < match.size(); i++){
      match.get(i).c = (0);
    }
  }
}