class Sound
{


  PImage tvFuzzStill;
  ArrayList<PImage> tvFuzz = new ArrayList<PImage>();
  boolean dieTrig,shootTrig;
  Sound()
  {
    minim = new Minim(this);

    music.play();
  }
  void music()
  {
    if (inMenu==false)
    {
      growl.play();
    }




    if ( music.position() == music.length() )
    {
      music.rewind();
      music.play();
    }
    if ( growl.position() == growl.length() )
    {
      growl.rewind();
      growl.play();
    }
  }

  void triggers(Boolean Dead)
  {
    
    
  
    
    if (myplayer.shooting&&shootTrig)
    {
      shoot.trigger();

      shootTrig=false;
    }
    if (Dead&&dieTrig)
    {
       
      die.play();
   
       die.rewind();
      dieTrig=false;
    }
 
  }
}