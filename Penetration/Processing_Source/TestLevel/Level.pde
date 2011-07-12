/* Level
 *
 *  Scott Davis
 *  02/09/2011
 *
 *  This is the specification for a Level object
 *Levels handle the objects that are contained on them,
 *the movement and collisions of those objects, and calling
 *the draw or display method of those objects.
 *
 *  Levels normally hold Spacial objects.  Many other kinds
 *of objects are derived from the Spacial objects including
 *Obstruction, Item, Character, Structure, Scenery and others.
*/

import java.util.LinkedList;
import java.util.StringTokenizer;

class Level
{
  //fields
  String level_name = "";
  int level_width;
  int level_height;
  
  //Assumes that all positions are centered!
  int posX;
  int posY;
  
  PImage backgroundImage;
  String backgroundImagePath;
  int backgroundColor = 0;
  
  //need to implement the other lists for other objects
  LinkedList spacialObjectList = new LinkedList();
  
  int initialSpawnX;
  int initialSpawnY;
  
  Player player;
  
  //special field
  boolean editorMode = false;
  
  //Constructors
  public Level()
  {
    level_name = "Default_Level";
    level_width = 500;
    level_height = 500;
    posX = level_width / 2;    
    posY = level_height / 2;
    
    initialSpawnX = level_width / 2;
    initialSpawnY = level_height / 2;
    player = new Player(initialSpawnX, initialSpawnY, 16,16);
    
    backgroundImage = null;
  }
  
  public Level(int x, int y)
  {
    level_name = "Default_Level";
    level_width = x;
    level_height = y;
    posX = level_width / 2;    
    posY = level_height / 2;

    initialSpawnX = level_width / 2;
    initialSpawnY = level_height / 2;
    player = new Player(initialSpawnX, initialSpawnY, 16,16);

    backgroundImage = null;
  }
  
 //getters and setters
  //gets
  String getLevel_name()
  {
      return level_name;
  }
  int getW()
  {
    return level_width;
  }

  int getH()
  {
    return level_height;
  }

  int getX()
  {
   return posX;
  }

  int getY()
  {
    return posY;
  }  
  
  int getStartX()
  {
    return initialSpawnX;
  }

  int getStartY()
  {
    return initialSpawnY;
  }
  
  Player getPlayer()
  {
    return player;
  }
  
  //sets
  void setW(int w)
  {
    level_width = w;
  }

  void setH(int h)
  {
    level_height = h;
  }
  
  void setX(int nx)
  {
    posX = nx;
  }

  void setY(int ny)
  {
    posY = ny;
  }
  
  void setPlayer(Player targetPlayer)
  {
    player = targetPlayer;
    add(player);
  }

  
  //list opperations
  int size()
  {
    return spacialObjectList.size();
  }
  void add(Spacial obj)
  {
    spacialObjectList.add(obj);
  }
  
  Spacial get(int i)
  {
    return (Spacial)spacialObjectList.get(i);
  }
  void remove(int i)
  {
    spacialObjectList.remove(i);
  }
  
 

  //movement opperations
  void moveWithCollisions()
  { //traverse list to move objects
    for(int i = 0; i < spacialObjectList.size(); i++)
    {
      Spacial temp = (Spacial)spacialObjectList.get(i);
      temp.move(); //move each individual element
      int sideCollided = checkCollision(temp);
      if ( sideCollided > 0 )
      //it hit something
      {
        //re-adjust position
        fill(0xFF0000FF);
        rectMode(CORNER);
        rect(temp.getX(), temp.getY(), temp.getW(), temp.getY());
        //determine consequence: based on object type
        temp.collide(sideCollided);
      }//end if statement for collision checking
    }//end for loop that checks all objects
  }//end method moveWithCollisons()
  
  void moveWithTracking()
  { //traverse the list to move all objects
    for(int i=0; i < this.size(); i++ )
    {
      Mortal tempMortal = (Mortal)spacialObjectList.get(i);  //THIS NEEDS TO BE FIXED to the correct list
      tempMortal.followPath();
    }//end for loop that moves all objects
  }
  
  
//in the process of decomposing this method to return a representative int
  //very concerned that if i make a mistake, it will be a head ache to fix
  
