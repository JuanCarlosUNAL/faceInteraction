class Circle extends Element{

  float sc = 10;
  
  Circle(Vector position){
    super(position);
  }

  @Override
  public void visit(){
    pushStyle();

    strokeWeight(2);
    stroke(color(0, 255, 0));
    fill(color(255, 0, 0));

    //draw boid
    beginShape(TRIANGLES);
    vertex(3 * sc, 0, 0);
    vertex(-3 * sc, 2 * sc, 0);
    vertex(-3 * sc, -2 * sc, 0);

    vertex(3 * sc, 0, 0);
    vertex(-3 * sc, 2 * sc, 0);
    vertex(-3 * sc, 0, 2 * sc);

    vertex(3 * sc, 0, 0);
    vertex(-3 * sc, 0, 2 * sc);
    vertex(-3 * sc, -2 * sc, 0);

    vertex(-3 * sc, 0, 2 * sc);
    vertex(-3 * sc, 2 * sc, 0);
    vertex(-3 * sc, -2 * sc, 0);
    endShape();

    popStyle();
  }

}