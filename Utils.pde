// ----------------------------------------------
// loadAppConfig
// ----------------------------------------------
AppConfig loadAppConfig(String filename)
{
  AppConfig config = null;
  try {
    // setup object mapper using the AppConfig class
    JAXBContext context = JAXBContext.newInstance(AppConfig.class);
    // parse the XML and return an instance of the AppConfig class
    config = (AppConfig) context.createUnmarshaller().unmarshal(createInput(filename));

    // Clear all
    graphicItems = new GraphicItemManager();
    mirrors = null;
    lasers = null;
  
    lasers = createLasers(config.laserInfos);
    mirrors = createMirrors(config.mirrorInfos);
    
    String[] filenameParts = split(filename, "/");
    
    toolGlobals.tfSave.setValue(filenameParts[filenameParts.length-1]);
    updateLasersCast();
  } 
  catch(JAXBException e) {
    // if things went wrong...
    println("error parsing xml: ");
    e.printStackTrace();
  }

  return config;
}

// ----------------------------------------------
// saveAppConfig
// ----------------------------------------------
void saveAppConfig(String filename)
{
  String s="<config>\n";

  s += "\t<!-- mirrors -->\n";
  for (Mirror m : mirrors){
    s += "\t"+m.toXML();
  }

  s += "\t<!-- lasers -->\n";
  for (Laser l : lasers){
    s += "\t"+l.toXML();
  }

  s+="</config>\n";
  saveBytes("data/"+filename, s.getBytes());
}


// ----------------------------------------------
// createMirrors
// ----------------------------------------------
ArrayList<Mirror> createMirrors(ArrayList<MirrorInfo> mirrorInfos)
{
  ArrayList<Mirror> mirrors = new ArrayList<Mirror>();
  for (MirrorInfo mirrorInfo : mirrorInfos)
  {
    Mirror newMirror = new Mirror(mirrorInfo);
    mirrors.add(newMirror);
    graphicItems.add(newMirror);
  }

  return mirrors;
}

// ----------------------------------------------
// newMirror
// ----------------------------------------------
void newMirror()
{
  Mirror newMirror = new Mirror(mouseX, mouseY, 40);
  mirrors.add(newMirror);
  graphicItems.add(newMirror);
}


// ----------------------------------------------
// createLasers
// ----------------------------------------------
ArrayList<Laser> createLasers(ArrayList<LaserInfo> laserInfos)
{
  ArrayList<Laser> lasers = new ArrayList<Laser>();
  for (LaserInfo laserInfo : laserInfos)
  {
    Laser newLaser = new Laser(laserInfo);
    lasers.add(newLaser);
    graphicItems.add(newLaser);
  }

  return lasers;
}

// ----------------------------------------------
// newLaser
// ----------------------------------------------
void newLaser()
{
  Laser newLaser = new Laser(mouseX, mouseY);
  lasers.add(newLaser);
  graphicItems.add(newLaser);
}