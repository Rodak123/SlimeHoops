public class Splash {

  private class Particle {
    private final PVector pos;
    private final PVector vel, acc;
    private final float maxVelocity;
    private float size;

    private final float shrinkSpeed = 0.975;

    private boolean toDestroy;
    public Particle(float x, float y, float vx, float vy) {
      pos = new PVector(x, y);
      vel = new PVector(vx, vy);
      acc = new PVector();
      size = random(1, 3.5);
      maxVelocity = 100;
    }

    public void update() {
      acc.add(PVector.mult(gravity, 8));

      acc.mult(Time.getDeltaTime());
      vel.add(acc);
      acc.mult(0);
      vel.limit(maxVelocity);

      PVector moveVel = vel.copy().mult(Time.getDeltaTime());
      pos.add(moveVel);

      size *= shrinkSpeed;
      if (size <= 0.9) {
        size = 1;
        toDestroy = true;
      }
    }

    public void show() {
      noStroke();
      fill(ColorPalette.Primary);
      rectMode(CENTER);
      rect(pos.x, pos.y, size, size);
    }

    public boolean toDestroy() {
      return toDestroy;
    }
  }

  private ArrayList<Particle> particles;

  public Splash(float x, float y, float angle, float stength) {
    float maxAngleOff = PI*0.1;
    int totalParticles = floor(random(16, 40));
    particles = new ArrayList<Particle>();
    for (int i=0; i<totalParticles; i++) {
      float px = x + random(-2, 2);
      float py = y + random(-2, 2);

      PVector vel = PVector.fromAngle(angle + random(-maxAngleOff, maxAngleOff));
      vel.setMag(random(stength*0.5, stength));
      Particle particle = new Particle(px, py, vel.x, vel.y);

      particles.add(particle);
    }
  }

  public void show() {
    for (Particle particle : particles) {
      particle.show();
    }
  }

  public void update() {
    for (int i=particles.size()-1; i>=0; i--) {
      Particle particle = particles.get(i);
      if (particle.toDestroy()) {
        particles.remove(i);
        break;
      }
      particle.update();
    }
  }

  public boolean toRemove() {
    return particles.size() == 0;
  }
}
