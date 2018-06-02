import gab.opencv.*;
import processing.video.*;
import java.awt.Rectangle;

import frames.input.*;
import frames.input.event.*;
import frames.primitives.Vector;
import frames.primitives.Quaternion;
import frames.core.*;
import frames.processing.*;

Capture video;
Scene scene;
Eye eye;
int boxWidth = 1280;
int boxHeight = 720;
int boxDepth = 2300;

int mode = 2;
int reference = 0;

Shape puntero; 
Node selectedElement;
ArrayList<Element> elements;

PShader juancho;

Vector videoResolution = new Vector(320, 240);
Vector screenResolution = new Vector(1300, 700);


void settings() {
  size( (int)screenResolution.x(), (int)screenResolution.y(), P3D);
}

void setup() {

  scene = new Scene(this);
  scene.setBoundingBox(new Vector(0, 0, 0), new Vector(boxWidth, boxHeight, boxDepth));
  scene.setAnchor(scene.center());
  eye = new Eye(scene);
  scene.setEye(eye);
  scene.setFieldOfView(PI / 3);
  //interactivity defaults to the eye
  scene.setDefaultGrabber(eye);
  
  scene.fitBall();

  puntero = new Shape(scene);
  puntero.set(createShape(ELLIPSE, -25, 0, 50, 50));

  selectedElement = puntero;
  
  elements = new ArrayList<Element>();
  elements.add(new Circle(new Vector(100, 100, 0)));
  elements.add(new Circle(new Vector(-100, 100, 200)));
  elements.add(new Circle(new Vector(100, 100, 0)));

  video = new Capture(this, (int)videoResolution.x(), (int)videoResolution.y());
  video.start();

  juancho = loadShader("lightfrag.glsl", "lightvert.glsl");
  
}

void draw() {
  Vector face = faceDetector.getPosition();
  background(0);
  ambientLight(128, 128, 128);
  directionalLight(255, 255, 255, 0, 1, -100);
  walls();

  switch(reference){
    case 0:
      moveReference(face);
    break;
    
  }

  // Calls Node.visit() on all scene nodes.
  scene.traverse();
  drawCamera(face);
}

void moveReference(Vector p){
  pushStyle();

  fill(color(255, 255, 0));
  Vector n = new Vector( boxWidth - (boxWidth * p.x()), boxHeight * p.y(),  (3 * boxDepth/4)  );
  selectedElement.setPosition(n);

  popStyle();
}

void drawCamera(Vector p){
  pushMatrix();
  scene.beginScreenCoordinates();
  pushStyle();

  int scalaFactor = 8;
  Vector fp = new Vector( videoResolution.x() * p.x(), videoResolution.y() * p.y(), videoResolution.z() * p.z() );
  image(video, (scalaFactor-1)*screenResolution.x()/scalaFactor, 
               (scalaFactor-1)*screenResolution.y()/scalaFactor,
                screenResolution.x() / scalaFactor,
                screenResolution.y() / scalaFactor );

  rect( ( (scalaFactor - 1) * screenResolution.x() / scalaFactor ) + (screenResolution.x() / scalaFactor) * p.x(), 
        ( (scalaFactor - 1) * screenResolution.y() / scalaFactor ) + (screenResolution.y() / scalaFactor) * p.y(), 3, 3);

  popStyle();
  scene.endScreenCoordinates();
  popMatrix();
}

void walls() {
  pushStyle();
  noFill();
  stroke(255);

  line(0, 0, 0, 0, boxHeight, 0);
  line(0, 0, boxDepth, 0, boxHeight, boxDepth);
  line(0, 0, 0, boxWidth, 0, 0);
  line(0, 0, boxDepth, boxWidth, 0, boxDepth);

  line(boxWidth, 0, 0, boxWidth, boxHeight, 0);
  line(boxWidth, 0, boxDepth, boxWidth, boxHeight, boxDepth);
  line(0, boxHeight, 0, boxWidth, boxHeight, 0);
  line(0, boxHeight, boxDepth, boxWidth, boxHeight, boxDepth);

  for(float i = 0.5; i < 1; i += 0.1){
    line(boxWidth, 0, boxDepth - boxDepth*i , boxWidth, boxHeight, boxDepth - boxDepth*i );
    line(0, boxHeight, boxDepth - boxDepth*i , boxWidth, boxHeight, boxDepth - boxDepth*i );
    line(0, 0, boxDepth - boxDepth*i , 0, boxHeight, boxDepth - boxDepth*i );
    line(0, 0, boxDepth - boxDepth*i , boxWidth, 0, boxDepth - boxDepth*i );

  }
  
  line(0, 0, 0, 0, 0, boxDepth);
  line(0, boxHeight, 0, 0, boxHeight, boxDepth);
  line(boxWidth, 0, 0, boxWidth, 0, boxDepth);  
  line(boxWidth, boxHeight, 0, boxWidth, boxHeight, boxDepth);

  popStyle();
}

void keyPressed() {
  switch (key) {
    case ' ':
      for( Element e : elements ){
        Vector comparableA = new Vector (e.position().x(), e.position().y());
        Vector comparableB = new Vector (selectedElement.position().x(), selectedElement.position().y());
        float distance = Vector.distance(comparableA,comparableB);
        if(e != selectedElement ){
          System.out.println( distance);
          selectedElement = distance < 300?e:selectedElement;
        }
      }
      break;
    case 'x':
      selectedElement = puntero;
      break;
  }
}