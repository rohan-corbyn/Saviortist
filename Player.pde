class Player 
{
  PImage plSpriteSheet, deadSprite, selector, needle;

  Body playerBody;
  BodyDef pl;
  PolygonShape pls;
  FixtureDef fd;

  boolean canJump, cantmove, dead, shooting, eagleTrig;

  ArrayList<Bullet> bullets = new ArrayList<Bullet>();
  ArrayList<PImage> playerSprites = new ArrayList<PImage>();

  int w, h, x, y, health, ammo, maxAmmo, imagSelN, counter, time, plType;

  float aim;



  Vec2 plPos, rMov, lMov, jump, Velocity, nPos;


  Player(int xs, int ys, int PlType)
  {   
    plType = PlType;


    loadAnimation();


    shooting = false;

    x=xs;
    y=ys;

    w=27;
    h=40;

    //center = world.coordPixelsToWorld(20, 50);
    rMov = new Vec2(50, 0);
    lMov = new Vec2(-50, 0);

    maxAmmo = 5;
    ammo = maxAmmo;
    health= 20;

    counter = 0;

    nPos = new Vec2(13, 13);
    sound.dieTrig=true;
    resetBody();
  }


  void loadAnimation()
  {
    needle = loadImage("needle.png");
    needle.resize(0, 40);
    plSpriteSheet = loadImage("ScientistSheet"+plType+".png");
    for (int i = 0; i <3; i++)
    {
      for (int p = 0; p <3; p++)
      {
        playerSprites. add(plSpriteSheet.get(32*p, 32*i, 32, 32));
      }
    }
    deadSprite =  loadImage("ZombieSheet3.png");
    selector = playerSprites.get(1); 
    imagSelN = 0;
  }


  void move()
  {
    jump = new Vec2(0, 15);


    Velocity = playerBody.getLinearVelocity();


    if (dead == false)
    {
      if (keyPressed == true)
      {

        if (key == 'd')
        {

          playerBody.applyForce(rMov, plPos);
        }
        if (key == 'a')
        {
          playerBody.applyForce(lMov, plPos);
        }




        if (canJump == true)
        {

          if (mech.slomo == true)
          {


            rMov.set(100, 0);
            lMov.set(-100, 0);
          } else
          {
            rMov.set(100, 0);
            lMov.set(-100, 0);
          }



          if (key == 'w')
          {

            playerBody.applyLinearImpulse(jump, plPos, true);
          }
        }
        if (canJump == false)
        {

          rMov.set(20, 0);
          lMov.set(-20, 0);
        }
      }
    }
  }

  void infect()
  {
    health -= 1;
    
  }
  void checkDeath()
  {

    if (health <= 0)
    {
       
      dead = true;
     
    } else
    {
      dead = false;
    }
  }

  void ammoReplenish()
  {
    if (ammo<maxAmmo)
    {
      ammo +=1;
    }
  }
  void gun()
  {
    Vec2 jump = new Vec2(0, 15);

    if (mousePressed==true&&!dead) {


      if  (ammo > 0)
      { 



        sound.shootTrig=true;
        shooting = true;
        myplayer.bullets.add( new Bullet(nPos.x, nPos.y, aim));
        ammo = myplayer.ammo -1;
        mousePressed = false;
        eagleTrig = true;

        if (mainMenu.power ==3)
        {
          playerBody.applyLinearImpulse(jump, plPos, true);
        }
        if (mainMenu.power ==1)
        {

          myplayer.bullets.add( new Bullet(nPos.x, nPos.y, aim-0.2));

          myplayer.bullets.add( new Bullet(nPos.x, nPos.y, aim+0.2));
        }
      }
    }


    if (millis() - time >= 1000) {

      ammoReplenish();
      time = millis();
    }

    aim = atan2(mouseX - plPos.x, mouseY - plPos.y);

    for (Bullet bullet : bullets) {

      if (bullet.dist < 30)
      {
        bullet.update();
        bullet.display();
      }
    }
  }


  void display()
  {


    plPos = world.getBodyPixelCoord(playerBody);   
    pushMatrix();
    translate(plPos.x, plPos.y);

    // imageMode(CENTER);

    if (dead == false)
    {

      if (Velocity.x != 0)
      {  
        counter ++;
        if (counter % 20 == 0)
        {
          imagSelN++;
        }

        if (counter >= 20)
        {
          counter = 0;
        }

        if (imagSelN > 2)
        {
          imagSelN=0;
        }
      }



      if (Velocity.x > 0 && Velocity.x< 10)
      {

        selector = playerSprites.get(0);
      }
      if (Velocity.x < 0 && Velocity.x > -10)
      {

        selector = playerSprites.get(2);
      }

      if (Velocity.x < -7)
      {

        selector = playerSprites.get(imagSelN+3);
      }
      if (Velocity.x > 7)
      {

        selector = playerSprites.get(imagSelN+6);
      }




      if (Velocity.x == 0 )
      {

        selector = playerSprites.get(1);
      }

      if (Velocity.x < 7&&Velocity.x > -7)
      {
        if (aim<0)
        {
          nPos.set(-13, 13);
        } else
        {
          nPos.set(13, 13);
        }
      } else
      {
        nPos.set(0, 15);
      }
    } else 
    {
      selector = deadSprite.get(32, 0, 32, 32);
    }



    selector.resize(0, 45);

    image(selector, 0, 2);






    popMatrix();
    nPos = plPos.add(nPos);


    if (!dead&&shooting)
    {

      pushMatrix();

      translate(nPos.x, nPos.y);
      rotate(-aim+10);
      imageMode(CENTER);
      image(needle, 0, 0);

      popMatrix();
    }
  }

  void resetBody()
  {

    pl = new BodyDef();      
    pl.type = BodyType.DYNAMIC;

    pl.position.set(world.coordPixelsToWorld(150, 200));

    playerBody = world.createBody(pl);
    PolygonShape pls = new PolygonShape();
    float box2dW = world.scalarPixelsToWorld(w/2);
    float box2dH = world.scalarPixelsToWorld(h/2);  // Box2D considers the width and height of a
    pls.setAsBox(box2dW, box2dH);            // rectangle to be the distance from the
    // center to the edge (so half of what we
    // normally think of as width or height.) 
    // Define a fixture
    FixtureDef fd = new FixtureDef();
    fd.shape = pls;

    fd.friction =  120;
    fd.restitution = 0;

    playerBody.setUserData(this);


    playerBody.createFixture(fd);
  }
}