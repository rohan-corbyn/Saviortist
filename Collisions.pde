void beginContact(Contact cp) {

  Fixture f1 = cp.getFixtureA();
  Fixture f2 = cp.getFixtureB();
  // Get both bodies
  Body b1 = f1.getBody();
  Body b2 = f2.getBody();
  // Get our objects that reference these bodies
  Object o1 = b1.getUserData();
  Object o2 = b2.getUserData();

  //player collision
  if (o1.getClass() == Player.class && o2.getClass() == Block.class) 
  {

    Block block = (Block) o2;
    if (block.detectCol)
    {
      myplayer.canJump = true;
    }
  }
  if (o1.getClass() == Player.class && o2.getClass() == Civilian.class) {

    Player p1 = (Player) o1;
    Civilian civ1 = (Civilian) o2;


    if (civ1.healed ==true)
    {
      p1.ammoReplenish();
    }
    if (civ1.healed ==false)
    {
      p1.infect();
    }
  }

  //civilian collisions
  if (o1.getClass() == Civilian.class && o2.getClass() == Block.class) {
    Civilian civ1 = (Civilian) o1;

    //  print("ilanded");
    civ1.civCanJump = true;
  }


  if (o1.getClass() == Civilian.class && o2.getClass() == Civilian.class) {
    Civilian civ1 = (Civilian) o1;
    Civilian civ2 = (Civilian) o2;
    civ1.infect(civ2);
    civ1.civCanJump = true;
  }
  // player and zombie collision
}







void endContact(Contact cp2) {


  Fixture f1 = cp2.getFixtureA();
  Fixture f2 = cp2.getFixtureB();
  // Get both bodies
  Body b1 = f1.getBody();
  Body b2 = f2.getBody();

  // Get our objects that reference these bodies
  Object o1 = b1.getUserData();
  Object o2 = b2.getUserData();



  if ((o1.getClass() == Player.class && o2.getClass() == Block.class))
  {

    Block block = (Block) o2;
    if (block.detectCol)
    {
      myplayer.canJump = false;
    }
  }

  if ((o1.getClass() == Civilian.class  && o2.getClass() == Block.class))
  {

    Civilian civ1 = (Civilian) o1;

    civ1.civCanJump = false;
  }
  if (o1.getClass() == Civilian.class && o2.getClass() == Civilian.class) {

    Civilian civ1 = (Civilian) o1;
    Civilian civ2 = (Civilian) o2;
    civ2.infect(civ1);
    civ2.civCanJump = false;
  }
}