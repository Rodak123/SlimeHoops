public static class Time {

  private static float deltaTime;

  public static float getDeltaTime() {
    return deltaTime;
  }

  public static void update(PApplet sketch) {
    deltaTime = 1.0 / max(1, sketch.frameRate);
  }
}
