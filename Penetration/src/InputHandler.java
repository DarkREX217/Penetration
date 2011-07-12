/*InputHandler.pde
 *
 *created by: Scott Davis
 *created on: Sun, 07/10/2011
 *
 *     Takes input from the mouse and keyboard,
 *looks for the associated keybinding, and executes
 *the appropriate action.
 */

//imports

public class InputHandler
{
  //fields
  
  Level level;
  Player player;
  EditorMode editor;
  
  //Constructor
  public InputHandler()
  {
    level = null;
    player = null;
  }
  
  
  
  //setters
  public void setLevel(Level lvl)
  {
    level = lvl;
  }
  
  public void setPlayer(Player ply)
  {
    player = ply;
  }
  
  public void setEditor(EditorMode edit)
  {
    editor = edit;
  }
  
  public void handleKeys()
  {
      if (key == CODED)
      {

        if(keyCode == UP) 
        {
          player.move(0,player.getVY());
          player.setDir(-HALF_PI); 
          level.setY( level.getY() - (int)player.getVY() );
        }
        if(keyCode == DOWN) 
        {
          player.move(0,-player.getVY()); 
          player.setDir(HALF_PI);       
          level.setY( level.getY() + (int)player.getVY() );      
        }
        if(keyCode == RIGHT) 
        {
          player.move(player.getVX(),0); 
          player.setDir(0);       
          level.setX( level.getX() - (int)player.getVX() );
        }
        if(keyCode == LEFT) 
        {
          player.move(-player.getVX(),0 ); 
          player.setDir(PI);       
          level.setX( level.getX() + (int)player.getVX() );      
        }


      }

      if( key == '`')
      {
        editor.toggle();
      }
      if( key == 'e')
      {
        //use first item in players inventory
        if(player.size() > 0)
        {
          player.useItem(0);
        }
      }    
      if( key == ESC )
      {
        //intercept the closing function by setting key to 0
        key = 0;
        //display the pause menu
        println("ESC pressed, still need to implement the pause menu.");
      }
  }
  
  public void handleMousePresses()
  {
      if (mouseButton == LEFT && mouseEvent.getClickCount()== 2) 
      {
        if( editor.status() )
        {//double clicked while in editor mode
           //put a new Blip at the mouse's location relative to the Level 
           editor.dropBlip(mouseX, mouseY);
        }
      }
      else if (mouseButton == LEFT && mouseEvent.getClickCount()== 1) 
      {
        if( editor.status() )
        {
           //try to select an object at mouse location
           editor.selectAt(mouseX, mouseY);
        }
      }

      else if (mouseButton == RIGHT) 
      { 
      }
  }
  
  public void handleMouseDrag()
  {
      if( editor.status() ) 
      {
        editor.dragObject();
      }
  }
}