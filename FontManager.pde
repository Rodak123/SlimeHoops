public static class FontManager{
  
  private static PApplet sketch;
  private static PFont font;
  
  public static void setup(PApplet sketch, PFont font){
    FontManager.sketch = sketch;
    FontManager.font = font;
  }
  
  public static void useFont(float textSize){
    sketch.textFont(FontManager.font, textSize);
  }
  
}
