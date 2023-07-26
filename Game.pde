class Game
{
  int chrSel, saved;
  int time;
  boolean paused;
  PImage GameOver;
  Game()
  {

    chrSel =1;
    paused = false;
  }
  void loadGame(int levSel, int plSel)
  {     



    GameOver = loadImage("GameOver.png");

    GameOver.resize(250, 100);
    eagle = new Eagle();
    //player & NPCs

    map = new Map();


    map.mapGeneral();
    map.createMap(levSel);



    //map.displayMap(); 
    myplayer = new Player(width/2, 50, plSel);
    eagles.add(new Eagle());
    inMenu=false;
  }
  void runGame()
  {


    map.displayMap(); 


    myplayer.move();
    myplayer.display();




    for (Eagle eagle : eagles) {
      eagle.shoot();
      eagle.display();
      eagle.move();
      eagle.playerHit(myplayer);
    }

    mech.motion();
    mech.healthbar(myplayer.health);
    mech.zombieSpawner();

    for (Civilian civilian : civilians) {
      civilian.display();
      civilian.move(myplayer);
    }
    myplayer.checkDeath();
    myplayer.gun();
    hud.tvFuzz(myplayer.dead);
    game.gameOver();
  } 
  void gameOver()
  {
    textAlign(CENTER);
    if (civilians.size() >= 20)
    {

      for (Civilian civilian : civilians) {
        if (civilian.healed == true)
        {
          saved++;
          civilian.healed =false;
        }
        if (saved >= civilians.size());
        {

          paused = true; 
          text("WellDone", width/2, height/2);
          text("you survived the outbreak!", width/2, height/2+30);
          text("press 'r' to continue", width/2, height/2+60);



          // textFont(fnt);




          if (key =='r')
          {

            inMenu=true;
            resetGame();


            time = millis();
          }
        }
      }
    }



    if (myplayer.dead)
    {
      paused = true; 






      image(GameOver, width/2, height/2-100);

      text("press 'r' to continue", width/2, height/2+30);


      if (key =='r')
      {

        inMenu=true;
        resetGame();


        time = millis();
      }
    }
  }

  void resetGame()
  {
   
    for (Civilian civilian : civilians) {  
      world.destroyBody(civilian.civBody);
    } 
    civilians.removeAll(civilians);


    for (Block block : blocks) {  
      world.destroyBody(block.blockBody);
    } 

    eagles.removeAll(eagles);




    world.destroyBody(myplayer.playerBody);
 

    myplayer.health = 25;
    myplayer.dead = false;
    paused = false;
  }
}