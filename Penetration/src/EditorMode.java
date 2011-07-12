/*EditorMode
 *
 *created on: Sun, 07/10/2011
 *created by: Scott Davis
 *
 *     This allows you to use extra features while playing
 * Pentetration.
 */
 
//imports

public class EditorMode
{
  //fields
  PFont myFont;
  
  boolean enabled;
  
  Level level;  
  Spacial selectedObject;
  
  
  //Constructor
  public EditorMode()
  {
    myFont = loadFont("SansSerif.plain-12.vlw");
    textFont(myFont, 12);
    
    enabled = false;
    
    level = null;
    selectedObject = null;
  }
  
  //getters
  public boolean status()
  {
    return enabled;
  }
  
  
  //setters
  public void toggle()
  {
    enabled = !enabled;
    if(enabled)
    {
      frame.resize(500 + 300, 500);
    }
    else
    {
      frame.resize(500, 500);
    }
  }
  
  public void enable()
  {
    enabled = true;
  }
  
  public void disable()
  {
    enabled = false;
  }
  
  public void setLevel(Level lvl)
  {
    level = lvl;
  }
  
  public void selectAt(int x, int y)
  {
    x = x - level.getX();
    y = height - y  - level.getY() + level.getH() ;
  
    //traverse the spacialObjectList to see if the mouse clicked an obj
    for(int i = 0; i < level.size(); i++ )
    {
      Spacial temp = (Spacial)level.get(i);
      if( temp.checkCollisionPoint(x, y) )
      {
        select(temp);
        return;
      }
    }
    select(null);
  }
  
  public void select(Spacial obj)
  {
    selectedObject = obj;
  }
  
  
  public void dragObject()
  {
    if(selectedObject != null) { selectedObject.moveTo(mouseX - practiceWorld.getX(), height - mouseY  - practiceWorld.getY() + practiceWorld.getH() );}
  }
  
  public void dropBlip(int x, int y)
  {
    practiceWorld.add( new Blip(x - level.getX(), height - y  - level.getY() + level.getH() ) );
  }
  
  
  
  
  public void display()
  {
    //clear the background of the info panel
    fill(100);  
    rect(500 + 150, 250, 300, 500 );  
      
    fill(0xFFFFFF00); //yellow text
    
    //show the selected object
    text("Level: " + level, 505, 15);
    text("Selected: " + selectedObject, 505, 30);
    if( selectedObject != null)
    {  displayProperties(); } 
    infoPanel();
  }
  
  private void displayProperties() 
  {
    //based on what type of object it is, display different information
    
  }
  
  private void infoPanel()
  {
    
    //construct the sting that will hold the spacialObjectList
    String objList = "";
    for(int i = 0; i < level.size(); i++ )
    {
      objList += "[" + i + "]: " + level.get(i) + "\n";
      if( level.get(i).equals(selectedObject) )
      {
        fill(0xFFAA0000); //darker red
        rect(512, 57 + i * 20, 20, 17);
        fill(0xFFFFFF00);//back to yellow
      }
    }
    text(objList, 505, 60);
    
  }
    
}