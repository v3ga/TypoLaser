class ToolGlobals extends Tool
{

  Textfield tfSave;
  Toggle tgSnapToGrid;
  Slider sliderOpacityGrid;
  Slider sliderSizeGrid;
  boolean bSnapToGrid = false;

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
    int y = 30;
    int w = 140;
    int h = 18;
    tfSave = cp5.addTextfield("tfSave", x, y, w, h).setLabel("").moveTo("default");
    Button btnSave = cp5.addButton("save", 1, x+w+2, y, 30, h).setId(2).moveTo("default").addListener(this);
    y+=h+4;
    Button btnLoad = cp5.addButton("load", 2, x, y, 30, h).setId(3).moveTo("default").addListener(this);
    y+=h+4;
    tgSnapToGrid = cp5.addToggle("bSnapToGrid", bSnapToGrid, x, y, h, h).setLabel("snap to grid").addListener(this).setId(4);
    sliderOpacityGrid = cp5.addSlider("opacityGrid", 0, 1.0, grid.opacity/255.0f, x+h+4, y, w, h).setLabel("opacity grid").addListener(this).setId(5);
    y+=2*h+4;
    sliderSizeGrid = cp5.addSlider("sizeGrid", 10.0, 40.0, grid.size, x, y, w, h).setLabel("size grid").addListener(this).setId(6);
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

    case 4:
      bSnapToGrid = tgSnapToGrid.getValue() > 0.0 ? true : false;
      break;

    case 5:
      grid.opacity = map(sliderOpacityGrid.getValue(), 0, 1, 0, 255);
      break;

    case 6:
      grid.setSize( sliderSizeGrid.getValue() );
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