public class SpringDragger {

  private final PVector start;
  private final PVector end;

  private boolean dragging;

  public SpringDragger() {
    start = new PVector();
    end = new PVector();
  }

  public final void show() {
    if (!dragging) return;

    fill(ColorPalette.White);
    noStroke();
    int points = floor(map(dist(start.x, start.y, end.x, end.y), 0, (screenWidth+screenHeight)/2, 1, 24));
    drawLine(start, end, points, 4, 2);
  }

  private final void drawLine(PVector start, PVector end, int points, int startSize, int endSize) {
    rectMode(CENTER);
    float a = PVector.sub(start, end).heading();
    for (int i=0; i<=points; i++) {
      float t = i / (float)points;
      PVector pos = PVector.lerp(start, end, t);
      int size = floor(map(i, 0, points, startSize, endSize));
      pushMatrix();
      translate(pos.x, pos.y);
      rotate(a);
      rect(0, 0, size, size);
      popMatrix();
    }
  }

  public final void grab() {
    dragging = true;
    PVector mouse = getMouse();
    start.set(mouse.x, mouse.y);
    end.set(mouse.x, mouse.y);
  }

  public final void drag() {
    if (!dragging) return;
    PVector mouse = getMouse();
    end.set(mouse.x, mouse.y);
  }

  public final PVector release() {
    if (!dragging) return null;
    dragging = false;
    PVector spring = PVector.sub(start, end);
    spring.normalize();
    spring.z = dist(start.x, start.y, end.x, end.y);
    return spring;
  }
}
