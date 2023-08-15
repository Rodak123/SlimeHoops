public static class Collision {

  public static class Result {
    public static Result CollisionFail() {
      return new Result(false, null);
    }

    public static Result CollisionSuccess(PVector collisionPoint) {
      return new Result(true, collisionPoint);
    }

    public final boolean collided;
    public final PVector collisionPoint;

    private Result(boolean collided, PVector collisionPoint) {
      this.collided = collided;
      this.collisionPoint = collisionPoint;
    }
  }


  // http://www.jeffreythompson.org/collision-detection/line-line.php
  public static Result lineLine(PVector a, PVector b, PVector c, PVector d) {
    float uA = ((d.x-c.x)*(a.y-c.y) - (d.y-c.y)*(a.x-c.x)) / ((d.y-c.y)*(b.x-a.x) - (d.x-c.x)*(b.y-a.y));
    float uB = ((b.x-a.x)*(a.y-c.y) - (b.y-a.y)*(a.x-c.x)) / ((d.y-c.y)*(b.x-a.x) - (d.x-c.x)*(b.y-a.y));

    if (uA >= 0 && uA <= 1 && uB >= 0 && uB <= 1) {
      PVector intersection = new PVector(
        a.x + (uA * (b.x-a.x)),
        a.y + (uA * (b.y-a.y))
        );
      return Result.CollisionSuccess(intersection);
    }
    return Result.CollisionFail();
  }
}
