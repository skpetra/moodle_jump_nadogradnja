enum Direction{
  LEFT,
  RIGHT
}

//klasa za metke koje Moodler ispaljuje
class Bullet {
  
  private float x_pos, y_pos;   
  private float angle;
  private Direction direction; 
  //bingo je true ako je metak pogodio cudoviste
  private boolean bingo;
  
  public Bullet( float x_click, float y_click ) {
    
    //metak se ispaljuje od pozicije playera
    x_pos = p.get_x() + 25;
    y_pos = p.get_y() + 25;
    
    float x_dist = ( x_click - x_pos );
    float y_dist = ( y_click - y_pos );
    
    angle = atan( y_dist / x_dist );
    
    if ( x_click >= x_pos ){
      direction = Direction.RIGHT;
    }
    else {
      direction = Direction.LEFT;
    }
    
    bingo = false;
  }
  
  public float get_x() {   
    return x_pos;
  }  
  public float get_y() {   
    return y_pos;
  } 
  
  public void display() {
    
      //ovdje koristimo pushMatrix i popMatrix jer želimo samo micati samo metke,a ostale stvari se ne miču
      pushMatrix();
      translate( x_pos + bullet_img.width / 2, y_pos + bullet_img.height / 2 );
      if ( direction == Direction.RIGHT ){
        rotate(radians( 90) + angle );
      }
      else {
        rotate( -( radians(90) - angle ) );
      }
      image( bullet_img, 0, 0 );
      popMatrix();
    
  }
  
  public void update() {
    
    //ako je metak pogodio metu, vise se ne prikazuje
    if ( bingo ){
      y_pos = height;
    }
    else {
      switch( direction ){
        case RIGHT :
          x_pos += 15 * cos( angle );
          y_pos += 15 * sin( angle );
          break;
        case LEFT :
          x_pos -= 15 * cos( angle );
          y_pos -= 15 * sin( angle );
          break;
      }
    }    
  }
  
}
