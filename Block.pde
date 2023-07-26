class Block

{    
  Body blockBody;
  float x, y, w, h, col;
  boolean detectCol;

  Block(float xp, float yp, int ws, int hs, int colour, boolean detectcol)
  {
    w = ws;
    h = hs;
    x=xp;
    y=yp;    
    buildBlockBody();
    col = colour;
    detectCol = detectcol;
  }

  void display()
  {
    Vec2 blockPos = world.getBodyPixelCoord(blockBody);   

    pushMatrix();
    rectMode(CORNERS);
    translate(blockPos.x-w/2, blockPos.y);
    fill(col);
    rect(0, -10, w, h);   
    popMatrix();
  }
  void buildBlockBody()
  {

    BodyDef blbd = new BodyDef();      
    blbd.type = BodyType.STATIC;
    blbd.position.set(world.coordPixelsToWorld(x, y));
    blockBody = world.createBody(blbd);


    // Define a polygon (this is what we use for a rectangle)
    PolygonShape blps = new PolygonShape();
    float box2dW = world.scalarPixelsToWorld(w/2);
    float box2dH = world.scalarPixelsToWorld(h/2);  // Box2D considers the width and height of a
    blps.setAsBox(box2dW, box2dH);            // rectangle to be the distance from the
    // center to the edge (so half of what we
    // normally think of as width or height.) 
    // Define a fixture  
    FixtureDef blfd = new FixtureDef();
    blfd.shape = blps;
    // Parameters that affect physics
    // fd.density = 10;

    if (detectCol==false)
    {
      blfd.friction = 0.01;
      blfd.restitution = 0;
    } else
    {

      blfd.friction = 1;
      blfd.restitution = 0.5;
    }
    blockBody.setUserData(this);
    // Attach Fixture to Body               
    blockBody.createFixture(blfd);
  }
}   