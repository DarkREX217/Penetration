/* Item
 *
 *  Scott Davis
 *  03/11/2011
 *
 *  Item
 *  
 *  This class is still under construction
 */

class Item extends Spacial
{
  //fields

    //something that makes it pick-up-able
  int quantity;
  Mortal owner = null;
  
  //Constructors
  public Item()
  {
    x =0;
    y =0;
    w = 10;
    h = 10;
  
    vX = 0.0;
    vY = 0.0;
  
    quantity = 1;
    
    pic = null;
  }
  
  public Item(int nx, int ny, int nw, int nh)
  {
    x = nx;
    y = ny;
    w = nw;
    h = nh;
  
    vX = 0.0;
    vY = 0.0;
  
    quantity = 1; 
    pic = null;
  }

  public Item(int nx, int ny, int nw, int nh, PImage npic)
  {
    x = nx;
    y = ny;
    w = nw;
    h = nh;
  
    vX = 0.0;
    vY = 0.0;
    
    quantity = 1;
    pic = npic;
  }
  
 //getters and setters
  //getters
  int getQuantity()
  {
      return quantity;
  }
  //setters
  void setQuantity(int q)
  {
      quantity = q;
  }
  
  void collide(int sideHit)
  {  //this needs to be overriden so the Item can be picked up
    println("Item collide method is overriding Spacial;" + 
            "\n  This item: " + this +
            "\n    has collided with: " + getCollidedWith() );
    //does the thing that i have collided with have an inventory?
    if(getCollidedWith().hasInventory() )
    {
      println( getCollidedWith() + " does have an inventory.");
      //TODO: write code that makes sure that there is room in the inventory
      // to accept the Item, otherwise it does not pick it up
      Player pickerUpper = (Player)getCollidedWith();
      //add the item to the inventory
      pickerUpper.add(this);
      owner = pickerUpper;
      markForRemoval();
    }
    
    
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
    println("Using item: " + this + ".  Decreasing quantity: " + --quantity );
    if( quantity <= 0)
    {
      println("Item: " + this + " needs to be removed from where it is.");
      //markForRemoval();  do this but for the inventory
    }
  
  }
  
  void drop()
  {
    println("Dropping item: " + this + ". Returning to level");
    getLevel().add(this);
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

