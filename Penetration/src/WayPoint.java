/*WayPoint.java
  Scott Davis
  CAP3032
  Home Work 3
  Due Mon 02/08/11
  
  This is a helper class that tells the enemy where to go. It was 
used much more in the other assignment, HW2.
*/

class WayPoint
{
  int x,y;
  boolean drawMarker;

  public WayPoint()
  {
    x = 0;
    y = 0;
    drawMarker = true;    
  }
    
  public WayPoint(int newX, int newY)
  {
    x = newX;
    y = newY;
    drawMarker = true;
  }
  
  public WayPoint(int newX, int newY, boolean shouldDraw)
  {
    x = newX;
    y = newY;
    drawMarker = shouldDraw;
  }

  public int getX()
  {
    return x;
  }

  public int getY()
  {
    return y;
  }

  void show()
  {
    drawMarker = true;
  }

  void hide()
  {
    drawMarker = false;
  }  

  public void display()
  {
    //check to see if it should be drawn or not
    if(drawMarker)
    {
	  //draw the point
         stroke(0x80000000); //draw black
         strokeWeight(1);
         fill(0x800000FF);  //blue
         rectMode(CENTER);
         rect(x,y,5,5);
	}
  }//end display


}//end class
