/**
 * ver archivo global variables
 */

float area_max = (videoResolution.x() * videoResolution.y())/2;

class FaceDetector{
  
  OpenCV opencv;

  private FaceDetector(PApplet pa){
    opencv = new OpenCV(pa, (int)videoResolution.x(), (int)videoResolution.y());
    opencv.loadCascade("haarcascade_frontalface_alt2.xml");
  }

  public Vector getPosition(){
    opencv.loadImage(video);
    Rectangle[] faces = opencv.detect();
    float x = 0, y = 0 ,z = 0, area = 1; 
    if(faces.length > 0){
      Rectangle face1 = faces[0];
      x = ( faces[0].x + faces[0].width/2 ) / videoResolution.x();
      y = ( faces[0].y + faces[0].height/2 )/ videoResolution.y();
      area = faces[0].height * faces[0].width;
      z = area_max / (area * 2);
    }
    return new Vector(x,y,z);
  }
}

FaceDetector faceDetector = new FaceDetector(this);