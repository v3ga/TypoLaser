class ToolLaser extends Tool
{
  Laser current;
  Slider sliderRotation;

  // ----------------------------------------------
  ToolLaser(PApplet p)
  {
    super(p);
  }

  // ----------------------------------------------
  public String getId()
  {
    return "__ToolLaser__";
  }
  
  // ----------------------------------------------
  void setCurrent(Laser l)
  {
    this.current = l;
    updateControls();
  }

  // ----------------------------------------------
  void initControls()
  {
    initTab("laser", "laser");
    
    sliderRotation = cp5.addSlider("laser_angle").setRange(0.0, 360.0)
      .setLabel("angle").moveTo("laser")
      .setWidth(360).setHeight(15)
      .addListener(this)
      .linebreak();
  }

  // ----------------------------------------------
  void updateControls()
  {
    if (this.current !=null)
    {
      sliderRotation.setValue( current.angle );
    }
  }
  
  // --------------------------------------------------------------------
  void controlEvent(ControlEvent theEvent) 
  {
    String name = theEvent.getName();
    if (name.equals("laser_angle"))
    {
      if (current != null) current.rotate( theEvent.getValue() );
    }
  }
}