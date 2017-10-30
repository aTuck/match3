class Matchable {
  final int POINTS = 10;
  
  int x, y, colorID, boardPos;
  float size, pixelX, pixelY;
  boolean isClicked, isPowerup4, isPowerup5, isExploding;
  private Color c;

  Matchable(int x, int y, int size, int colorID) {
    this.x = x;
    this.y = y;
    this.pixelX = x;
    this.pixelY = y;
    this.size = size;
    this.colorID = colorID;
    this.isPowerup4 = false;
    this.isPowerup5 = false;
    c = getColorFromID(colorID);
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
      return Color.decode("0xeeeeee");
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
  
  void turnIntoPowerup(int lv){
    if (lv == 4){
      isPowerup4 = true;
    }
    else if (lv >= 5){
      isPowerup5 = true;
    }
  }
  
  void setPos(){
    boardPos = this.y+1;
  }
  
  void explode(){
    isExploding = true;
  }
  
  void display() { 
    if (isClicked) {
      strokeWeight(4);
    } else {
      strokeWeight(1);
    }

    fill(c.getRGB());
    rect(size*pixelX, size*pixelY, size, size);
    if (isPowerup4){
      fill(0);
      rect((size*pixelX)+10, (size*pixelY)+10, size-20, size-20);
    }
    if (isPowerup5){
      fill(0);
      rect((size*pixelX)+10, (size*pixelY)+10, size-20, size-20);
      fill(255);
      rect((size*pixelX)+15, (size*pixelY)+15, size-30, size-30);
    }
  }
}