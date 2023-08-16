public interface IGameSprite {

  public void setPos(float x, float y);
  public void applyForce(PVector force);

  public void show();
  public void update();

  public void handleCollision(IGameSprite other);

  public boolean over(float x, float y);
  public boolean overMouse();
  public boolean colliding(IGameSprite other);

  public PVector getLastPos();
  public PVector getPos();
  public PVector getNextPos();
  public PVector getVel();
  public int getH();
  public int getW();

  public boolean isFrozen();
  public void setFrozen(boolean frozen);

  public void destroy();
  public boolean toDestroy();
}
