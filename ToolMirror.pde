class ToolMirror extends Tool
{
  Mirror current;
  Slider sliderRotation;
  Slider sliderLength;
  Toggle toggleBlock;
  Textfield txtAddress;
  // ----------------------------------------------
  ToolMirror(PApplet p)
  {
    super(p);
  }
  // ----------------------------------------------
  public String getId()
  {
    return "__ToolMirror__";
  }

  // ----------------------------------------------
  void setCurrent(Mirror m)
  {
    this.current = m;
    updateControls();
  }

  // ----------------------------------------------
  void initControls()
  {
    initTab("mirror", "mirror");

    sliderRotation = cp5.addSlider("mirror_angle").setRange(0.0, 180.0)
      .setLabel("angle").moveTo("mirror")
      .setWidth(360).setHeight(15)
      .addListener(this)
      .linebreak();

    sliderLength = cp5.addSlider("mirror_length").setRange(10.0, 100.0)
      .setLabel("length").moveTo("mirror")
      .setWidth(360).setHeight(15)
      .addListener(this)
      .linebreak();

    toggleBlock = cp5.addToggle("mirror_block")
      .setLabel("block laser").moveTo("mirror")
      .setSize(15, 15)
      .addListener(this)
      .linebreak();

    txtAddress = cp5.addTextfield("mirror_address")
      .setLabel("arduino address").moveTo("mirror")
      .setAutoClear(false)
      .setPosition(toggleBlock.getPosition()[0]+2, toggleBlock.getPosition()[1]+30).setWidth(30)
      .addListener(this);
}

  // ----------------------------------------------
  void updateControls()
  {
    if (current != null)
    {
      sliderRotation.setValue( current.angle );
      sliderLength.setValue( current.length );
      toggleBlock.setValue( current.block );
      txtAddress.setValue( ""+current.address );
    }
  }

  // ----------------------------------------------
  void controlEvent(ControlEvent theEvent) 
  {
    String name = theEvent.getName();
    if (name.equals("mirror_angle"))
    {
      if (current != null) current.rotate( theEvent.getValue() );
    } 
    else if (name.equals("mirror_length"))
    {
      if (current != null) current.setLength( theEvent.getValue() );
    } 
    else if (name.equals("mirror_block"))
    {
      if (current != null) current.setBlock( theEvent.getValue() == 1.0f ? true : false );
    }
    else if (name.equals("mirror_address"))
    {
      if (current != null) current.setArduinoAdress( int(theEvent.getStringValue()) );
//      println( int(theEvent.getStringValue()) );
    }
  }
}