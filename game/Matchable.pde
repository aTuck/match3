class Matchable {
  final int POINTS = 10;
  
  int x, y, colorID, boardPos;
  float size;
  boolean isClicked;
  private Color c;

  Matchable(int x, int y, int size, int colorID) {
    this.x = x;
    this.y = y;
    this.size = size;
    this.colorID = colorID;
    c = getColorFromID(colorID);
    boardPos = (y*board.boardWidth) + x; //delete later
  }

  Color getColorFromID(int colorID) {
    if (colorID == 1) {
      return Color.decode("0x50514f");
    } else if (colorID == 2) {
      return Color.decode("0xf25f5c");
    } else if (colorID == 3) {
      return Color.decode("0xffe066");
    } else if (colorID == 4) {
      return Color.decode("0x247ba0");
    } else if (colorID == 5) {
      return Color.decode("0x70c1b3");
    } else if (colorID == 6) {
      return Color.decode("0x6c5b7b");
    } else {
      return Color.decode("0xffffff");
    }
  }
  
  boolean isClicked() {
    return isClicked;
  }
  
  void toggleOn() {
    isClicked = true;
  }
  
  void toggleOff() {
    isClicked = false;
  }
  
  void display() { 
    if (isClicked) {
      strokeWeight(4);
    } else {
      strokeWeight(1);
    }

    fill(c.getRGB());
    rect(x*size, y*size, size, size);
    fill(0);
    text(this.boardPos, x*size+(size/2), y*size+(size/2));
  }
}