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
boolean avoidWalls = true;

// visual modes
// 0. Faces and edges
// 1. Wireframe (only edges)
// 2. Only faces
// 3. Only points
int mode;

int initBoidNum = 90; // amount of boids to start the program with
ArrayList<Boid> flock;
Node avatar;
boolean animate = true;

Vector videoResolution = new Vector(320, 240);
Vector screenResolution = new Vector(1300, 700);


void settings() {
  size( (int)screenResolution.x(), (int)screenResolution.y(), P3D);
  // size(1000, 800, P3D);
}

void setup() {
  scene = new Scene(this);
  scene.setBoundingBox(new Vector(0, 0, 0), new Vector(boxWidth, boxHeight, boxDepth/2));
  scene.setAnchor(scene.center());
  eye = new Eye(scene);
  scene.setEye(eye);
  scene.setFieldOfView(PI / 3);
  //interactivity defaults to the eye
  scene.setDefaultGrabber(eye);
  scene.fitBall();
  // create and fill the list of boids
  flock = new ArrayList();
  for (int i = 0; i < initBoidNum; i++)
    flock.add(new Boid(new Vector(boxWidth / 2, boxHeight / 2, boxDepth / 2)));

  video = new Capture(this, (int)videoResolution.x(), (int)videoResolution.y());
  video.start();
}

void draw() {
  Vector p = faceDetector.getPosition();
  eye.setPosition( 
    new Vector( boxWidth - (boxWidth * p.x()), boxHeight * p.y(),  3 * boxDepth/4 )
  );
  background(0);
  ambientLight(128, 128, 128);
  directionalLight(255, 255, 255, 0, 1, -100);
  walls();
  // Calls Node.visit() on all scene nodes.
  scene.traverse();
  // drawperspective(fp);
}

void captureEvent(Capture c) {
  c.read();
}

void drawperspective(Vector p){
  pushStyle();
  Vector fp = new Vector( screenResolution.x() - screenResolution.x() * p.x(), screenResolution.y() * p.y(), screenResolution.z() * p.z() );
  stroke(255,0,0);
  strokeWeight(2);
  
  line( screenResolution.x() , 0, fp.x(), fp.y());
  line( screenResolution.x() , screenResolution.y(), fp.x(), fp.y());
  line( 0 , screenResolution.y(), fp.x(), fp.y());
  line( 0 , 0, fp.x(), fp.y());

  popStyle();
}

void drawCamera(Vector p){
  pushStyle();
  int scalaFactor = 4;
  Vector fp = new Vector( videoResolution.x() * p.x(), videoResolution.y() * p.y(), videoResolution.z() * p.z() );
  image(video, (scalaFactor-1)*screenResolution.x()/scalaFactor, 
               (scalaFactor-1)*screenResolution.y()/scalaFactor,
                screenResolution.x() / scalaFactor,
                screenResolution.y() / scalaFactor );

  rect( ( (scalaFactor - 1) * screenResolution.x() / scalaFactor ) + (screenResolution.x() / scalaFactor) * p.x(), 
        ( (scalaFactor - 1) * screenResolution.y() / scalaFactor ) + (screenResolution.y() / scalaFactor) * p.y(), 3, 3);

  popStyle();        
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

  line(0, 0, 0, 0, 0, boxDepth);
  line(0, boxHeight, 0, 0, boxHeight, boxDepth);
  line(boxWidth, 0, 0, boxWidth, 0, boxDepth);
  line(boxWidth, boxHeight, 0, boxWidth, boxHeight, boxDepth);
  popStyle();
}

void keyPressed() {
  switch (key) {
  case 'a':
    animate = !animate;
    break;
  case 's':
    if (scene.eye().reference() == null)
      scene.fitBallInterpolation();
    break;
  case 't':
    scene.shiftTimers();
    break;
  case 'p':
    println("Frame rate: " + frameRate);
    break;
  case 'v':
    avoidWalls = !avoidWalls;
    break;
  case 'm':
    mode = mode < 3 ? mode+1 : 0;
    break;
  case ' ':
    if (scene.eye().reference() != null) {
      scene.lookAt(scene.center());
      scene.fitBallInterpolation();
      scene.eye().setReference(null);
    } else if (avatar != null) {
      scene.eye().setReference(avatar);
      scene.interpolateTo(avatar);
    }
    break;
  }
}