//a lot of the math all taken from an example written by Keith Peters

float[] x = new float[80]; //array
float[] y = new float[80];
float segLength = 5;

void setup() {
  size(800, 500);
  //strokeWeight(9);
  stroke(95, 255, 0);
}

void draw() {
  background(51, 0, 51);
  //background circles
  pushStyle();
  strokeWeight(0);
  fill(66, 0, 90);
  ellipse(mouseX, 60, 600, 600);    // Top circle
  popStyle();
  pushStyle();
  fill(51, 0, 102);
  strokeWeight(0);
  ellipse(mouseX/2-200, 280, 450, 450); // Middle circle
  popStyle();
  pushStyle();
  strokeWeight(0);
  fill(90, 0, 78);
  ellipse(mouseX*1.5, 560, 700, 700); // Bottom circle
  popStyle();
  
  
  dragSegment(0, mouseX, mouseY);
  for(int i=0; i<x.length-1; i++) { //iterates through all segments
    dragSegment(i+1, x[i], y[i]); //calls segment and passes updated coordinates
  }
}

void dragSegment(int i, float xin, float yin) {
  float dx = xin - x[i]; //difference between cursor and segment position
  float dy = yin - y[i];
  
  float angle = atan2(dy, dx);  //angle of line from current segment to target
  
  x[i] = xin - cos(angle) * segLength; //updates based on angle, moving segment by length
  y[i] = yin - sin(angle) * segLength;
  
  segment(x[i], y[i], angle, i, x.length); //redraws segment
}

void segment(float x, float y, float a, int i, int numSegments) {
  float strokeThickness = map(i, 0, numSegments - 1, 50, 1); //starts at width 50 and shrinks to 1

  strokeWeight(strokeThickness); //sets weight to updating thickness
  
  pushMatrix(); //some basic processing thing that updates screen
  translate(x, y);
  rotate(a);
  line(0, 0, segLength, 0);
  popMatrix();
}
