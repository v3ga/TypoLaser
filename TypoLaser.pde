// ----------------------------------------------
// imports
// ----------------------------------------------
import controlP5.*;
import toxi.geom.*;
import javax.xml.bind.*;
import java.awt.event.KeyEvent;


// ----------------------------------------------
PImage imgBackground;

// ----------------------------------------------
// UI
ControlP5 cp5;
ToolManager toolManager;
ToolGlobals toolGlobals;
ToolLaser toolLaser;
ToolMirror toolMirror;

// ----------------------------------------------
GraphicItemManager graphicItems;
ArrayList<Mirror> mirrors;
ArrayList<Laser> lasers;

// ----------------------------------------------
AppConfig appConfig;
boolean[] keys = new boolean[526];

// ----------------------------------------------
// setup
// ----------------------------------------------
void setup()
{
  size(1600, 600);
  smooth();
  frameRate(60);

  graphicItems = new GraphicItemManager();

  mirrors = new ArrayList<Mirror>();
  lasers = new ArrayList<Laser>();

  initControls(true);
  loadAppConfig("GRL.xml");

  // Rays
  updateLasersCast();
}

// ----------------------------------------------
// initControls
// ----------------------------------------------
void initControls(boolean autoDraw)
{
  cp5 = new ControlP5(this);

  toolManager = new ToolManager(this);

  toolGlobals = new ToolGlobals(this);
  toolLaser = new ToolLaser(this);
  toolMirror = new ToolMirror(this);

  toolManager.addTool( toolGlobals  );
  toolManager.addTool( toolLaser );
  toolManager.addTool( toolMirror );

  toolManager.initControls(0, 0, autoDraw);
  toolManager.setup();
}

// ----------------------------------------------
// draw
// ----------------------------------------------
void draw()
{
  toolManager.update();
  graphicItems.update();

  if (imgBackground != null)
    image(imgBackground, 0, 0); 
  else
    background(0);
  graphicItems.draw();
  cp5.draw();
}

// ----------------------------------------------
// mouseMoved
// ----------------------------------------------
void mouseMoved()
{
  graphicItems.mouseMoved();
}

// ----------------------------------------------
// mousePressed
// ----------------------------------------------
void mousePressed()
{
  //  if (!controls.window(this).isMouseOver())
  graphicItems.mousePressed();
}

// ----------------------------------------------
// mouseDragged
// ----------------------------------------------
void mouseDragged()
{
  graphicItems.mouseDragged();
  updateLasersCast();
}

// ----------------------------------------------
// updateLasersCast
// ----------------------------------------------
void updateLasersCast()
{
  if (lasers==null) return;

  for (Laser laser : lasers)
  {
    laser.cast(mirrors);
  }
}


// ----------------------------------------------
// keyPressed
// ----------------------------------------------
void keyPressed()
{
  if (key == ' ')
    saveAppConfig("test.xml"); 

  keys[keyCode] = true;
  if ( (checkKey(157) || checkKey(CONTROL) )  && checkKey(KeyEvent.VK_M))
  {
    newMirror();
    updateLasersCast();
  } 
  else if ( (checkKey(157) || checkKey(CONTROL))  && checkKey(KeyEvent.VK_L))
  {
    newLaser();
    updateLasersCast();
  }
}

// ----------------------------------------------
// keyReleased
// ----------------------------------------------
void keyReleased()
{ 
  keys[keyCode] = false;
}


// ----------------------------------------------
// checkKey
// ----------------------------------------------
boolean checkKey(int k)
{
  if (keys.length >= k) {
    return keys[k];
  }
  return false;
}