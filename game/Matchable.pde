class Matchable {
  int x, y, size, colorID, boardPos;
  boolean isClicked;

  private color c;

  // Default
  Matchable() {
    x = 0;
    y = 0;
    size = 0;
    colorID = 0;
    boardPos = 0;
    isClicked = false;
  }

  // Copy constructor
  Matchable(Matchable aMatchable) {
    this(aMatchable.x, aMatchable.y, aMatchable.size, aMatchable.colorID);
  }

  // Paramterized
  Matchable(int x, int y, int size, int c) {
    this.x = x;
    this.y = y;
    this.size = size;
    this.colorID = c;
    boardPos = (y*board.boardWidth) + x;

    if (c == 1) {
      this.c = color(255, 0, 0);
    } else if (c == 2) {
      this.c = color(0, 255, 0);
    } else if (c == 3) {
      this.c = color(0, 0, 255);
    } else if (c == 4) {
      this.c = color(0, 255, 255);
    } else if (c == 5) {
      this.c = color(255, 0, 255);
    } else if (c == 6) {
      this.c = color(255, 255, 0);
    } else {
      this.c = color(255);
    }
  }

  void toggleClicked() {
    isClicked = !isClicked;
  }

  boolean isClicked() {
    return isClicked;
  }

  void display() { 
    if (isClicked) {
      strokeWeight(4);
    } else {
      strokeWeight(1);
    }

    fill(c);
    rect(x*size, y*size, size, size);
    fill(0);
    
    text(this.boardPos, x*size+(size/2), y*size+(size/2));
  }
}