class Mech
{
  int spawnDel, spawnPosx, spawnPosy;
  int time;
  boolean zomPosSwitch, slomo;
  Mech()
  {
  }
  void zombieSpawner()
  {
    spawnDel = 8000-(mainMenu.levSel*2000);

    if (myplayer.dead == false)
    {
      if (civilians.size() < 20+(mainMenu.levSel*5))
      {

        if (millis() - time >= spawnDel) {
          if (mainMenu.levSel ==1 )
          {

            spawnPosx = int(random(50, 550));
            spawnPosy = 50;
          } else if (mainMenu.levSel ==2)
          {
            if (zomPosSwitch == true)
            {
              spawnPosx = 550;
              zomPosSwitch=false;
            } else

            {
              spawnPosx = 50;        
              zomPosSwitch=true;
            }
          } else
          {
            spawnPosx = int(random(50, 550));
            spawnPosy = int(random(50, 400));
          }

          civilians.add(new Civilian(spawnPosx, spawnPosy, 28, 40, false));

          map.createMap(mainMenu.levSel);

          time = millis();
        }
      }
    }
  }
  void motion()
  {



    if (game.paused==false)
    {

      if (mainMenu.power == 2)
      {
        frameRate(65);
      } else
      {
        frameRate(100);
      }



      if (mainMenu.power == 2)
      {

        for (int i = 0; i<10; i++)
        {

          if (keyPressed)
          {


            slomo = true;
            if (i ==0)
            {

              world.step();
            }
          } else

          {
            if (i ==0|| i == 4)
            {
              world.step();
              slomo =false;
            }
          }
        }
      } else

      {

        world.step();
        slomo =false;
      }
    }
  }
  void healthbar(int Plhealth)
  {

    pushMatrix();
    rectMode(LEFT);
    fill(255, 0, 0);
    rect(Plhealth*5, 25, 10, 15);
    popMatrix();
  }
}