class Element extends Node{
  float sc = 2;
  
  Element(Vector position){
    super(scene);
    this.setPosition(position);
  }

  @Override
  public void interact(TapEvent event) {
    if (selectedElement != this && scene.eye().reference() != this) {
      selectedElement = this;
    }
  }
}