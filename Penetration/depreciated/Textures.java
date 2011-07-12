/*Textures.pde
*/

import java.util.HashMap;

public class Textures
{
  private HashMap textures = new HashMap();
  
  public PImage getImage(String fileName)
  {
    if( textures.containsKey(fileName) )
    {
      return (PImage)textures.get(fileName);
    }
    PImage returnImage = loadImage(fileName);
    if( returnImage != null )
    {
//      println("Adding " + fileName + " to the HashMap");
        textures.put(fileName, returnImage);
    }
    else
    {
      println("Image " + fileName + " failed to load : " + returnImage);
    }
    return returnImage;
  }
}
