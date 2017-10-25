void mousePressed() {
  board.selectMatchable(mouseX, mouseY);
}

void mouseDragged() {
  board.attemptSwap(mouseX, mouseY);
}