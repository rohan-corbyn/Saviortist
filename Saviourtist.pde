import ddf.minim.*; //<>//
import shiffman.box2d.*;
import org.jbox2d.common.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.dynamics.*;
import org.jbox2d.dynamics.contacts.*;


Minim minim;
AudioPlayer music;
AudioPlayer growl;
AudioPlayer die;
AudioSample shoot;




Box2DProcessing world; 
Map map;
Hud hud;
Block block;
Game game;
Mech mech;
MainMenu mainMenu;
Eagle eagle;
Player myplayer;
Sound sound;

ArrayList<Civilian> civilians = new ArrayList<Civilian>();
ArrayList<Eagle> eagles = new ArrayList<Eagle>();
ArrayList<Block> blocks= new ArrayList<Block>();
Vec2 worldSize;
boolean inMenu;

void setup() 
{


  smooth();
  frameRate(100);
  noStroke();
  size(600, 600);
  minim = new Minim(this);
  growl = minim.loadFile("growlSound.aif");

  shoot = minim.loadSample("Water Drip 01.wav");
  die = minim.loadFile("DethSound.aif");
  music = minim .loadFile("Blue in Green (Oliver Palfreyman).aif");

  //box2d
  world = new Box2DProcessing(this);
  world.createWorld();
  world.setGravity(0, -30);
  world.listenForCollisions();

  inMenu =true;


  sound = new Sound();
  game= new Game(); 
  mech = new Mech();
  mainMenu= new MainMenu(); 
  hud = new Hud();
}

void draw() 
{ 

  background(0);




  //characterSelection();


  if (inMenu==true)
  {

    mainMenu.menu();
  } else
  {
    game.runGame();
    sound.triggers(myplayer.dead);
  }
  sound.music();
  rectMode(CENTER);
}




void hit(Bullet bullet) {

  for (Civilian civilian : civilians) {  

    if (civilian.hit(bullet)) {
      return;
    }
  }
} 