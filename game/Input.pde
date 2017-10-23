boolean hasSwapped = false; ///////////////////////////////////

void mousePressed() {
  Matchable clickedMatchable = board.lookForMatchable(mouseX, mouseY);
  board.setActiveMatchable(clickedMatchable);
  hasSwapped = false;
}

void mouseDragged() {
  if (!hasSwapped) {
    Matchable m2 = board.lookForMatchable(mouseX, mouseY);
    if (board.isValidSwap(m2)) {
      board.swap(m2);
      MatchChecker.boardOperation(board);
      hasSwapped = true;
    };
  }
}