  public int checkCollision(Spacial obj) //should be private
  {
    // meaning of sideCollided:
    //  0:  no collision
    //  1:  RIGHT - obj's right side collided with temp
    //  2:  TOP
    //  3:  LEFT
    //  4:  BOTTOM
    //  5:  General, there was a collsion detected.  Temp for testing
    int sideCollided = 0;
/*  This code is being removed until it works

    //check obj against level size in all 4 sections
    if(  (obj.getX() + obj.getW()/2) > level_width  ||  (obj.getX() - obj.getW()/2) < 0   ||
         (obj.getY() + obj.getH()/2) > level_height ||  (obj.getY() - obj.getH()/2) < 0   )
    {
      return true;
    }
*/  //check all objects against the object being checked
    for(int i = 0; i < spacialObjectList.size(); i++)
    {
      Spacial temp = (Spacial)spacialObjectList.get(i);
      //don't check against its self!
      if ( ! obj.isEqual(temp) )
      {
        // check obj against temp in all 4 sections
        if( ( ( (obj.getX() + obj.getW()/2) > (temp.getX() - temp.getW()/2)) && ( (obj.getX() - obj.getW()/2) < (temp.getX() + temp.getW()/2) ) ) &&
          ( ( (obj.getY() + obj.getH()/2) > (temp.getY() - temp.getH()/2)) && ( (obj.getY() - obj.getH()/2) < (temp.getY() + temp.getH()/2) ) ) )
        {    
            int rightEdge = Math.abs( obj.getX() - temp.getX() + temp.getW()/2 );
            int leftEdge = Math.abs( obj.getX() - temp.getX() - temp.getW()/2 );            
            int topEdge = Math.abs( obj.getY() - temp.getY() - temp.getH()/2 );            
            int bottomEdge = Math.abs( obj.getY() - temp.getY() + temp.getH()/2 );            
            
            int xMin = Math.min( rightEdge, leftEdge);
            int yMin = Math.min(topEdge, bottomEdge);
            
            println("Debugging info, constraints test: ");
            println("    X min: " + xMin );
            println("    Y min: " + yMin );
            
              //Check to see if temp hit the RIGHT side of obj
            if( rightEdge < leftEdge && rightEdge < yMin )
            {
              obj.setCollidedWith(temp);  
              println("checkCollision returned: 1, RIGHT");
              return sideCollided = 1;
            }
              //Check to see if temp hit the TOP side of obj
            if( topEdge < bottomEdge && topEdge < xMin ) 
            {
              obj.setCollidedWith(temp);  
              println("checkCollision returned: 2, TOP");
              return sideCollided = 2;
            }
              //Check to see if temp hit the LEFT side of obj
            if( leftEdge < rightEdge && leftEdge < yMin )
            {
              obj.setCollidedWith(temp);  
              println("checkCollision returned: 3, LEFT");
              return sideCollided = 3;
            }
              //Check to see if temp hit the BOTTOM side of obj
            if( bottomEdge < topEdge && bottomEdge < xMin )
            {
              obj.setCollidedWith(temp);  
              println("checkCollision returned: 4, BOTTOM");
              return sideCollided = 4;
            }
        }
      }//end if to check equivalencey for collisions
    }//end for loop that checks all objects
    obj.setCollidedWith(null);
    return sideCollided;
  }//end checkCollision()
  
  public void cleanUp()
  {
    for(int i = 0; i < size(); i++)
    {
      Spacial needsCleaning = (Spacial)get(i);
      if( needsCleaning.needsRemoving() )
      {
        remove(i);
      }
    }
  }
  
  /* Depreciated
   * 
   * void toggleEditMode()
  {
    editorMode = !editorMode;
    if(editorMode)
    {
      println("Select and option:\n  Click and drag any Spacial to move it.\n  Double-click to drop a Blip.");
    }
    else
    {
      println("Exiting editor mode. \n\n");
    }
  }*/

