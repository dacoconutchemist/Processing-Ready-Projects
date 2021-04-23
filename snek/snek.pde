int balls = 100;
float moveCoef = 0.01;

color[] cols = new color[]{0xFFFF0000, 0xFFFFFF00, 0xFF00FF00, 0xFF00FFFF, 0xFF0000FF, 0xFFFF00FF};
float[] x = new float[balls], y = new float[balls], z = new float[balls];
float zc = 0;
float zz;
void settings(){
  size(500, 700, P3D);
  PJOGL.setIcon("i.png");
}
void setup() {
  surface.setTitle("a lil snek");
  zz = (height + width)/4;
  for (int i = 0; i < balls; i++) {
    x[i] = random(0, width);
    y[i] = random(0, height);
    z[i] = 0;
  }
  noFill();
  stroke(128, 255, 0);
  strokeWeight(10);
  //strokeCap(ROUND);
  //smooth(10);
}

void draw() {
  for (int eee = 0; eee < 16; eee++) {
    x[0] = mouseX;
    y[0] = mouseY;
    z[0] = zc;
    for (int i = 1; i < balls; i++) {
      x[i] -= moveCoef*(x[i] - x[i - 1]);
      y[i] -= moveCoef*(y[i] - y[i - 1]);
      z[i] -= moveCoef*(z[i] - z[i - 1]);
    }
  }
  background(0, 0, 60);
  
  pushStyle();
  pushMatrix();
  stroke(60, 60, 120);
  strokeWeight(3);
  noFill();
  translate(width/2, height/2, -zz*1.5);
  box(width, height, zz*3);
  popMatrix();
  pushMatrix();
  translate(0, 0, z[0]*zz/10);
  stroke(255);
  rect(0, 0, width, height);
  popMatrix();
  popStyle();
  
  beginShape();
  //vertex(x[1], y[1]);
  for (int i = 1; i < balls - 1; i++){
    stroke(cols[i%cols.length]);
    //strokeWeight(map(z[i], -zz, 0, 5, 10));
    curveVertex(x[i], y[i], z[i]*zz/10);
  }
  //vertex(x[balls - 1], y[balls - 1]);
  endShape();
  //for (int i = 1; i < balls; i++) ellipse(x[i], y[i], 20, 20);
}

void mouseWheel(MouseEvent e) {
  zc += e.getCount();
  if(zc > 0) zc = 0;
  if(zc < -zz/10) zc = -zz/10;
}
