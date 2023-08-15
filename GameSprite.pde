public class GameSprite implements IGameSprite {

  protected final PImage sprite;

  protected final PVector pos;
  protected final PVector lastPos;
  protected final int w, h;

  protected final PVector vel;
  protected final PVector acc;

  protected float angle;

  private float maxVelocity;
  private boolean frozen;

  public GameSprite(PImage sprite, float x, float y) {
    this.sprite = sprite;
    pos = new PVector(x, y);
    lastPos = new PVector(x, y);
    this.w = sprite.width;
    this.h = sprite.height;
    vel = new PVector();
    acc = new PVector();
    maxVelocity = (w + h) * 50f;
    angle = 0;
  }

  public final void applyForce(PVector force) {
    vel.add(force);
  }

  public void show() {
    imageMode(CENTER);
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(angle);
    image(sprite, 0, 0, w, h);
    popMatrix();
  }

  public void update() {
    if (frozen) return;
    acc.mult(Time.getDeltaTime());
    vel.add(acc);
    acc.mult(0);
    vel.limit(maxVelocity);

    lastPos.set(pos.x, pos.y);
    PVector moveVel = vel.copy().mult(Time.getDeltaTime());
    pos.add(moveVel);
  }

  public final boolean over(float x, float y) {
    return (x > pos.x-w/2 && x < pos.x+w/2) &&
      (y > pos.y-h/2 && y < pos.y+h/2);
  }

  public final boolean overMouse() {
    PVector mouse = getMouse();
    return over(mouse.x, mouse.y);
  }

  public final void handleCollision(IGameSprite other) {
    if (colliding(other)) {
      onCollide(other);
    }
  }

  protected void onCollide(IGameSprite other) {
    // On collide
  }

  public final void setPos(float x, float y) {
    pos.set(x, y);
  }

  public final PVector getLastPos() {
    return lastPos;
  }

  public final PVector getPos() {
    return pos;
  }

  public final PVector getNextPos() {
    return PVector.add(pos, vel.copy().mult(Time.getDeltaTime()));
  }

  public final PVector getVel() {
    return vel;
  }

  public final int getW() {
    return w;
  }

  public final int getH() {
    return h;
  }

  public final void setFrozen(boolean frozen) {
    this.frozen = frozen;
  }

  public final boolean isFrozen() {
    return frozen;
  }

  public boolean colliding(IGameSprite other) {
    return pos.x + w/2 >= other.getPos().x - other.getW()/2 &&
      pos.x - w/2 <= other.getPos().x + other.getW()/2 &&
      pos.y + h/2 >= other.getPos().y - other.getH()/2 &&
      pos.y - h/2 <= other.getPos().y + other.getH()/2;
  }
}
