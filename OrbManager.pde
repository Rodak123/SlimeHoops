public class OrbManager {

  private final SpriteManager spriteManager;

  private final ArrayList<Orb> orbs;

  public OrbManager(SpriteManager spriteManager) {
    this.spriteManager = spriteManager;
    orbs = new ArrayList<Orb>();
  }

  public final void spawnOrbs() {
    orbs.clear();
    int[] vals = new int[]{0, 0, 0, 0, 0, 1, 1, 1, 1, 2, 2};
    int totalOrbs = vals[floor(random(vals.length))];
    for (int i=0; i<totalOrbs; i++) {
      float orbX = random(40, screenWidth-40);
      float orbY = random(40, screenHeight-40);
      Orb orb = new Orb(spriteManager, orbX, orbY);
      orbs.add(orb);
    }
  }

  public final void show() {
    for (Orb orb : orbs) {
      orb.show();
    }
  }

  public final void update(Ball ball) {
    for (int i=orbs.size()-1; i>=0; i--) {
      Orb orb = orbs.get(i);
      if (orb.colliding(ball)) {
        ball.hitOrb(orb);
      }
      if (orb.toDestroy()) {
        orbs.remove(i);
      }
      orb.update();
    }
  }
}
