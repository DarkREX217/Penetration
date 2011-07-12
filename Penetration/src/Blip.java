/* Blip
 *
 *  Scott Davis
 *  07/09/2011
 *
 *  This is the specification for a Blip object.
 *Blips are used to display the x and y positions of their 
 *location as a reference point.  They can be created while
 *in Editor Mode and double clicking on their desired location. 
 *
*/

import java.util.LinkedList;

class Blip extends Spacial
{
  //fields
  private boolean immovable = true;
  PFont posText = loadFont("SansSerif.plain-12.vlw");

  public Blip(int nx, int ny)
  {
    this.x = nx;
    this.y = ny;
    this.w = 3;
    this.h = 3;
    this.dir = 0.0;
    this.vX = 0.0;
    this.vY = 0.0;
  
    this.pic = null;
    textFont(posText, 12);

  }

  
 //getters and setters
  //getters
  
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
      //draw with orange and clear border  
      stroke(0x00FFFFFF);
      fill(0xFFFF9900);
      rectMode(CENTER);
      pushMatrix();
        translate(offsetX + x, offsetY - y);
        rotate(dir);
        rect(0,0,w,h);
        //display the position to the lower left of the object
        fill(0xFFFFFF00);//yellow
        text("(" + x + "," + y + ")" , 10, 15 );
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

