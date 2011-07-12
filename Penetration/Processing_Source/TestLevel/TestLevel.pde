/* TestLevel
 *
 *  Scott Davis
 *  02/09/2011
 * 
 *  This program runs the setup that Level provides.
 *    Things to test:
 *      -  Level size and boundarys
 *      -  Object Placement and movement
 *      -   Collision detection
*/



//global variables
PrintWriter output;
BufferedReader reader;
InputHandler input;
EditorMode editor;

Level practiceWorld;
PImage levelBackground;
Player player;

int frame_width = 500;
int frame_height = 500;

Item testItem;
Mortal someDude;


void setup()
{
  frame.setResizable(true);
  size(frame_width, frame_height);
  imageMode(CENTER);
  rectMode(CENTER);
  input = new InputHandler();
  editor = new EditorMode();  
  input.setEditor(editor);
  
  
  //load a level from a file
  PenetrationFileIO pFile = new PenetrationFileIO();
  pFile.setFileName("level_1");
  pFile.setExt(".lvl");
  pFile.setPath("data\\levels\\level_1\\");
  pFile.loadFile();
    
  practiceWorld = new Level();
  practiceWorld.loadLevelData( pFile.getData() );
  
  frame.setTitle("Penetration - TestLevel: " + practiceWorld.getLevel_name() );
  practiceWorld.setX(width / 2 - practiceWorld.getStartX());
  practiceWorld.setY(height / 2 + practiceWorld.getH()- practiceWorld.getStartY());
  
  practiceWorld.setBackground(0xFF00FF00);
  levelBackground = loadImage(practiceWorld.backgroundImagePath);
  practiceWorld.setBackground(levelBackground);
  input.setLevel(practiceWorld);
  editor.setLevel(practiceWorld);
  
  player = new Player();
  player.setLevel(practiceWorld);
  player.setHealth(50);
  player.setX(practiceWorld.getStartX() );
  player.setY(practiceWorld.getStartY() );
  practiceWorld.setPlayer(player);
  input.setPlayer(player);
  
  testItem = new Medkit();
  testItem.setLevel(practiceWorld);
  testItem.setX(50);
  testItem.setY(100);
  practiceWorld.add(testItem);
  
  Item newItem = new Medkit();
  newItem.setLevel(practiceWorld);
  newItem.setX(100);
  newItem.setY(200);
  practiceWorld.add(newItem);
  
  someDude = new Mortal();
  someDude.setLevel(practiceWorld);
  someDude.setX(775);
  someDude.setY(825);
  someDude.setW(15);
  someDude.setH(15);
  practiceWorld.add(someDude);
  
//  someDude.addWayPoint( new WayPoint(-20, -20, true) );
  
} 


void mousePressed()
{
  input.handleMousePresses();
}

void mouseDragged()
{
  input.handleMouseDrag();
}

void keyPressed()
{
  input.handleKeys();
} 



void draw()
{
  someDude.followPath();

  practiceWorld.drawBackground();
  practiceWorld.drawAll();

  if( editor.status() ) { editor.display(); }
  
  //check for all collisions
  for(int i = 0; i < practiceWorld.size(); i++)
  {
    Spacial tempSpacial = practiceWorld.get(i);
    int sideCollided = practiceWorld.checkCollision(tempSpacial);
    if( sideCollided > 0 )
    {
      tempSpacial.collide(sideCollided);
    }
  }//end for loop to check all objects in level

  practiceWorld.cleanUp();
}







