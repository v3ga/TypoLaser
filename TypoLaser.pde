// ----------------------------------------------
// imports
// ----------------------------------------------
import controlP5.*;
import toxi.geom.*;
import javax.xml.bind.*;
import java.awt.event.KeyEvent;
import processing.serial.*;
import cc.arduino.*;



// ----------------------------------------------
PImage imgBackground;

// ----------------------------------------------
// Arduino
Arduino arduino;


// ----------------------------------------------
// UI
ControlP5 cp5;
ToolManager toolManager;
ToolGlobals toolGlobals;
ToolLaser toolLaser;
ToolMirror toolMirror;

// ----------------------------------------------
GraphicItemManager graphicItems = new GraphicItemManager();
ArrayList<Mirror> mirrors = new ArrayList<Mirror>();
ArrayList<Laser> lasers = new ArrayList<Laser>();

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
  
  initArduino(9); // change this
  initControls(true);
  loadAppConfig("simple.xml");
}


// ----------------------------------------------
// initArduino
// ----------------------------------------------
void initArduino(int port)
{
  // Prints out the available serial ports.
  println(Arduino.list());
  for (int i=0;i<Arduino.list().length;i++){
    println(i+" - "+Arduino.list()[i]);
  }
  
  if (port < Arduino.list().length)
    arduino = new Arduino(this, Arduino.list()[port], 57600);
  else
    exit();
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

  drawBackground();
  graphicItems.draw();
  cp5.draw();
}

// ----------------------------------------------
void drawBackground()
{
  if (imgBackground != null)
    image(imgBackground, 0, 0); 
  else
    background(0);
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
    saveAppConfig("simple.xml"); 

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