  /*
  *   File Input / Out put methods
  */
  void loadLevelData(ArrayList<ParsePair> theData)  
  {
    for(int i = 0; i < theData.size(); i++)
    {
      ParsePair thisPair = (ParsePair)theData.get(i);
      String currentData = thisPair.getVariable();
  //    println("Looking for " + currentData + " tag in the data.");
      if ( currentData != null )
      {
        if( currentData.equals("level_name") )
        {
          ParsePair aPair = (ParsePair)theData.get(i);
          level_name = aPair.getValue();      
        }
        if( currentData.equals("level_width"))
        {
            ParsePair aPair = (ParsePair)theData.get(i);
            level_width = Integer.parseInt( aPair.getValue().trim() ) ;
        }
        if( currentData.equals("level_height"))
        {
            ParsePair aPair = (ParsePair)theData.get(i);
            level_height = Integer.parseInt( aPair.getValue().trim() ) ;
        }
        if( currentData.equals("posX"))
        {
            ParsePair aPair = (ParsePair)theData.get(i);
            posX = Integer.parseInt( aPair.getValue().trim() ) ;
        }
        if( currentData.equals("posY"))
        {
            ParsePair aPair = (ParsePair)theData.get(i);
            posY = Integer.parseInt( aPair.getValue().trim() ) ;
        }
        if( currentData.equals("initialSpawnX"))
        {
            ParsePair aPair = (ParsePair)theData.get(i);
            initialSpawnX = Integer.parseInt( aPair.getValue().trim() ) ;
        }
        if( currentData.equals("initialSpawnY"))
        {
            ParsePair aPair = (ParsePair)theData.get(i);
            initialSpawnY = Integer.parseInt( aPair.getValue().trim() ) ;
        }
        if( currentData.equals("backgroundImagePath") )
        {
          ParsePair aPair = (ParsePair)theData.get(i);
          backgroundImagePath = aPair.getValue();      
        } 
        //I really don't like the way I'm doing this, but I can't think of an 
        //easier way that will work.  One advantage to doing it this way is that
        //any entry type can be placed anywhere in the file and it should be
        //read correctly.  the main disadvantage is that i don't feel like this
        //belongs in this file, maybe it should have it's own file?
        if( currentData.equals("Obstruction") )
        {
          ParsePair aPair = (ParsePair)theData.get(i);
          StringTokenizer stringToken = new StringTokenizer( aPair.getValue(), "," );
          int[] obstructionArgs = new int[4];
          for( int j = 0; stringToken.hasMoreElements(); j++ )
          {
            String newToken = stringToken.nextToken();
            //println("[" + j + "]: " + newToken);  
            obstructionArgs[j] = Integer.parseInt( newToken );
          }
          Obstruction newObstruction = new Obstruction(obstructionArgs[0],
                  obstructionArgs[1],obstructionArgs[2],obstructionArgs[3]);
          add(newObstruction);
        }
        
      }
      else
      {
        println("Error: [" + i + "] is null");
      }
    }//end for loop: filling data memebers
  }//end method loadLevelData
  
  
  /*
  *
  */

  
  

  //image related methods
  void setBackground(PImage anImage)
  {
    backgroundImage = anImage;
  }
  
  void setBackground(int aColor)
  {
    backgroundColor = aColor;
  }
  
  
  //draw methods
  void drawBackground()
  {
    rectMode(CORNER);
    imageMode(CORNER);
    //offest the y so that the origin is at the bottom, not the top
    int offsetY = height - posY;
    if (backgroundImage != null)
    { //center the image
      background(0);
      image(backgroundImage, posX, offsetY, backgroundImage.width, backgroundImage.height );
      return;
    }
    else
    {
      background(255);
      stroke(0xFF000000);//black
      fill(backgroundColor);//black by default
      rect(posX, offsetY, level_width, level_height);
      return;
    }
  } //end drawBackground()
  
  void drawAll()  //draw all the objects in the level
  {
    for(int i = 0; i < spacialObjectList.size(); i++)
    {
      Spacial temp = (Spacial)spacialObjectList.get(i);
      temp.drawObject(posX, height - posY + level_height);
    }//end for loop that draws all objects
    
  }//end drawAll() method
  
  
  
}//end class
