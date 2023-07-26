class Eagle
{

  PImage eagleSpriteSheet, selector, selector2;

  ArrayList<PImage> eagleSprites = new ArrayList<PImage>();
  boolean flyleft, eagleType, eagleHealed;
  int  imagSelN, counter;
  int time, flyup, ammo;
  float aim, speed, x, y, restY;
  Eagle()
  {

    ammo = 20;
    eagleType = randomBool();
    eagleSpriteSheet = loadImage("eagleSprites.png");
    if (eagleType)

    {
      for (int p = 0; p<2; p++)
      {
        for (int i = 0; i<3; i++)
        {
          eagleSprites.add(eagleSpriteSheet.get(i*40, p*36, 40, 36));
        }
      }
    } else

    {
      eagleSprites.add(eagleSpriteSheet.get(120, 0, 40, 36)); 
      eagleSprites.add(eagleSpriteSheet.get(160, 0, 40, 36));  
      eagleSprites.add(eagleSpriteSheet.get(200, 0, 40, 36)); 

      eagleSprites.add(eagleSpriteSheet.get(120, 36, 40, 36));  
      eagleSprites.add(eagleSpriteSheet.get(160, 36, 40, 36)); 
      eagleSprites.add(eagleSpriteSheet.get(200, 36, 40, 36));
    }





    x = -200;
    restY = int(random(height/2-100));

    y = restY;
    eagleHealed = true;
  }

  void display()
  {
    counter ++;
    if (counter % 30 == 0)
    {
      imagSelN++;
    }
    if (counter >= 30)
    {
      counter = 0;
    }
    if (imagSelN > 2)
    {
      imagSelN=0;
    }



    if (!flyleft)
    {
      selector = eagleSprites.get(imagSelN);
    }

    if (flyleft)
    {        
      selector = eagleSprites.get(imagSelN+3);
    }

    pushMatrix();
    imageMode(CENTER);
    translate(x, y);

    image(selector, 0, 0);

    if (eagleHealed==false)
    {
      translate(-10, 10);

      rotate(-aim+10);

      image(myplayer.needle, 0, 0);
    }
    popMatrix();
  }
  void shoot()
  {


    if (eagleHealed==false) {

      aim = atan2(mouseX - x, mouseY - y);
      if (millis() - time >= 500) {
        myplayer.bullets.add( new Bullet(x-10, y+10, aim));


        ammo--;
        time = millis();
      }
      if (ammo <=0)
      {
        eagleHealed = true; 
        ammo = 20;
      }
    }
  }


  void move()
  {
    if (mech.slomo)
    {
      speed = 0.5;
    } else
    {
      speed = 1;
    }







    if (eagleHealed == true)
    {
      flyup = 0;

      if (x < -100)
      {
        flyleft = true;
      }
      if (x > width+100)
      {
        flyleft = false;
      }
      if (y < restY)
      {
        flyup = 2;
      } else if (y==restY)
      {
        flyup = 0;
      } else
      {
        flyup = 1;
      }
    } else
    {
      if (x>myplayer.plPos.x+80)
      {


        flyleft = false;
      } else if  (x< myplayer.plPos.x-80)
      {

        flyleft = true;
      }
      if (y<myplayer.plPos.y-80)
      {
        flyup = 2;
      } else if  (y>myplayer.plPos.y+80)
      {

        flyup=1;
      }
    }
    if (flyleft)   
    {
      x=x+speed;
    } else if (!flyleft)   
    {
      x=x-speed;
    }
    if (flyup==1)   
    {
      y=y-speed;
    } else if (flyup==2)   
    {
      y=y+speed;
    }
  }

  void playerHit(Player myplayer) {



    if (x > myplayer.plPos.x-10 && x < myplayer.plPos.x+10
      && y > myplayer.plPos.y-10 && y < myplayer.plPos.y+10)
    {

      if (mainMenu.power==4)
      {
        eagleHealed =false;
      }
    }
  }

  boolean randomBool() {
    return random(1) >= .5;
  }
}