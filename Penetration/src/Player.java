/* Player
 *
 *  Scott Davis
 *  03/03/2011
 *
 *  This is the specification for the Player object.
 *Player extend Mortal objects.  Players are directly
 *affected by input. 
 *
*/

//hang on to this for the invintory
  //justification: Enemys have to have a gun with ammo,
  //  so when you kill them, they can drop it.
  //  - Same for Friendlys, and special ones that give you
  //  Items
import java.util.LinkedList;

class Player extends Mortal
{
  //fields
  String  name = "";
  
  float DEFAULT_SPEED_X = 10.0;
  float DEFAULT_SPEED_Y = 10.0;

  
  //Constructors
  public Player()
  {
    x = 0;
    y = 0;
    w = 16;
    h = 16;
  
    vX = DEFAULT_SPEED_X;
    vY = DEFAULT_SPEED_Y;
  
    pic = loadImage("img\\marker.png");
    
    health = 1;
  }
  
  public Player(int nx, int ny, int nw, int nh)
  {
    x = nx;
    y = ny;
    w = nw;
    h = nh;
  
    vX = 0.0;
    vY = 0.0;
  
    pic = loadImage("img\\marker.png");
        
    health = 1;
  }

  public Player(int nx, int ny, int nw, int nh, PImage npic)
  {
    x = nx;
    y = ny;
    w = nw;
    h = nh;
  
    vX = 0;
    vY = 0;
  
    pic = npic;
    
    health = 1;
  }
  
 //getters and setters
  //getters
  

  //setters
  

  
  void collide(int sideHit)
  {  

    println("    Player: collide method.");

  }
  
  
  
  //draw methods
  void drawObject(int offsetX, int offsetY)  //over-riding from Spacial
  {
    if (pic != null)
    {
      imageMode(CENTER);
      pushMatrix();
        translate(offsetX + x, offsetY - y);
        rotate(dir);
        image(pic, 0, 0);        
      popMatrix();

      drawHUD();
      return;
    }
    else
    {
      stroke(0);
      fill(0xFF0000FF);//blue
      rectMode(CENTER);
      rect(offsetX + x, offsetY - y, w,h);
      drawHUD();
      return;
    }    
  }//end drawObject()
  
  void drawHUD()
  {
    //draw health bar
    stroke(0xFF909090);//silver
    fill(0);
    rectMode(CORNER);
    rect(20,20, maxHealth + 3 , 17);
    
    stroke(0x00FFFFFF);//clear
    fill(0xFF00FF00);//green
    rect(22,22, health, 14 );
    rectMode(CENTER);
    
    //draw something for the inventory
    if( size() > 0 )
    {
      fill(0xFF0000FF); //blue
      for(int i = 0; i < size(); i++)
      {
        rect(20 + i * 40, 20, 20, 20);
      }
    }
    
  }
  
  // Player inherits having an inventory as true from Mortal
  
  boolean isEqual(Spacial obj)
  {
    if( x == obj.getX() &&
        y == obj.getY() &&
        w == obj.getW() &&
        h == obj.getH() &&
        vX == obj.getVX() &&
        vY == obj.getVY() &&
        dir == obj.getDir() )
    {
      return true;
    }
    return false;
  }

  boolean isEqual(Mortal obj)
  {
    if( x == obj.getX() &&
        y == obj.getY() &&
        w == obj.getW() &&
        h == obj.getH() &&
        vX == obj.getVX() &&
        vY == obj.getVY() && 
        dir == obj.getDir() &&
        health == obj.getHealth() )
    {
      return true;
    }
    return false;
  }

  
}//end class

