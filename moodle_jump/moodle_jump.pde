//biblioteke
import java.util.ArrayList;
import processing.sound.*;

//globalne varijable
int state = 0;
final int MAIN_MENU = 0;
final int GAME = 1;
final int HIGHSCORES = 2;
final int GAME_OVER = 3;
final int OPTIONS = 4;
final int PAUSE = 5;

//glazba
SoundFile Gauda, Rainbows, Gameover, Fall;
String audioName1 = "Rainbows.mp3";
String audioName2 = "Gauda.mp3";
String audioName3 = "MoodleJump_gameover.mp3";
String audioName4 = "Moodle_Fall.mp3";
int audio = 1;

//neke varijable koje su mi trebale za gameover screen(MK)
int GOTime;
int GOFall;

homework HW;
IntList highscores;
Player p;
Platform last;
ArrayList<Platform> platforms;
ArrayList<Broken_Platform> broken_platforms;
ArrayList<PImage> moodlers;
ArrayList<Bullet> bullets;
PImage bullet_img;
//razmak izmedu linija u pozadinskoj mrezi
MyFloat first_horiz_line;
int line_dist;
int score = 0;

void setup() {
  size(500, 800);
  Rainbows = new SoundFile(this, audioName1);
  Gauda = new SoundFile(this, audioName2);
  Gameover = new SoundFile(this, audioName3);
  Fall = new SoundFile(this, audioName4);
  Rainbows.loop();
  
  first_horiz_line = new MyFloat();
  line_dist = 25;
  highscores = new IntList(0,0,0,0,0,0);
  
  p = new Player(135, 475, 0, 0, 100);
  
  HW= new homework(150,100);
  reset(); //funkcija služi da resetira sve varijable nakon što igrač padne
  
  //slike moodlera
  moodlers= new ArrayList<PImage>(); 
  moodlers.add(loadImage("moodler_D.png"));//0
  moodlers.add(loadImage("moodler_L.png"));//1
  moodlers.add(loadImage("moodler_federi_D.png"));//2
  moodlers.add(loadImage("moodler_federi_L.png"));//3
  moodlers.add(loadImage("moodler_stit_D.png"));//4
  moodlers.add(loadImage("moodler_stit_L.png"));//5
  moodlers.add(loadImage("moodler_propela2_D.png"));//6
  moodlers.add(loadImage("moodler_propela2_L.png"));//7
  moodlers.add(loadImage("moodler_rip_D.png"));//8
  moodlers.add(loadImage("moodler_rip_L.png"));//9
  moodlers.add(loadImage("moodler_ljuti_D.png"));//10
  moodlers.add(loadImage("moodler_ljuti_L.png"));//11 
  //slika metka
  bullet_img = loadImage("metak.png");
  bullet_img.resize(bullet_img.width / 6, bullet_img.height / 6);
  
  textFont(loadFont("BerlinSansFB-Reg-48.vlw"));  
}

void draw_background() {
  
  //vertikalne linije
  for (int x = 0; x < 500; x += line_dist){
    stroke(150);
    //crvena linija
    if (x == 100){
      stroke(205, 92, 92);
    }
    line(x, 0, x, 800);
  }
  //horizontalne linije
  for (float y = first_horiz_line.value ; y < 800; y += line_dist){
    line(0, y, 500, y); 
  }
}

