class Matchable {
  int x, y, colorID, boardPos;
  float size;
  boolean isClicked;
  private color c;

  Matchable(int x, int y, int size, int colorID) {
    this.x = x;
    this.y = y;
    this.size = size;
    this.colorID = colorID;
    c = getColorFromID(colorID);
    boardPos = (y*board.boardWidth) + x; //delete later
  }

  color getColorFromID(int colorID) {
    if (colorID == 1) {
      return color(255, 0, 0);
    } else if (colorID == 2) {
      return color(0, 255, 0);
    } else if (colorID == 3) {
      return color(0, 0, 255);
    } else if (colorID == 4) {
      return color(0, 255, 255);
    } else if (colorID == 5) {
      return color(255, 0, 255);
    } else if (colorID == 6) {
      return color(255, 255, 0);
    } else {
      return color(255);
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

  private boolean isAdjacent(Matchable otherMatchable) {
    if (otherMatchable.x > this.x && otherMatchable.x < (this.x + 2)) {
      return true; // left -> right swap
    } else if (otherMatchable.y < this.y && otherMatchable.y > (this.y - 2)) {
      return true; // down -> up swap
    } else if (otherMatchable.x < this.x && otherMatchable.x > (this.x - 2)) {
      return true; // right -> left swap
    } else if (otherMatchable.y > this.y && otherMatchable.y < (this.y + 2)) {
      return true; // up -> down swap
    }
    return false;
  }

  void swap(Matchable otherMatchable) {
    int tempX, tempY;

    tempX = this.x;
    this.x = otherMatchable.x;
    otherMatchable.x = tempX;

    tempY = this.y;
    this.y = otherMatchable.y;
    otherMatchable.y = tempY;

    this.isClicked = false;
    otherMatchable.isClicked = false;
  }
}