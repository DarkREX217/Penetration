/* Obstruction
 *
 *  Scott Davis
 *  06/29/2011
 *
 *    This is the specification for a Obstruction object.
 * Obstruction objects do not allow other objects to pass
 * through them if there is a collision.
 *
 * Other kinds of Obstruction objects include:
 *   Structure, Scenery and others.
*/

import java.util.LinkedList;

public class Obstruction extends Spacial
{
  //fields
  private boolean immovable = true;

  
  //Constructors
  public Obstruction()
  {
    x = 0;
    y = 0;
    w = 50;
    h = 70;
    dir = 0;
    vX = 0.0;
    vY = 0.0;
  
    
    pic = null;
  }
  
  public Obstruction(int nx, int ny, int nw, int nh)
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

  public Obstruction(int nx, int ny, int nw, int nh, PImage npic)
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
  
  //setters
  
  public void collide(int sideHit)
  {  
     super.collide(sideHit);
     println("Obstruction: Additional collsion options go here.");
    
  }
  
  
  
  //draw methods
  public void drawObject(int offsetX, int offsetY)
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
      fill(0xFF683F04);  //default Obstructions will be brownish
      rectMode(CENTER);
      pushMatrix();
        translate(offsetX + x, offsetY - y);
        rotate(dir);  
        rect(0,0,w,h);
      popMatrix();
      return;
    }    
  }//end drawObject()

  
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