void draw() {
  
  switch(state) {
    
    case MAIN_MENU:

      background(225);
      draw_background();
      textAlign(CENTER);
      textSize(70);
      fill(27);
      text("         Jump", 305, 175);
      textSize(10);
      fill(255, 100, 0);
      fill(27);
      rect(300, 450, 125, 50);
      rect(300, 550, 125, 50);
      rect(300, 650, 125, 50);
      fill(255);
      textSize(15);
      text("START", 362.5, 480);
      text("HIGHSCORES",362.5, 580);
      text("OPTIONS",362.5, 680);
      image(loadImage("moodle.png"), 50, 80, 250, 120);
      
      p.update(platforms, broken_platforms, first_horiz_line);
      p.display();  
    
      if((mouseX > 300 && mouseX < 300+125 && mouseY > 450 && mouseY < 450+50 && mousePressed) || (keyPressed && key == ENTER)){
        state=1;
        if(audio==1){
          Rainbows.stop();
          Gauda.jump(2.5);
        }
      }
      
      if(mouseX > 300 && mouseX < 300+125 && mouseY > 550 && mouseY < 550+100 && mousePressed)
        state=2;
       
      if(mouseX > 300 && mouseX < 300+125 && mouseY > 650 && mouseY < 650+100 && mousePressed)
        state=4;
  
      break;
       
       
    case HIGHSCORES:
    
      background(225);
      draw_background();
      fill(27);
      rect(width/2-62.5, 700, 125, 50);
      textSize(15);
      fill(255);
      textAlign(CENTER);
      text("BACK", width/2, 730);
      textSize(40);
      fill(0);
      //fill(0, 0, 255);
      for(int i = 0; i < 5; i++){
        textAlign(LEFT);
        text((i+1)+".    "+str(highscores.get(i)), width/2-50, 75+(i+1)*100);
      }
      if(mouseX > width/2-62.5 && mouseX < width/2+62.5 && mouseY > 700 && mouseY < 700+50 && mousePressed)
        state=0;
      
      break;
        
    case OPTIONS:
      background(225);
      draw_background();
      textAlign(CENTER);
      textSize(70);
      fill(27);
      image(loadImage("moodle.png"), 50, 80, 250, 120);
      text("         Jump", 305, 175);
      textSize(25);
      fill(255, 100, 0);
      text("A or LEFT for left", width/2, 300);
      text("D or RIGHT for right", width/2, 325);      
      text("LCLICK for shoot", width/2, 350);        
      fill(27);         
      
      rect(width/2-62.5, 700, 125, 50);
      fill(255);
      textAlign(CENTER);
      textSize(15);
      text("BACK", width/2, 730);
      
      if(mouseX > width/2-62.5 && mouseX < width/2+62.5 && mouseY > 700 && mouseY < 700+50 && mousePressed)
          state=0;      
          
      textSize(25);
      fill(0);
      text("SOUND",  width/2, 500);
      rect(width/2-32, 505, 25, 18);
      rect(width/2, 505, 30, 18);
      fill(255);
      textSize(10);
      text("ON        OFF", width/2, 518);
      if(mouseX > width/2-32 && mouseX < width/2-7 && mouseY > 505 && mouseY < 505+18 && mousePressed){
        if(audio==0){
          audio=1;
          Rainbows.loop();
        }
      }
      if(mouseX > width/2 && mouseX < width/2+30 && mouseY > 505 && mouseY < 505+18 && mousePressed){
        audio=0;
        Rainbows.stop();
      }
      
      break;
      
      
    case GAME:
    
      if(audio == 1 && Gauda.isPlaying() == false && p.state != State.RIP)
        Gauda.jump(2.5);
      frameRate(40);
      background(225);
      //update svih platformi
      for (Platform platform : platforms) {       
        platform.update();
      }
      //update playera
      p.update(platforms, broken_platforms, first_horiz_line);
      //update metaka
      for (Bullet bullet : bullets) {
        bullet.update();
      }
      //update cudovista
      HW.update();
      
      draw_background();
  
      //prvo se crtaju platforme pa player da bi player bio 'ispred' njih
      for (Platform platform : platforms) {       
        platform.display();
      }
      //crtanje slomljenih platformi
      for (Broken_Platform broken_platform : broken_platforms) {       
        broken_platform.display();
      }
      //crtanje metaka
      for (Bullet bullet : bullets) {
        bullet.display();
      }
      //crtanje cudovista
      HW.display();
      //crtanje playera
      p.display();  
      
      remove_bullets();
      fill(0);
      textSize(30);
      text("Score: "+str(p.score), 70, 30);
      text("||", width-20, 30);
      
      add_remove_platforms();
      if (p.y > 800+25){
        score = p.score;
        //ako je igrač napravio bolji rekord(top 5), dodaj na listu
        if(highscores.get(5)<score){
          highscores.add(5,score);
          highscores.sortReverse();  
        }
        state=3;
        if(audio==1)
          Gauda.stop();       
        
        if(GOFall==0)
        {
          GOFall=1;
          if(audio==1)
            Fall.play();
        }      
        reset();
      }
      
      break;
      
      
      case PAUSE:       
        fill(27);
        rect(125,650,250,100);
        textSize(40);
        fill(255);
        text("BACK", width/2, 715);        
        
        fill(27);
        rect(125,500,250,100);
        textSize(40);
        fill(255);
        text("RESUME", width/2, 565);
        
                
        if(mouseX > 125 && mouseX < 125+250 && mouseY > 650 && mouseY < 650+100 && mousePressed){
          state=0; 
          reset();
          
          Gauda.stop();
          Gameover.stop();
          if(audio==1)
              Rainbows.loop();          
        }
        if((mouseX > 125 && mouseX < 125+250 && mouseY > 500 && mouseY < 500+100 && mousePressed))          
          state=1;
        
        break;

      
      case GAME_OVER:       
        background(225);
        draw_background();
        textSize(50);
        fill(255,0,0);
        text("GAME OVER", width/2, 150);
        if(score > highscores.get(1)){
          textSize(30);
          fill(0);
          text("NEW RECORD!", width/2,250);
        }
        else {
          textSize(30);
          fill(0);
          text("YOUR SCORE", width/2, 250);
        }
        textSize(50);
        fill(0);
        text(score, width/2, 300);
        if(score < highscores.get(0)){
          textSize(30);
          fill(0);
          text("YOUR HIGHSCORE", width/2, 350);
          textSize(50);
          fill(0);
          text(highscores.get(0), width/2, 400);
        }
        
        fill(27);
        rect(125,650,250,100);
        textSize(40);
        fill(255);
        text("BACK", width/2, 715);
        
        
        fill(27);
        rect(125,500,250,100);
        textSize(40);
        fill(255);
        text("RESTART", width/2, 565);
        
        if(mouseX > 125 && mouseX < 125+250 && mouseY > 650 && mouseY < 650+100 && mousePressed){
          state=0; 
          Gauda.stop();
          Gameover.stop();
          if(audio==1)
              Rainbows.loop();
        }
        if((mouseX > 125 && mouseX < 125+250 && mouseY > 500 && mouseY < 500+100 && mousePressed) || (keyPressed && key == ENTER)){
          state=1;
          if(audio==1){            
            Gameover.stop();
            Gauda.jump(2.5);
          }
        }
        
        if(GOFall==0)
        {
          GOFall=1;
          if(audio==1)
            Fall.play();
          GOTime-=0.8*frameRate;
        }
        
        if(GOFall==1)
        {
          GOTime++;
          
          if(GOTime>0.8*frameRate)
          {
            GOFall=2;
            if(audio==1)
              Gameover.play();
          }
        }
        
        break;       
  }
}

