public class Hoop extends GameSprite {

  private final PImage frontSprite;
  private boolean caughtBall;

  public Hoop(SpriteManager spriteManager, float x, float y) {
    super(spriteManager.hoopBack, x, y);
    frontSprite = spriteManager.hoopFront;
  }

  public final void showFront() {
    imageMode(CENTER);
    image(frontSprite, pos.x, pos.y, w, h);
  }

  public final boolean ballCaught(Ball ball) {
    float otherDir = degrees(ball.getVel().heading());
    if (otherDir < 0 || otherDir > 180) return false;

    float tolerance = ball.getH()*0.25;
    if (ball.getPos().y > pos.y+tolerance) return false;

    Collision.Result result = Collision.lineLine(
      new PVector(pos.x-w, pos.y),
      new PVector(pos.x+w, pos.y),
      ball.getNextPos(),
      ball.getLastPos());

    PVector collisionPoint = ball.getPos();
    if (result.collided) {
      collisionPoint = result.collisionPoint;
    }

    float dX = abs(max(pos.x, collisionPoint.x) - min(pos.x, collisionPoint.x));
    if (dX >= w/2-ball.getW()/2) return false;

    float dY = abs(max(pos.y, collisionPoint.y) - min(pos.y, collisionPoint.y));
    if (dY >= tolerance) return false;

    return true;
  }

  public final void catchBall(Ball ball) {
    if (ballCaught(ball) && caughtBall == false) {
      caughtBall = true;
      score();
    }
  }
}
