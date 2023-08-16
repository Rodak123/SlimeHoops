public class SpriteManager {

  public final PImage overlay;
  public final PImage hoopFront;
  public final PImage hoopBack;
  public final PImage ball;
  public final PImage orb;

  public final PImage title;
  public final PImage endScreen;

  public SpriteManager(String spritesFolder) {
    title = loadImage(spritesFolder + "title.png");
    endScreen = loadImage(spritesFolder + "endscreen.png");
    overlay = loadImage(spritesFolder + "overlay.png");
    hoopFront = loadImage(spritesFolder + "hoop-front.png");
    hoopBack = loadImage(spritesFolder + "hoop-back.png");
    ball = loadImage(spritesFolder + "ball.png");
    orb = loadImage(spritesFolder + "orb.png");
  }
}
