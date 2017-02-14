class ToolGlobals extends Tool
{

  Textfield tfSave;

  // ----------------------------------------------
  ToolGlobals(PApplet p)
  {
    super(p);
  }

  // ----------------------------------------------
  void initControls()
  {
    initTab("default", "Globals");

    // Globals
    int x = 2;
    int y = 20;
    int w = 140;
    int h = 18;
    tfSave = cp5.addTextfield("tfSave", x, y, w, h).setLabel("").moveTo("default");
    Button btnSave = cp5.addButton("save", 1, x+w+2, y, 30, h).setId(2).moveTo("default").addListener(this);
    y+=h+4;
    Button btnLoad = cp5.addButton("load", 2, x, y, 30, h).setId(3).moveTo("default").addListener(this);
  }

  // ----------------------------------------------
  /*  void activateTab(String which)
   {
   controls.getWindow(this).activateTab(which);
   }
   */

  // ----------------------------------------------
  void controlEvent(ControlEvent theEvent)
  {
    println( theEvent.getName() );

    switch(theEvent.controller().getId())
    {
    case 2:
      if (!tfSave.getText().equals(""))
      {
        saveAppConfig(tfSave.getText());
      }
      break;

    case 3:
      selectInput("Sélection .xml", "configSelected");  // Opens file chooser
      break;
    }
  }
}

// ----------------------------------------------
void configSelected(File fileSelected)
{
  if (fileSelected != null)
  {
    loadAppConfig(fileSelected.getAbsolutePath());
  }
}