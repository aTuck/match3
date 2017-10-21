float framerate = 60;

void setup() {
	size(1500, 1500);
	frameRate(framerate);
	background(76, 76, 140)
	noStroke();
	noLoop();
}

void draw() {
  drawCircle(width/2, height/2, 420, 9);
}

void drawCircle(int x, int y, int radius, int level) {  
  float mod = (frameCount%120f)/100f;
  float tt = 126 * level/4.0;
  
  noStroke();
  fill(tt+120, tt-45, 0);
  ellipse(x, y, radius*2, radius*2);      
  if(level-- > 1) {
    drawCircle(x - radius/2, y, radius/2, level);
    drawCircle(x + radius/2, y, radius/2, level);
	drawCircle(x, y - radius/2, radius/2, level);
    drawCircle(x, y + radius/2, radius/2, level);
  }
}
void drawRect(int x, int y, int radius, int level) {  
  float mod = (frameCount%120f)/100f;
  float tt = 126 * level/4.0;
  
  noStroke();
  fill(tt+120, tt-45, 0);
  rect(x, y, radius*2, radius*2);      
  if(level-- > 1) {
    drawRect(x - radius/2, y, radius/2, level);
    drawRect(x + radius/2, y, radius/2, level);
	drawRect(x, y - radius/2, radius/2, level);
    drawRect(x, y + radius/2, radius/2, level);
  }
}