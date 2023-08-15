public class SplashManager {

  private final ArrayList<Splash> splashes;

  public SplashManager() {
    splashes = new ArrayList<Splash>();
  }


  public void show() {
    for (Splash splash : splashes) {
      splash.show();
    }
  }

  public void update() {
    for (int i=splashes.size()-1; i>=0; i--) {
      Splash splash = splashes.get(i);
      if (splash.toRemove()) {
        splashes.remove(i);
      }
      splash.update();
    }
  }

  public void splash(PVector pos, PVector dir) {
    Splash splash = new Splash(pos.x, pos.y, dir.heading(), dir.mag());
    splashes.add(splash);
  }
}
