float framerate = 24;

void setup() {
	size(1024, 768);
	frameRate(framerate);
	background(0);
	stroke(255);
}

void draw() {
	background(0);
	for (var i = 0; i<12; i++){
		rect(random(1024), random(768)-random(12), random(3), random(12));
	}
}