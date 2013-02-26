import com.onformative.leap.LeapMotionP5;
import com.leapmotion.leap.Finger;
LeapMotionP5 leap;

HColorField colorField;
int sphereSize = 32;

void setup() {
  size(900, 900, P3D);
  background(0);
  noFill(); noStroke(); smooth(); sphereDetail(20);

  leap = new LeapMotionP5(this);

  colorField = new HColorField(width, height);
  colorField.addPoint( new PVector(width/2, 0), "FFFF33", 0.4);
  colorField.addPoint( new PVector(width/2, height), "00CC33", 0.4);
  colorField.addPoint( new PVector(0, height/2), "FF0066", 0.5);
  colorField.addPoint( new PVector(width, height/2), "3300FF", 0.5);
}

void draw() {
  noStroke(); noFill(); lights();

  for (Finger finger : leap.getFingerList()) {
    PVector pt = leap.getTip(finger);

    color fColor = colorField.getColor( pt, hexToRGB("000000") );
    fill( fColor );

    pushMatrix();
      translate(width - pt.x, pt.y, pt.z);
      sphere( sphereSize + (pt.z / sphereSize) );
    popMatrix(); 

    pushMatrix();
      translate(pt.x, pt.y, pt.z);
      sphere( sphereSize + (pt.z / sphereSize) );
    popMatrix();

    pushMatrix();
      translate(pt.x, width - pt.y, pt.z);
     sphere( sphereSize + (pt.z / sphereSize) );
    popMatrix();

    pushMatrix();
      translate(width - pt.x, width - pt.y, pt.z);
      sphere( sphereSize + (pt.z / sphereSize) );
    popMatrix();
  }
}

void keyPressed() {
  if (key == 's') {
    saveFrame("render_normal_###.png");
    // exit();
  }

  if (key == ' ') {
    background(0);
  }
}
