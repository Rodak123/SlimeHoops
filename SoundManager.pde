public class SoundManager {

  public final SoundFile click;
  public final SoundFile success;
  public final SoundFile bounce;
  public final SoundFile fail;
  public final SoundFile theme;
  public final SoundFile splash;

  public SoundManager(PApplet sketch, String soundFolder) {
    click = new SoundFile(sketch, soundFolder + "click.wav");
    success = new SoundFile(sketch, soundFolder + "success.wav");
    fail = new SoundFile(sketch, soundFolder + "fail.wav");
    bounce = new SoundFile(sketch, soundFolder + "bounce.wav");
    splash = new SoundFile(sketch, soundFolder + "orb.wav");
    theme = new SoundFile(sketch, soundFolder + "theme.wav");
  }
}
