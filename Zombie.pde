class Civilian
{
  int zombieType, w, h, x, y, imagSelN, counter;
  PImage zomSpriteSheet, civSpriteSheet;
  ArrayList<PImage> zombieSprites = new ArrayList<PImage>();
  ArrayList<PImage> healedSprites = new ArrayList<PImage>();
  Body civBody;
  BodyDef zb;
  PolygonShape zbs;
  FixtureDef zbfd;
  Vec2 civPos, rMov, lMov, shortJump, highJump, Velocity;
  boolean spawned, healed, civCanJump;
  PImage selector;
  Civilian(int xs, int ys, int ws, int hs, boolean cond)
  {

    zombieType = int(random(1, 9));
    loadAnimation();


    healed = cond;
    x=xs;
    y=ys;
    w = ws;
    h = hs;

    resetzombieBody();

    civBody.setUserData(this);
    rMov = new Vec2(10, 0);
    lMov = new Vec2(-10, 0);
    shortJump = new Vec2(0, 10);
    highJump = new Vec2(0, 20);

    // path = new Vec2(random(-50, 50), 0);
  }
  void loadAnimation()
  {
    civSpriteSheet = loadImage("CivilianSheet"+zombieType+".png");
    for (int i = 1; i <3; i++)
    {
      for (int p = 1; p <4; p++)
      {
        healedSprites.add(civSpriteSheet.get(32*p, i*32, 25, 32));
      }
    }
    healedSprites.add(civSpriteSheet.get(32, 0, 32, 32));



    zomSpriteSheet = loadImage("ZombieSheet"+zombieType+".png");
    for (int i = 1; i <3; i++)
    {
      for (int p = 1; p <4; p++)
      {
        zombieSprites.add(zomSpriteSheet.get(32*p, i*32, 25, 32));
      }
    }
    zombieSprites.add(zomSpriteSheet.get(32, 0, 30, 32));


    selector = healedSprites.get(6);
  }
  void move(Player myplayer)
  {
    if (healed == false)
    {

      if (mainMenu.levSel ==3 || (civPos.y<myplayer.plPos.y+50&&civPos.y>myplayer.plPos.y-50) )
      {
        rMov.set(30, 0);
        lMov.set(-30, 0);

        if (civPos.x > myplayer.plPos.x)
        {
          civBody.applyForce(lMov, myplayer.plPos);
        } else
        {
          civBody.applyForce(rMov, myplayer.plPos);
        }
      } else if (mainMenu.levSel ==2)
      {


        if ((civPos.y <= 100&&civPos.y>0)||(civPos.y<=300&&civPos.y>200)||(civPos.y<=500&&civPos.y>400))
        {
          if (civPos.y>myplayer.plPos.y)

          {
            civBody.applyForce(lMov, myplayer.plPos);
          } else
          {
            civBody.applyForce(rMov, myplayer.plPos);
          }
        } else
        {
          if (civPos.y>myplayer.plPos.y)

          {
            civBody.applyForce(rMov, myplayer.plPos);
          } else
          {
            civBody.applyForce(lMov, myplayer.plPos);
          }
        }
      } 
      if (civCanJump)
      {
        if (myplayer.plPos.y+20<civPos.y)
        { 

          civBody.applyLinearImpulse(highJump, myplayer.plPos, false);
          civCanJump = false;
        } else
        { 
          civBody.applyLinearImpulse(shortJump, myplayer.plPos, false);
          civCanJump = false;
        }
      }
    }

    civBody.applyForce(new Vec2(random(-20, 20), 0), myplayer.plPos);
  } 





  void display()
  {


    Velocity = civBody.getLinearVelocity();
    civPos = world.getBodyPixelCoord(civBody);   
    pushMatrix();
    translate(civPos.x, civPos.y);
    imageMode(CENTER);



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
      if (imagSelN > 1)
      {
        imagSelN=0;
      }
    }



    if (Velocity.x <= -2)
    {
      if (healed == true)
      {
        selector = healedSprites.get(imagSelN);
      } else
      {

        selector = zombieSprites.get(imagSelN);
      }
    }
    if (Velocity.x >= 2)
    {
      if (healed == true)
      {
        selector = healedSprites.get(imagSelN+3);
      } else
      {

        selector = zombieSprites.get(imagSelN+3);
      }
    }  
    if ((Velocity.x >-2&&Velocity.x  <2) || myplayer.dead)
    {

      if (healed == true)
      {
        selector = healedSprites.get(6);
      } else
      {

        selector = zombieSprites.get(6);
      }
    }


    selector.resize(0, 45);

    image(selector, 0, 3);


    popMatrix();
  }



  void resetzombieBody()
  {



    zb = new BodyDef();      
    zb.type = BodyType.DYNAMIC;



    zb.position.set(world.coordPixelsToWorld(x, y));
    civBody = world.createBody(zb);
    // Define a polygon (this is what we use for a rectangle)
    PolygonShape zbs = new PolygonShape();
    float box2dW = world.scalarPixelsToWorld(w/2);
    float box2dH = world.scalarPixelsToWorld(h/2);  // Box2D considers the width and height of a
    zbs.setAsBox(box2dW, box2dH);            // rectangle to be the distance from the
    // center to the edge (so half of what we
    // normally think of as width or height.) 
    // Define a fixture
    FixtureDef zbfd = new FixtureDef();
    zbfd.shape = zbs;

    zbfd.friction = 0;
    zbfd.restitution =0;


    // Parameters that affect physics
    //body2 = world.createBody(pl);
    // Attach Fixture to Body               
    civBody.createFixture(zbfd);
    zb.position.set(world.coordPixelsToWorld(900, 300));
  }


  void infect(Civilian other) 
  {
    if (other.healed == false)
    {
      //println("hitt!");
      healed = false;
      //println("ohno");


      //zombies.remove(this);
    }
  }


  boolean hit(Bullet bullet) {

    if (bullet.bx > civPos.x-20 && bullet.bx < civPos.x+20
      && bullet.by > civPos.y-20 && bullet.by < civPos.y+20)
    {

      healed = true;
      return true;
    }


    return false;
  }
}