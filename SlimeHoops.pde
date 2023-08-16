import processing.sound.*;

private SpriteManager spriteManager;
private SoundManager soundManager;

private ScoreManager scoreManager;
private SplashManager splashManager;
private OrbManager orbManager;
private CameraShaker cameraShaker;

private Hoop hoop;
private Ball ball;
private SpringDragger dragger;

private int scale = 4;
public int screenWidth = 144;
public int screenHeight = 160;

public PVector gravity;

private boolean scored;

private GameState gameState = GameState.Title;

private float themeAmp = 0;

public final void settings() {
  size(screenWidth*scale, screenHeight*scale);
  noSmooth();
}

public final void setup() {
  surface.setIcon(loadImage("icon.png"));
  
  cameraShaker = new CameraShaker(screenWidth*0.1);
  
  gravity = new PVector(0, 40);

  soundManager = new SoundManager(this, "sfx/");

  FontManager.setup(this, createFont("Early_GameBoy.ttf", 16));

  spriteManager = new SpriteManager("");
  scoreManager = new ScoreManager();
  splashManager = new SplashManager();
  orbManager = new OrbManager(spriteManager);

  dragger = new SpringDragger();

  spawnRound();

  soundManager.theme.amp(0.01);
  soundManager.theme.loop();
  
  println("Hello fellow linux user!");
}

private final void spawnRound() {
  spawnHoop();
  spawnBall();
  orbManager.spawnOrbs();
}

public final void keyPressed(){
  if(key == ' '){
    cameraShaker.shake(1);
  }
}

private final void spawnHoop() {
  int x = floor(random(34, screenWidth-34));
  int y = floor(random(38, screenHeight-54));
  hoop = new Hoop(spriteManager, x, y);
}

private final void spawnBall() {
  int off = floor(random(4, 18));
  int dir = (floor(hoop.pos.x) - screenWidth/2) * -1;
  int x = screenWidth/2 + dir + (dir < 0 ? -off : off);
  int y = screenHeight/2 + (floor(hoop.pos.y) - screenHeight/2) * -1 + floor(random(-screenHeight*0.25, screenHeight*0.25));
  y = constrain(y, 20, screenHeight-24);
  ball = new Ball(spriteManager, x, y, splashManager, soundManager, cameraShaker);
}

public final void draw() {
  Time.update(this);
  //println(Time.deltaTime);
  
  if(themeAmp <= 0.5){
    themeAmp = map(millis(), 0, 1500, 0.01, 0.5);
    soundManager.theme.amp(themeAmp);
  }
  background(ColorPalette.Primary);
  scale(scale, scale);
  
  switch(gameState) {
  case Title:
    imageMode(CORNER);
    image(spriteManager.title, 0, 0);
    break;
  case Game:
    // Update
    hoop.update();
    ball.update();
    splashManager.update();
    orbManager.update(ball);

    hoop.catchBall(ball);
    cameraShaker.update();

    // Show
    pushMatrix();
    cameraShaker.translateCamera();
    
    fill(0xFF_332c50);
    noStroke();
    rectMode(CORNER);
    rect(1, 1, screenWidth-2, screenHeight-2);
    
    PVector hoopPos = hoop.getPos();
    scoreManager.show(hoopPos.x, hoopPos.y-hoop.getH()/2);
    
    hoop.show();
    ball.show();
    hoop.showFront();

    orbManager.show();

    dragger.show();

    imageMode(CORNER);
    image(spriteManager.overlay, 0, 0);
    splashManager.show();
    popMatrix();
    break;
  case EndScreen:
    imageMode(CORNER);
    image(spriteManager.endScreen, 0, 0);
    scoreManager.showLastScore(100, 119);
    scoreManager.showHighScore(100, 137);
    break;
  default:
  }
}

public final PVector getMouse() {
  return new PVector(mouseX/scale, mouseY/scale);
}

private final void nextRound() {
  spawnRound();
  if (scored == false) {
    soundManager.fail.play();
    scoreManager.reset();
    gameState = GameState.EndScreen;
    return;
  }
  scored = false;
}

public final void score() {
  int bounces = ball.getWallBounces();
  int orbHits = ball.getOrbHits();
  ball.setFrozen(true);
  scoreManager.addScore(bounces, orbHits);
  scored = true;
  soundManager.success.play();
}

public final void mousePressed() {
  switch(gameState) {
  case Title:
    gameState = GameState.Game;
    soundManager.click.play();
    break;
  case Game:
    if (ball.canGrab()) {
      dragger.grab();
    } else if (ball.stopped()) {
      nextRound();
    }
    break;
  case EndScreen:
    gameState = GameState.Game;
    soundManager.click.play();
    break;
  default:
  }
}

public final void mouseDragged() {
  switch(gameState) {
  case Title:
    break;
  case Game:
    dragger.drag();
    break;
  case EndScreen:
    break;
  default:
  }
}

public void mouseReleased() {
  switch(gameState) {
  case Title:
    break;
  case Game:
    PVector spring = dragger.release();
    if (spring != null) {
      ball.launch(spring);
    }
    break;
  case EndScreen:
    break;
  default:
  }
}
