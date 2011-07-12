/* Medkit
 *
 *  Scott Davis
 *  07/09/2011
 *
 *  Medkit
 *  
 *  Restores health to user upon use
 */

class Medkit extends Item
{
  //fields
    //something that makes it pick-up-able 
  int restoreHealth = 20;
  
  //Constructors
  public Medkit()
  {
    pic = loadImage("img\\medkit.jpg");
    restoreHealth = 20;
  }
 //getters and setters
  //getters
  
  //setters
  
  
  void collide(int sideHit)
  {  //this needs to be overriden so the Item can be picked up
    println("Medkit collide.  Calling super.");
    super.collide(sideHit);
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

  
  void use()
  {
    println("Using Medkit, restoring " + restoreHealth + " to " + owner);
    owner.heal(restoreHealth);
    quantity--;
    if(quantity <= 0)
    {
      println("Removing medkit from " + owner + "'s inventory");
      owner.remove(this);
    }
  }
  
  //draw methods
  void drawObject(int offsetX, int offsetY)
  //this may need to be overriden
  {
    if (pic != null)
    {
      image(pic, offsetX + x,offsetY - y);
      return;
    }
    else
    {
      stroke(0);
      fill(255);
      rectMode(CENTER);
      rect(offsetX + x, offsetY - y,w,h);
      return;
    }    
  }//end drawObject()
  
  
/*
  additionional fields may be inserted here
  boolean isEqual(Spacial obj)
  {
    if( x == obj.getX() &&
        y == obj.getY() &&
        w == obj.getW() &&
        h == obj.getH() &&
        vX == obj.getVX() &&
        vY == obj.getVY() )
    {
      return true;
    }
    return false;
  }
*/
  
}//end class

