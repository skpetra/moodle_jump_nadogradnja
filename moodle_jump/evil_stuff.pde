//ovdje ću implementirati domaće zadaće, seminare i ostale more

float Pi=3.141592653589793;

//klasa put u R^2, kao u intrafu
//klasa sama pamti (i inkrementira) parametar t
abstract class path2
{
  protected int t;
  protected int tmax;
  
  protected float x,y;
  
  
  public abstract int tset(int tt);
  public abstract int tnext();
  public abstract int trest();
  
  public float getx(){return x;}
  public float gety(){return y;}
  
}

class path2linear extends path2
{
  private float a, b;
  
  public int trest()
  {
    t=0; x=0; y=0;
    return 0;
  }
  public int tset(int tt)
  {
    if (tt>=tmax)
    {
      t=-tmax;
    }
    else t=tt;
    
    x=(tmax-abs(t))*a;
    y=(tmax-abs(t))*b;
    
    return t;
  }
  
  public int tnext()
  {
    t++;
    return tset(t);
  }
  
  public path2linear(float aa, float bb, int N)
  {
    a=aa/N; b=bb/N;
    tmax=N;
  }
  
}

class path2ellipse extends path2
{
  private float Ax, Ay, fx, fy;
  
  
  public int trest()
  {
    t=0; x=0; y=0;
    return 0;
  }
  public int tset(int tt)
  {
    t=tt%tmax;
    
    x=Ax*cos(fx*t);
    y=Ay*sin(fy*t);
    
    return t;
  }
  
  public int tnext()
  {
    t++;
    return tset(t);
  }
  
  public path2ellipse(float H, float V, int N, int xr, int yr)
  {
    Ax=H; Ay=V;
    tmax=N;
    
    fx=2*Pi*xr/N;
    fy=2*Pi*yr/N;
    
    trest();
  }
}

float HW_initial_size=60;
String HW_default_image_name="dz.png";
String SEM_default_image_name="seminar.png";

class homework
{
  int type;
  //domaća zadaća
  //ima položaj i veličinu (kao i platforma)
  float x_pos, y_pos;
  float x_size[]={0,0}, y_size[]={0,0};
  
  PImage HWImage[]={null, null};
  int health; //ovo se smanji kad ga pogodimo
  int i = 0;

  float x_velocity, y_velocity;
  path2 HWpath[]; 
  
  public homework(float x, float y)
  {
    x_pos=x;
    y_pos=y;
        
    HWImage[0]=loadImage(HW_default_image_name);
    HWImage[1]=loadImage(SEM_default_image_name);
    //ovo smo vani definirali za slučaj kada bi trebali to ponovo koristiti
    x_size[0]=HW_initial_size;
    y_size[1]=HW_initial_size;
    y_size[0]=x_size[0]*HWImage[0].height/HWImage[0].width;
    x_size[1]=y_size[1]*HWImage[1].width/HWImage[1].height;
       
    x_velocity=0;
    y_velocity=0;

    HWpath= new path2[2];
    HWpath[0]= new path2ellipse(10, 5, 20, 1, -2);
    HWpath[1]= new path2ellipse(0, 10, 60, 0, 1);
    
    type=0;
    health=1;
  }
  
  public void display()
  {
    
    if ( health > 0 ) {
      image(HWImage[type], x_pos+HWpath[type].getx(), y_pos+HWpath[type].gety(), x_size[type], y_size[type]);
    }
    
  }
  
  public void update()
  {
    //zadaća će biti jako malo, samo jedna će se pokazivati istovremeno
    //umjesto polja s zadaćama, koristit ćemo samo jednu zadaću i reciklirati je dok umre
    
    //ovo mozda treba staviti vani
    //provjera je li zadaću pogodio metak
    for ( Bullet bullet : bullets ){
      if ( rect_intersect( x_pos, y_pos, x_pos + x_size[type], y_pos + y_size[type], 
        bullet.x_pos, bullet.y_pos, bullet.x_pos + bullet_img.width, bullet.y_pos + bullet_img.height ) > 0 ) {   

        health --;
        bullet.bingo = true;
      }
    }
    
    if(health == 0)
    {
      float rnd=random(12);
      
      type=int(rnd)/9;
      
      makeHW(type);
    }

    if(y_pos>=height)
    {
      health=0;
    }
    
    HWpath[type].tnext();
            
  }
   
  //t=0 make a homework, t=1 make a seminar
  private void makeHW(int t)
  {
    type=t;
    
    switch(t){
      case 0 :
        x_pos=random(400);
        y_pos=-1*random(600)-400;
        
        
        health=1;
        
      break;
      case 1:
        x_pos=random(400);
        y_pos=-1*random(1000);
        
        health=2;
        
      break;
    }
  }
  
  
  public float get_size_x()
  {
    return x_size[type];
  }
  public float get_size_y()
  {
    return y_size[type];
  }
  
  public void rest()
  {
    makeHW(0);
  }
  
}

//pokušaj da se provjera kolizije bolje implementira
//ako dva pravokutnika imaju neprazan presjek, u koliziji su
//funkcija prima redom:
//xy koordinate gornjeg lijevog vrha prvog pravokutnika
//xy koordinate donjeg desnog vrha prvog pravokutnika
//analogno gornji lijevi i donji desni vrh drugog pravokutnika
float rect_intersect(float x11, float y11, float x12, float y12, float x21, float y21, float x22, float y22)
{
  float x1=max(x11,x21);
  float y1=max(y11,y21);
  
  float x2=min(x12,x22);
  float y2=min(y12,y22);
  
  if(x2==x1 || y1==y2)
  {
    //pravokutnici imaju zajednički rub
    return 0;}
  if(x2<x1 || y2<y1)
  {
    //pravokutnici nemaju ništa zajedničko
    return -1;
  }
  
  //pravokutnici imaju neprazan presjek
  //i slučajno znamo točnu površinu
  return (x2-x1)*(y2-y1);
  
}
