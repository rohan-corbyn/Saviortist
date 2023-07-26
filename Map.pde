class Map
{


  int time, mapN;

  Map() {



    time = millis();
  }

  void displayMap()
  {



    for (Block block : blocks) {

      block.display();
    }
  }




  //fill(255);

  //walls

  //toppart


  //maintowers

  void removeBlocks()
  {
    for (Block block : blocks) {  
      world.destroyBody(block.blockBody);
    }
  }


  void createMap(int mapSel)
  {
    //floor
    blocks.add(new Block(width/2, height, width, 20, 50, true));
    if (mapSel ==1)
    {
      blocks.add(new Block(width/2-150, 200, 150, 20, 150, true));
      blocks.add(new Block(width/2+150, 300, 150, 20, 150, true));    
      blocks.add(new Block(width/2, 400, 150, 20, 150, true));

      blocks.add(new Block(width/2-150, 500, 150, 20, 150, true));

      blocks.add(new Block(50, 100, 100, 10, 50, true));     
      blocks.add(new Block(width-50, 100, 100, 10, 50, true));
    } else  if (mapSel ==2)
    {

      for (int i = 0; i <=2; i++)
      {
        blocks.add(new Block(width/2-50, 100+(200*i), width-100, 10, 50, true));

        blocks.add(new Block(width/2+50, (200*i), width-100, 10, 50, true));
      }
    } else if (mapSel ==3)

    {

      for (int i = 1; i <4; i++)
      {
        for (int p = 1; p <5; p++)
        {
          blocks.add(new Block(150*i, 200*p, 75, 20, 90, true));
          if (i <3)
          {

            blocks.add(new Block(75+ 150*i, 200*p-100, 75, 20, 90, true));
          }
        }
      }
    }
  }


  void mapGeneral()
  {   
    blocks.add(new Block(width/2, height, width, 20, 30, true)); 
    //needed for every map
    blocks.add(new Block(width/2, 0, width, 20, 50, false));


    blocks.add(new Block(0, height/2, 20, height, 0, false));    
    blocks.add(new Block(width, height/2, 20, height, 0, false));
  }
}