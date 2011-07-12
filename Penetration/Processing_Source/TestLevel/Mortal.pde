/* Mortal
 *
 *  Scott Davis
 *  03/03/2011
 *
 *  This is the specification for a Mortal object.
 *Mortals extend Spacial objects and have the new
 *attribute of health.  Mortals also are able to 
 *move when given directions.
 *  Mortals also have an Inventory (not implemented)
 *
 *Things derived from Mortal:
 *Player; NPC -> Enemy & Friendly,
*/

//hang on to this for the invintory
  //justification: Enemys have to have a gun with ammo,
  //  so when you kill them, they can drop it.
  //  - Same for Friendlys, and special ones that give you
  //  Items
import java.util.LinkedList;

class Mortal extends Spacial
{
  //fields
  float DEFAULT_SPEED = 4.0;
  int health;
  int maxHealth = 100;
  
  LinkedList<WayPoint> directions = new LinkedList<WayPoint>();
  LinkedList inventory = new LinkedList();
  
  //TODO: put inventory here
  
  
  //Constructors
  public Mortal()
  {
    x = 0;
    y = 0;
    w = 10;
    h = 10;
    dir = 0.0;
    vX = DEFAULT_SPEED;
    vY = DEFAULT_SPEED;
  
    pic = null;
    
    health = 1;  //new field
  }
  
  public Mortal(int nx, int ny, int nw, int nh)
  {
    x = nx;
    y = ny;
    w = nw;
    h = nh;
    dir = 0.0;
    vX = DEFAULT_SPEED;
    vY = DEFAULT_SPEED;
  
    pic = null;
        
    health = 1;  //new field
  }

  public Mortal(int nx, int ny, int nw, int nh, PImage npic)
  {
    x = nx;
    y = ny;
    w = nw;
    h = nh;
    dir = 0.0;
    vX = DEFAULT_SPEED;
    vY = DEFAULT_SPEED;
  
    pic = npic;
    
    health = 1;  //new field
  }
  
 //getters and setters
  //getters
  int getHealth()
  {
    return health;
  }
  
  //setters
  //see above comments on health
  void setHealth(int newHealth)
  {
    health = newHealth;
    if(health > maxHealth)
    {
      health = maxHealth;
    }
  }

  //the return value here can be interpreted as
    // is Alive ?  
  boolean takeDamage(int damage)  
  {
    health -= damage;
    if( health <= 0)
    {
      return false;
    }
    else
    {
      return true;
    }
  }
  
  void heal(int cure)
  {
    setHealth( health + cure);
  }
  
  void extendHealth(int bonus)
  {
    maxHealth += bonus;
    health = maxHealth;
  }
  
  
  //list opperations
  int size()
  {
    return inventory.size();
  }
  void add(Item obj)
  {
    inventory.add(obj);
  }
  
  Item get(int i)
  {
    return (Item)inventory.get(i);
  }
  void remove(int i)
  {
    inventory.remove(i);
  }
  void remove(Object o)
  {
    inventory.remove(o);
  }
  void useItem(Item item)
  {
    if(inventory.contains(item))
    {
      int index = inventory.indexOf(item);
      Item useMe = (Item) inventory.get(index);
      useMe.use();
    }
  }
  void useItem(int index)
  {
    Item useMe = (Item)inventory.get(index);
    useMe.use();
  }

  void collide(int sideHit)// this is the overwritten verion
  {  //this isn't being fully used yet, so its just giving useless data
    super.collide(sideHit);  
    println("  Mortal: collide method.");
    
  }
  

  void addWayPoint(WayPoint wp)
  {
    directions.add(wp);
  }

  public void followPath()
  {
    //try to follow WayPoints in the directions Queue
    if(  directions.size() != 0 )
    {
      //select first WayPoint to follow
      if( directions.getFirst() != null )  //make sure there is one to follow
      {
        WayPoint temp = directions.getFirst();
        //See if you have already reached it
        if( x == temp.getX() && y == temp.getY() )
        {
            directions.removeFirst();          
        }
        track(temp.getX(), temp.getY() );
      }
    }//end if, there are no WayPoints to follow
    else
    {
//      println("The directions<WayPoint> queue is empty");
//      trackMouse();
    }  
  }//end followPath()
  
//This badly needs to be rewritten or replaced.  Component-wise tracking is
  //insufficent for my purposes.  Need to allow it to track in straight paths
  //instead of the diagonal and adjusting method i'm using.
  void track(int targetX, int targetY)
  {
    if (x > targetX) 
    {
      if( x - targetX < vX )
      {
        x -= x - targetX;
      }
      else
      {
        x = (int)(x - vX);
      }
    }
    
    if (x < targetX) 
    {
      if(x - targetX > vX )
      {
        x -= x - targetX;
      }
      else
      {
        x = (int)(x + vX);
      }
    }
    
    if (y > targetY)
    {
      if(y - targetY < vY )
      {
        y -= y - targetY;
      }
      else
      {
        y = (int)(y - vY);
      }
    }
      
    if (y < targetY) 
    {
      if(y - targetY > vY )
      {
        y -= y - targetY;
      }
      else
      {
        y = (int)(y + vY);
      }
    }
  } //end track() method 

  

  public void displayWayPoints()
  {
    if(directions.size() != 0)
    {
      //traverse the Queue and show each one
      for(int i = 0; i < directions.size(); i++)
      {
        WayPoint temp = directions.get(i);
        temp.display();
      }//end for loop, traverse directions<WayPoint> Queue
    }//end if, there are WayPoints to display
    else
    {
//      println("No WayPoints to display");
    }//end else
  }//end displayWayPoints()

    
  public boolean hasInventory()
  {
    return true;
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

