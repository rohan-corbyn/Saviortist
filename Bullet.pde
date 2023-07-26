class Bullet {

  int bulletSpeed, r, g, b;
  float bxs, bys, bx, by, dist;
  String colour;
  // values for bullet coming from 'shoot()' function, float ang = rad-0.5*PI
  Bullet(float bxi, float byi, float aim) {
    //set initial bullet position to the players position
    bx = bxi;
    by = byi;   

    dist = 0;
    bulletSpeed = 4;
    bxs = bulletSpeed * cos(-(aim-0.5*PI));
    bys = (bulletSpeed+(dist*dist)) * sin(-(aim-0.5*PI));

    if (mainMenu.power ==1)
    {
      r=255;
      g=255;
      b=255;
    }
    if (mainMenu.power ==2)
    {
      r=255;
      g=255;
      b=0;
    }
    if (mainMenu.power ==3)
    {
      r=255;
      g=0;
      b=0;
    }
    if (mainMenu.power ==4)
    {
      r=0;
      g=255;
      b=50;
    }
  }


  void update() {
    //this function sends the bullet in the direction of the mouse

    bx=bx+bxs;
    by=by+bys;
    dist = dist +1;
  }



  void display() {   
    pushMatrix();
    translate(bx, by);
    fill(r, g, b);
    ellipse(0, 0, 5, 5);
    popMatrix();
    hit(this);
  }
}