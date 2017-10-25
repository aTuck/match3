void mousePressed() {
  board.selectMatchable(mouseX, mouseY);
}

void mouseDragged() {
  board.attemptSwap(mouseX, mouseY);
  //MatchChecker.boardOperation(b, candidateMatchable);
}