public class ScoreManager {

  private int score;

  private int lastScore;
  private int highScore;

  public void addScore(int wallBounces, int orbsHit) {
    score += wallBounces + orbsHit*5;
  }

  public void reset() {
    lastScore = constrain(score, 0, 999);
    if (lastScore > highScore) {
      highScore = lastScore;
    }
    score = 0;
  }

  public void show(float x, float y) {
    fill(ColorPalette.Secondary);
    noStroke();
    FontManager.useFont(12);
    textAlign(CENTER, CENTER);
    text(score, x, y);
  }

  public void showHighScore(int x, int y) {
    fill(ColorPalette.Primary);
    noStroke();
    FontManager.useFont(12);
    textAlign(LEFT, BASELINE);
    text(highScore, x, y);
  }

  public void showLastScore(int x, int y) {
    fill(ColorPalette.Primary);
    noStroke();
    FontManager.useFont(12);
    textAlign(LEFT, BASELINE);
    text(lastScore, x, y);
  }
}
