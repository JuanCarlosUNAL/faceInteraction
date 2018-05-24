private static final Shortcut RIGHT_EVENT = new Shortcut(RIGHT);
private static final Shortcut LEFT_EVENT = new Shortcut(LEFT);
private static final Shortcut CENTER_EVENT = new Shortcut(CENTER);

public class Eye extends Node {
  public Eye(Graph graph) {
    super(graph);
  }

  protected Eye(Graph otherGraph, Eye otherNode) {
    super(otherGraph, otherNode);
  }

  @Override
  public Eye get() {
    scene.setBoundingBox(
      new Vector(0, 0, 0), 
      new Vector( (int)screenResolution.x(), (int)screenResolution.y(), (int)screenResolution.z())
    );
    return new Eye(graph(), this);
  }

  @Override
  public void interact(frames.input.Event event) {
    if (event.shortcut().matches(RIGHT_EVENT))
      translate(event);
    if (event.shortcut().matches(LEFT_EVENT))
      rotate(event);
    if (event.shortcut().matches(CENTER_EVENT))
      rotate(event);
    if (event.shortcut().matches(new Shortcut(processing.event.MouseEvent.WHEEL)))
      if (isEye() && graph().is3D())
        translateZ(event);
      else
        scale(event);
  }
}
