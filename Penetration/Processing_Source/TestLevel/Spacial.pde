/* Spacial
 *
 *  Scott Davis
 *  02/16/2011
 *
 *  This is the specification for a Spacial object.
 *Spacial objects are things that have a position in space
 *and can collide and interact with other objects
 *
 *Other kinds of Spacial objects include
 *Obstruction, Item, Character, Structure, Scenery and others.
*/

import java.util.LinkedList;

class Spacial
{
  //fields
  Level level;  
    
  int x;
  int y;
  int w;
  int h;
  float dir;
  float vX;
  float vY;
  
  private Spacial collidedWith = null;
  private boolean immovable = false;
  
  private boolean removeFromList = false;
  
  
  PImage pic;
  

  
  //Constructors
  public Spacial()
  {
    x =0;
    y =0;
    w = 10;
    h = 10;
    dir = 0;
    vX = 0.0;
    vY = 0.0;
  
    pic = null;
  }
  
  public Spacial(int nx, int ny, int nw, int nh)
  {
    x = nx;
    y = ny;
    w = nw;
    h = nh;
    dir = 0.0;
    vX = 0.0;
    vY = 0.0;
  
    pic = null;
  }

  public Spacial(int nx, int ny, int nw, int nh, PImage npic)
  {
    x = nx;
    y = ny;
    w = nw;
    h = nh;
    dir = 0.0;
    vX = 0.0;
    vY = 0.0;
  
    pic = npic;
  }
  
 //getters and setters
  //getters
  public Level getLevel() 
  {
    return level;
  }
  int getX()
  {
   return x;
  }

  int getY()
  {
    return y;
  }  

  int getW()
  {
   return w;
  }

  int getH()
  {
    return h;
  }  
  
  float getDir()
  {
    return dir;
  }
  
  float getVX()
  {
    return vX;
  }
  
  float getVY()
  {
    return vY;
  }
  
  public Spacial getCollidedWith() 
  {
    return collidedWith;
  }
    
  public boolean isImmovable() 
  {
    return immovable;
  }

  
  public boolean needsRemoving()
  {
    return removeFromList;
  }
  
  //setters
  public void setLevel(Level lvl) 
  {
    level = lvl;
  }
  void setX(int nx)
  {
    x = nx;
  }

  void setY(int ny)
  {
    y = ny;
  }
  
  void setW(int nw)
  {
    w = nw;
  }

  void setH(int nh)
  {
    h = nh;
  }
  
  void setDir(float nd)
  {
    dir = nd;
  }

  public void setCollidedWith(Spacial collidedWith) 
  {
    this.collidedWith = collidedWith;
  }

  public void setImmovable(boolean immovable) 
  {
    this.immovable = immovable;
  }
  
  void collide( int sideCollided )
  {    
    println("Spacial: collison method.");
     //who ever is causing the collision needs to stop where they are
     Spacial guy = (Spacial) collidedWith;
     println(" Instigator: " + this +  
            "\n Victim: " + this.getCollidedWith() );
     //back that object up so that it is not touching who it collided with
//     println(" Player's position: (" + guy.getX() + ", " + guy.getY() + ") and width: " + guy.getW() + ". dir: " + guy.getDir()  );
//     println(" Wall's position:   (" + this.getX() + ", " + this.getY() + ") and width: " + this.getW() );
   //this is biased to the right-ward direction
     if ( ! immovable  && sideCollided > 0)
     {
       handleCollisionDirection( guy, sideCollided );
     }
  }

  private void handleCollisionDirection(Spacial thingHit, int sideHit)
  {
  //DON'T USE the direction.  use a coded int that explains which edge the
      // object-being-hit is 
    
    // thingHit going UP
    if( sideHit == 2 )
    {
      int newPos =  this.getY() - this.getH()/2 - thingHit.getH()/2 ;
      println("New player position = " + newPos );
      thingHit.setY(newPos);
      Level levelInstance = thingHit.getLevel();
      if( levelInstance != null )
      {
        println("Level posY: " + levelInstance.getY() ); 
        levelInstance.setY( levelInstance.getY() + (int)thingHit.getVY() );
      }
    }
    
    // thingHit going DOWN
    if( sideHit == 4 )
    {
      int newPos =  this.getY() + this.getH()/2 + thingHit.getH()/2 ;
      println("New player position = " + newPos );
      thingHit.setY(newPos);
      Level levelInstance = thingHit.getLevel();
      if( levelInstance != null )
      {
        println("Level posY: " + levelInstance.getY() );
        levelInstance.setY( levelInstance.getY() - (int)thingHit.getVY() );
      }
    }
    
    // thingHit going RIGHT
    if( sideHit == 3 ) //EDIT: was 1
    {
      int newPos =  this.getX() - this.getW()/2 - thingHit.getW()/2 ;
      println("New player position = " + newPos );
      thingHit.setX(newPos);
      Level levelInstance = thingHit.getLevel();
      if( levelInstance != null )
      {
        println("Level posX: " + levelInstance.getX() );
        levelInstance.setX( levelInstance.getX() + (int)thingHit.getVX() );
      }
    }

    // thingHit going LEFT
    if( sideHit == 1 ) //EDIT: was 3
    {
      int newPos =  this.getX() + this.getW()/2 + thingHit.getW()/2 ;
      println("New player position = " + newPos );
      thingHit.setX(newPos);
      Level levelInstance = thingHit.getLevel();
      if( levelInstance != null )
      {
        println("Level posX: " + levelInstance.getX() );
        levelInstance.setX( levelInstance.getX() - (int)thingHit.getVX() );
      }
    }

  }

  
  void setSpeed(float nvX, float nvY)
  {
    vX = nvX;
    vY = nvY;
  }
  
  //move
  void move() //apply normal speed
  {
    x = (int)(x + vX);
    y = (int)(y + vY);
  }
  void moveX() //apply normal speed
  {
    x = (int)(x + vX);
  }
  void moveY() //apply normal speed
  {
    y = (int)(y + vY);
  }


  void move(float nx, float ny) //adjust by the amount specified instead of speed
  {
    x = (int)(x + nx);
    y = (int)(y + ny);
  }
  // VS
  void moveTo(int nx, int ny) // move the object to the specified cordinates
  {
    x = nx;
    y = ny;
  }
  
  //decided to keep this, helpful for mouse clicking
  boolean checkCollisionPoint(int checkX, int checkY) 
  {
    // check point against (this) in all 4 sections
    if( ( ( checkX  > (x - w /2)) && ( checkX < (x + w/2) ) ) &&
      ( ( checkY > (y - h/2)) && ( checkY < (y + h/2) ) ) )
    {
      return true;
    }
    return false;
  }

  public void markForRemoval()
  {
    removeFromList = true;
  }
  
  //draw methods
  void drawObject(int offsetX, int offsetY)
  {
    if (pic != null)
    {
      imageMode(CENTER);
      pushMatrix();
        translate(offsetX + x, offsetY - y);
        rotate(dir);
        image(pic, 0,0);
      popMatrix();
      return;
    }
    else
    {
      stroke(0);
      fill(255);
      rectMode(CENTER);
      pushMatrix();
        translate(offsetX + x, offsetY - y);
        rotate(dir);
        rect(0,0,w,h);
      popMatrix();
      return;
    }    
  }//end drawObject()
  
  
  public boolean hasInventory()
  {
    return false;
  }
  
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
  
}//end class