//metak se ispaljuje nakon klika mišem
void mousePressed() {  
  
  //klik na start ili ako je igrač mrtav ne smije ispucati metak
  if (state != 1  || p.state == State.RIP){
    return;
  }

  if(mouseX > width-40 && mouseX < width && mouseY > 0 && mouseY < 30+10){
     if(state != 5)
       state = 5;
  }
  else{
   Bullet new_bullet = new Bullet(mouseX, mouseY);
   bullets.add(new_bullet);
    //Moodler je ljut kad puca
    if (p.state == State.REGULAR){
      p.state = State.ANGRY;
   }   
  }  
}

void keyPressed(){
  
  if (state != 1  || p.state == State.RIP){
    return;
  }
  if(key == 'p'){
     if(state != 5)
       state = 5;
  }
}


void remove_bullets(){

    for (int i = 0; i < bullets.size(); i++) {
    if (bullets.get(i).get_x() + bullet_img.width < 0 || bullets.get(i).get_x() >= width ||
      bullets.get(i).get_y() + bullet_img.height < 0 || bullets.get(i).get_y() >= height) {
        
        bullets.remove(i);
        //ako nema više metaka u zraku, Moodler se odljuti
        if (bullets.size() == 0 && p.state == State.ANGRY){
          p.state = State.REGULAR;
        }
    } 
  }
}
void add_remove_platforms() {
  
  //brise platforme ako su 'izletile' iz prozora
  for (int i=0; i<platforms.size(); i++) {
    if (platforms.get(i).y_pos >= height) platforms.remove(i);
  }
  //brise slomljene platforme
  for (int i=0; i<broken_platforms.size(); i++) {
    if (broken_platforms.get(i).y_pos >= height) broken_platforms.remove(i);
  }

  //broj platformi ovisi o visini na kojoj se igrac nalazi, tj score-u
  //najvise ih je 16(na pocetku), a najmanje 6
  int broj_pl = (16 - p.score/250 > 5) ? (16 - p.score/250) : 6; 
  
  //vjerojatnost da platforma bude obicna
  //vjerojatnost je obrnuto proporcionalna score-u
  float P_obicna = (p.score/3000 < 1) ? (1 - (Float.valueOf(p.score)/3000)): 0;
  //System.out.println(P_obicna);
  
  //vjerojatnost da platforma bude pomicna
  //vjerojatnost da platforma bude nestajuća je tada (1 - P_obicna - P_pomicna)
  float P_pomicna = (p.score/6000 < 1) ? (P_obicna - (Float.valueOf(p.score)/6000)) : 0;
  
  //prvo crtamo platforme koje se slamaju
  //njihov broj je konstantan = 3
  while(broken_platforms.size() < 3){
    Broken_Platform new_broken = new Broken_Platform(random(425), -300  * broken_platforms.size());
    broken_platforms.add(new_broken);
  }
  
  //sada crtamo ostale platforme
  int razmak = 800/(broj_pl - 1);
  Platform new_platform;
  
  //vjerojatnost da se supermoći nalaze na platformi
  double P_federi = (double)5/400;
  //System.out.println(P_federi);
  double P_stit = (double)2/400;
  //System.out.println(P_stit);
  double P_propela = (double)1/400;
  //System.out.println(P_propela);
  
  while (platforms.size() < broj_pl) {
    
    String superpower = "";
    
    //o vrijednosti rnd ovisi koja vrsta platforme ce se stvoriti, te
    //hoce li i koja supermoc biti na toj platformi
    float rnd = random(0, 1);

    if (rnd <= P_propela) {
      //System.out.println("propela");
      superpower = "propela";
    }
    else if (rnd <= P_propela + P_stit) {
      //System.out.println("stit");
      superpower = "stit";
    }
    else if (rnd <= P_propela + P_stit + P_federi) {
      //System.out.println("federi");
      superpower = "federi";
    }
     
    if (rnd <= P_obicna){
      new_platform = new Regular_Platform(random(425), last.get_y() - razmak, superpower);
    }
    else if (rnd <= P_obicna + P_pomicna){
      new_platform = new Moving_Platform(random(425), last.get_y() - razmak, superpower);
    } 
    else {
      new_platform = new Disappearing_Platform(random(425), last.get_y() - razmak, superpower);
    }  
    
    platforms.add(new_platform);
    last = new_platform;
  }   
}



//funkcija služi da resetira sve varijable nakon što igrač padne
void reset(){
  
 //inicijalizacija liste platformi
  platforms = new ArrayList<Platform>();
  
  //pocetna platforma
  last = new Regular_Platform(100, 700, "");
  platforms.add(last);
  
  //inicijalizacija liste metaka
  bullets = new ArrayList<Bullet>();
  
  //inicijalizacija liste slomljenih platformi(prazna lista)
  broken_platforms = new ArrayList<Broken_Platform>();
  
  p.x=80;
  p.y=475;
  p.x_velocity=0;
  p.y_velocity=0;
  p.score = 0;
  p.gravity = 2;
  p.state = State.REGULAR;
  p.orientation = Orientation.RIGHT;
  
  first_horiz_line.value = 0;
  
  HW.y_pos=100;
  //šta je sad ovo?
  //umjesto toga
  HW.rest();
  
  
  GOTime=0;
  if(GOFall!=1)
  {GOFall=0;}
  
}
