class Hud
{
  PImage tvFuzzStill, selector;
  ArrayList<PImage> tvFuzz = new ArrayList<PImage>();
  int counter, imagSelN, riseTint;
  Hud()
  {
    riseTint=0;
    counter = 0;
    imagSelN=1;
    for (int i = 1; i<=7; i++)
    {
      tvFuzzStill =  loadImage("fuzz"+i+".png");
      tvFuzz.add(tvFuzzStill);
    }
  }


  void tvFuzz(boolean dead)
  {

    counter ++;
    if (counter % 100 == 0)
    {
      imagSelN++;
    }

    if (counter >= 1000)
    {
      counter = 0;
    }

    if (imagSelN >= 7)
    {
      imagSelN=1;
    }

    selector = tvFuzz.get(imagSelN);
    if (dead)
    {
      if (riseTint<=255)
      {
        riseTint++;
      }
    } else


    {

      riseTint=70;
    }
    tint(240, riseTint);



    selector.resize(600, 600);
    imageMode(CENTER);
    image(selector, width/2, height/2);
    tint(255, 255);
  }
}