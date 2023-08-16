public class CameraShaker{
  
  private final PVector shake;
  private final PVector dir;
  private final float maxMag;
  
  private float strength = 0;
  private float a = 0;
  
  private float speed = 0.1;
  private float strengthWeakening = 0.78;
  
  public CameraShaker(float maxMag){
    shake = new PVector();
    dir = new PVector();
    this.maxMag = maxMag;
  }
  
  public final void update(){
    float mag = getMag();
    
    PVector newShake = PVector.mult(dir, mag);
    shake.set(newShake.x, newShake.y);
    
    strength *= strengthWeakening;
    a += speed;
  }
  
  private final float getMag(){
    return sin(a) * strength * maxMag;
  }
  
  public final void shake(float strength){
    PVector dir = PVector.random2D();
    this.dir.set(dir.x, dir.y);
    this.strength = strength;
    a = 0;
  }
  
  public final void translateCamera(){
    translate(shake.x, shake.y);
  }
}
