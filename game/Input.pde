void mousePressed() {
  Matchable clickedMatchable = board.lookForMatchable(mouseX, mouseY);
  board.setActiveMatchable(clickedMatchable);
  board.hasSwapped = false;
}

void mouseDragged() {
  if (!board.hasSwapped) {
    Matchable candidateMatchable = board.lookForMatchable(mouseX, mouseY);
    if (board.isValidSwap(candidateMatchable)) {
      board.swap(candidateMatchable);
      MatchChecker.boardOperation(board);
      board.hasSwapped = true;
    };
  }
}