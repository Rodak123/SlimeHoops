public class Ball extends GameSprite {

  private final SplashManager splashManager;
  private final SoundManager soundManager;

  private boolean launched;
  private int wallBounces;
  private int orbHits;

  public Ball(SpriteManager spriteManager, float x, float y, SplashManager splashManager, SoundManager soundManager) {
    super(spriteManager.ball, x, y);
    this.splashManager = splashManager;
    this.soundManager = soundManager;
  }

  public final void update() {
    if (launched) {
      applyForce(gravity);
    }
    angle = vel.heading();
    super.update();
    if (pos.x < w/2) {
      vel.x *= -1;
      pos.x = w/2;
      bounce();
    } else if (pos.x > screenWidth-w/2) {
      vel.x *= -1;
      pos.x = screenWidth-w/2;
      bounce();
    }
    if (pos.y < h/2) {
      vel.y *= -1;
      pos.y = h/2;
      bounce();
    } else if (pos.y > screenHeight-h/2) {
      vel.y *= -1;
      pos.y = screenHeight-h/2;
      bounce();
    }
  }

  private final void bounce() {
    vel.mult(0.9);
    wallBounces++;
    if (vel.mag() > 50) {
      splashManager.splash(pos, vel);
      if(vel.mag() > 25){
        float amp = constrain(map(vel.mag(), 25, 200, 0, 1), 0, 1);
        soundManager.bounce.amp(amp);
        soundManager.bounce.play();
      }
    }
  }

  public final void hitOrb(Orb orb) {
    if (!launched) return;
    if(vel.mag() < 500) return;
    orbHits++;
    orb.destroy();
    splashManager.splash(pos, vel);
    soundManager.splash.play();
  }

  public final int getWallBounces() {
    return wallBounces;
  }

  public final int getOrbHits() {
    return orbHits;
  }

  public final void launch(PVector spring) {
    if (launched) return;
    launched = true;
    PVector force = new PVector(spring.x, spring.y);
    float maxMag = 1200;
    float mag = constrain(map(spring.z, 0, screenWidth, 0, maxMag), 0, maxMag);
    force.setMag(mag);
    applyForce(force);
  }

  public final boolean canGrab() {
    return overMouse() && launched == false;
  }

  public final boolean stopped() {
    //println(vel.mag());
    return isFrozen() || vel.mag() < 20 && launched == true;
  }

  public final void glow() {
    fill(0, 255, 0);
    noStroke();
    rectMode(CENTER);
    rect(pos.x, pos.y, w, h);
  }
}
