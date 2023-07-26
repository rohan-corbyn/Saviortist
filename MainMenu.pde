class MainMenu
{
  PImage plSpriteSheet, lvlSpriteSheet, chrSelector, lvlSelector, Heading;

  ArrayList<String> chrInfo = new ArrayList<String>();
  ArrayList<String> lvlInfo = new ArrayList<String>();
  int plSel, power, levSel, skinCol;
  int time;
  boolean paused, zomSpawnPos, clicked;
  MainMenu()
  {
    plSel =1;
    levSel =1;
    paused = false;
    Heading = loadImage("Heading.png");
    Heading.resize(250, 70);
  }



  void menu()
  {
    chrInfo.add("No match when it comes to healing.");
    chrInfo.add("As the physicist you will be able to slow down time while you move.");
    chrInfo.add("Chemistry. when shooting, explosive rounds are used to launch himself into the air.");
    chrInfo.add("As a biologist you never alone. Collide with an eagle to befriend it.");

    lvlInfo.add("The zombies on this level will only detect you if they can see you.");
    lvlInfo.add("The zombies on this know where you are, and know how to get you ");
    lvlInfo.add("The zombies have become ruthless human hunters. You can run but you cant hide.");
    blocks.removeAll(blocks);

    plSpriteSheet = loadImage("ScientistSheet"+plSel+".png");

    lvlSpriteSheet = loadImage("Level"+levSel+".png");
    lvlSpriteSheet.resize(100, 100);
    chrSelector = plSpriteSheet.get(32, 0, 32, 32);

    button(width/2-100, height/2-150, 50);

    if (clicked)
    {
      if (plSel%2 ==0)
      {
        plSel--;
      }
    }  

    button(width/2+100, height/2-150, 50);
    if (clicked)
    {  
      if (plSel%2 !=0)
      {
        plSel++;
      }
    }


    button(width/2-100, height/2-75, 50);
    if (clicked)
    {  
      plSel = plSel-2;
    }

    button(width/2+100, height/2-75, 50);
    if (clicked)
    {
      plSel = plSel+2;
    }

    button(width/2+100, height/2+75, 50);
    if (clicked)
    {
      levSel = levSel+1;
    }
    button(width/2-100, height/2+75, 50);
    if (clicked)
    {
      levSel = levSel-1;
    }



    button(width/2, height/2+200, 50);

    if (clicked)
    {
      game.loadGame(levSel, plSel);
    }

    if (plSel ==0)
    {
      plSel = 8;
    }
    if (plSel < 0)
    {
      plSel = 7;
    }
    if (plSel ==9)
    {
      plSel = 1;
    }
    if (plSel >9)
    {
      plSel = 2;
    }

    if (levSel ==0)
    {
      levSel =3;
    }
    if (levSel ==4)
    {
      levSel =1;
    }




    if (plSel%2 ==0)
    {
      fill(0);
      rect(width/2+100, height/2-150, 50, 50);
    } else
    {
      fill(0);

      rect(width/2-100, height/2-150, 50, 50);
    }


    if (plSel==1||plSel==2)
    {
      power =1;
    } else if (plSel==3||plSel==4)
    {
      power=2;
    } else if (plSel==5||plSel==6)
    {
      power=3;
    } else if (plSel==7||plSel==8)
    {
      power=4;
    }

    fill(255);
    chrSelector.resize(100, 100);
    imageMode(CENTER);
    image(Heading, width/2, 75);
    image(chrSelector, width/2, height/2-100);
    textAlign(CENTER);

    text(chrInfo.get(power-1), width/2, height/2);
    text(lvlInfo.get(levSel-1), width/2, height/2+150);
    textAlign(RIGHT);
        text("music by Oliver Palfreymen and Maxwell Owin",width/2,height-25);
        
    image(lvlSpriteSheet, width/2, height/2+75);


    hud.tvFuzz(false);
  }
  void tips()
  {
  }

  void button(int posx, int posy, int size)
  {
    clicked=false;
    rectMode(CENTER);
    rect(posx, posy, size, size);
    if (mouseX > posx-size/2 && mouseX < posx+size/2 &&
      mouseY >posy-size/2&&mouseY <posy+size/2&&mousePressed)
    {


      clicked = true;
      mousePressed=false;
    }
  }
}