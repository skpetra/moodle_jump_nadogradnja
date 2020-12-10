abstract class Platform {
  
  protected float x_pos, y_pos;
  protected float p_length;
  protected PImage platformImage, power;
  //superpower moze biti "", "federi", "stit", "propela"
  protected String superpower;
  //visited je true ako je igrac ikad prešao preko platforme
  public boolean visited;
  
  public Platform( float x, float y, String spower ) {
    x_pos = x;
    y_pos = y;
    
    p_length = 75;  
    
    superpower = spower;
    
    visited = false;
      
    if ( superpower.equals( "" ) == false ){
      String stringImage = superpower + ".png";
      power = loadImage( stringImage );
      power.resize( (int)( power.width/2.25 ), (int)( power.height/2.25 ) );
    }
    
  }
  
  public void display() {  
    
    //ako na platformi postoji supermoc
    if ( superpower.equals( "" ) == false && !visited ) {     
      image( power, x_pos, y_pos - power.height );
    }
      
    image(platformImage, x_pos, y_pos, p_length, p_length*platformImage.height/platformImage.width );
  }
  
  public void destroy() {
    this.x_pos = 600;
  }
  public float get_x() {
  return x_pos;
  }
  public float get_y() {
    return y_pos;
  }
  public String get_power(){
    return superpower;
  }
  
  abstract void update();
}

class Regular_Platform extends Platform {
  
  public Regular_Platform( float x, float y, String spower ){
    super( x, y, spower );
    platformImage = loadImage( "platforma_obicna.png" );
  }  
  public void update() {   
  }
}

class Moving_Platform extends Platform {
  
  private float x_velocity;
  
  public Moving_Platform( float x, float y, String spower ){
    super( x, y, spower );
    platformImage = loadImage( "platforma_pomicna.png" );
    x_velocity = 2;
  }  
  public void update() {   
    x_pos += x_velocity;
    //nakon sto platforma prede desnu granicu prozora,
    //platforma se crta lijevo
    if ( x_pos > width ){
      x_pos = - p_length ;
    }
  }
}

class Disappearing_Platform extends Platform {
  
  public Disappearing_Platform( float x, float y, String spower ){
    super( x, y, spower );
    platformImage = loadImage( "platforma_nestajuca.png" );
  } 
  public void update(){
  }
}

class Broken_Platform extends Platform {
  
  private PImage platformImage0, platformImage1, platformImage2, platformImage3, platformImage4, platformImage5;
  private boolean broken;
  
  public Broken_Platform( float x, float y ){
    super( x, y, "" );
    
    broken = false;

    platformImage0 = loadImage( "platforma_slomljena1.png" );
    platformImage1 = loadImage( "platforma_slomljena2.png" );
    platformImage2 = loadImage( "platforma_slomljena4.png" );
    platformImage3 = loadImage( "platforma_slomljena3.png" );
    platformImage4 = loadImage( "platforma_slomljena4.png" );
    platformImage5 = loadImage( "platforma_slomljena5.png" );
    
    platformImage = platformImage0;
  } 
  
  public void display(){
    
    if ( platformImage == platformImage1 ){
      platformImage = platformImage2;
    }        
    else if ( platformImage == platformImage2 ){
      platformImage = platformImage3;
    }
    else if ( platformImage == platformImage3 ){
      platformImage = platformImage4;
    }
    else if ( platformImage == platformImage4 ){
      platformImage = platformImage5;
    }
    else if ( broken &&  ( platformImage == platformImage0 ) ){
      platformImage = platformImage1;
    }
    else if ( platformImage == platformImage5 ){
      this.y_pos += 5;
    }
    image(platformImage, x_pos, y_pos, p_length, p_length*platformImage.height/platformImage.width);
    
  }
  public void update(){
  }
  public void break_pl(){
    broken = true;
  } 
}
