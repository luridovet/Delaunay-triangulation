
ArrayList<PVector> points = new ArrayList<PVector>();
ArrayList<PVector> heading = new ArrayList<PVector>();

void setup() {
  //size(600, 600);
  size(800, 800);
  //fullScreen();

  for (int i = 0; i < 50; i++) {
    points.add(new PVector(random(width), random(height)));  
    heading.add(PVector.fromAngle(random(TWO_PI)));
  }

  points.add(new PVector(0, 0));
  points.add(new PVector(width, 0));
  points.add(new PVector(0, height));
  points.add(new PVector(width, height));

  colorMode(HSB, 255);
}


void draw() {
  background(50);

  stroke(255);
  strokeWeight(10);
  textSize(20);
  //for (int i = 0; i < points.size(); i++) {//PVector p : points) {
  //  PVector p = points.get(i);
  //  point(p.x, p.y);
  //  //text(i, p.x+5, p.y+5);
  //}

  //for (int i = 0; i < 10; i++) {
  //  PVector p = points.get(i);

  //  beginShape();
  //  vertex(p.x,p.y);

  //  endShape(CLOSE);
  //}

  //noFill();
  stroke(10);
  //noStroke();
  strokeWeight(1);
  for (int i = 0; i < points.size(); i++) {//PVector p1 : points) {
    PVector p1 = points.get(i);
    for (int j = 0; j < points.size(); j++) {//PVector p2 : points) {
      if (i != j) {
        PVector p2 = points.get(j);
        for (int k = 0; k < points.size(); k++) {//PVector p3 : points) {
          if (j != k && i != k) {
            PVector p3 = points.get(k);
            if (isCounterClockwise(p1, p2, p3)) {
              boolean isDelaunay = true;
              for (PVector test : points) {
                if (isInside(p1, p2, p3, test)) {
                  isDelaunay = false;
                  break;
                }
              }
              //println(i, j, k, isDelaunay);

              if (isDelaunay) {
                float green = 255-((p1.y + p2.y + p3.y)/(3*height))*255;
                color c = color(green, 255, 255);
                fill(c);
                beginShape();
                vertex(p1.x, p1.y);
                vertex(p2.x, p2.y);
                vertex(p3.x, p3.y);
                endShape(CLOSE);
              }
            }
          }
        }
      }
    }
  }



  //if (isInside(points.get(1), points.get(2), points.get(3), new PVector(mouseX, mouseY) )) {
  //  background(255, 255, 0);
  //} else { 
  //  background(50);
  //}
  //beginShape();
  //vertex(points.get(1).x, points.get(1).y);
  //vertex(points.get(2).x, points.get(2).y);
  //vertex(points.get(3).x, points.get(3).y);
  //endShape(CLOSE); 
  //println("end");
  //circle(points.get(0), points.get(0).y, 10);

  move();

  //noLoop();
}



boolean isInside(PVector A, PVector B, PVector C, PVector D) {
  float ADx = A.x - D.x;
  float BDx = B.x - D.x;
  float CDx = C.x - D.x;

  float ADy = A.y - D.y;
  float BDy = B.y - D.y;
  float CDy = C.y - D.y; 

  float AD = pow(ADx, 2) + pow(ADy, 2);
  float BD = pow(BDx, 2) + pow(BDy, 2);
  float CD = pow(CDx, 2) + pow(CDy, 2);

  float first = ADx * ( BDy * CD - CDy * BD ); 
  float second = ADy * ( BDx * CD - CDx * BD ); 
  float third = AD * ( BDx * CDy - CDx * BDy ); 

  float d = first - second + third;

  if (d > 0) {
    return true;
  }
  return false;
}

boolean isCounterClockwise(PVector A, PVector B, PVector C) {

  float first = A.x * ( B.y * 1 - C.y * 1);
  float second = A.y * ( B.x * 1 - C.x * 1);
  float third = 1 * ( B.x * C.y - B.y * C.x);

  float d = first - second + third;


  if (d > 0) {
    return true;
  }
  return false;
}


void move() {
  for (int i = 0; i < points.size()-4; i++) {
    PVector p = points.get(i);
    PVector h = heading.get(i);

    float speed = random(0.5, 2);
    p.x += speed*h.x;
    p.y += speed*h.y;

    if (0 > p.x || p.x > width) {
      h.x = -h.x;
    }
    if (0 > p.y || p.y > height) {
      h.y = -h.y;
    }
  }
}
