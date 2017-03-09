// ----------------------------------------------
// class Mirror
// ----------------------------------------------
class Mirror extends GraphicItem
{

  // Data
  Vec2D dir; // normalised
  Line2D  line;
  float length;
  float angle;
  float angleDragStart;
  int type; // blocking, non blocking
  boolean block=false;
  int address = -1;

  // Graphics
  color colorOut;
  color colorOver;
  color c;

  // ----------------------------------------------
  // Mirror
  // ----------------------------------------------
  Mirror()
  {
    super();
    this.pos = new Vec2D(width/2, height/2);
    this.line = new Line2D(new Vec2D(0, 0), new Vec2D(0, 0));
    this.length = 40;
    rotate(0);
    init();
  }

  // ----------------------------------------------
  // Mirror
  // ----------------------------------------------
  Mirror(MirrorInfo data)
  {
    super();
    this.id = data.id;
    this.pos = new Vec2D(data.x, data.y);
    this.line = new Line2D(new Vec2D(0, 0), new Vec2D(0, 0));
    this.length = data.l;
    this.address = data.address;
    rotate(data.angle);
    setBlock(data.block);

    init();
  }


  // ----------------------------------------------
  // Mirror
  // ----------------------------------------------
  Mirror(float x, float y, float l)
  {
    super();
    // Data
    this.id = "";
    this.pos = new Vec2D(x, y);
    this.line = new Line2D(new Vec2D(0, 0), new Vec2D(0, 0));
    this.length = l;
    rotate(20);

    init();
  }

  // ----------------------------------------------
  // init
  // ----------------------------------------------
  void init()
  {
    colorOut    = color(#FFFFFF);
    colorOver   = color(#BBBBBB);
  }

  // ----------------------------------------------
  // reflect
  // ----------------------------------------------
  ReflectResult reflect(Line2D otherLine)
  {
    ReflectResult result = null;
    Line2D.LineIntersection intersect = otherLine.intersectLine(line);
    if (intersect.getType() == Line2D.LineIntersection.Type.INTERSECTING)
    {
      result = new ReflectResult();
      result.pos = intersect.getPos();

      Vec2D n = line.getNormal().getNormalized();
      Vec2D u = otherLine.a.sub(result.pos);
      result.reflectDir = u.reflect(n).getNormalized();
      result.mirror = this;
    }
    return result;
  }

  // ----------------------------------------------
  // pos
  // ----------------------------------------------
  void pos(float x, float y)
  {
    pos.set(x, y);
    update();
  } 

  // ----------------------------------------------
  // update
  // ----------------------------------------------
  void update()
  {
    line.a.x = pos.x-0.5*length*dir.x;
    line.a.y = pos.y-0.5*length*dir.y;
    line.b.x = pos.x+0.5*length*dir.x;
    line.b.y = pos.y+0.5*length*dir.y;
  }

  // ----------------------------------------------
  // rotate
  // ----------------------------------------------
  void rotate(float angle)
  {
    this.angle = angle;
    this.dir = Vec2D.fromTheta(radians(angle));
    update();
    if (arduino != null && address>=0)
      arduino.servoWrite(address, (int)constrain(angle,0,180.0)); // to be sure

  }

  // ----------------------------------------------
  // setLength
  // ----------------------------------------------
  void setLength(float l)
  {
    this.length = l;
    update();
  }
  
  // ----------------------------------------------
  // setLength
  // ----------------------------------------------
  void setBlock(boolean ok)
  {
    block = ok;
    updateLasersCast();
  }

  // ----------------------------------------------
  void setArduinoAdress(int address_)
  {
    address = address_;
    if (arduino != null && address>=0)
      arduino.pinMode(address, Arduino.SERVO);
  }

  // ----------------------------------------------
  // draw
  // ----------------------------------------------
  void draw()
  {
    c = colorOut;
    if (isMouseOver())
      c = colorOver;

    if (isSelected)
    {
      //      fill(c);
      //      noStroke();
      noFill();
      stroke(c);
      ellipse(pos.x, pos.y, 10, 10);
    }

    stroke(c);
    line(line.a.x, line.a.y, line.b.x, line.b.y);
    noStroke();
    fill(0);
    ellipse(line.a.x, line.a.y, 4, 4);

    /*
    Vec2D n = line.getNormal().getNormalized();
     stroke(0, 200, 0);
     line(pos.x, pos.y, pos.x+n.x*10, pos.y+n.y*10);
     */


    fill(255);
    text(id, pos.x+2, pos.y-2);
  }

  // ----------------------------------------------
  // isMouseOver
  // ----------------------------------------------
  boolean isMouseOver()
  {
    if (dist(mouseX, mouseY, pos.x, pos.y)<=5) 
      return true;
    return false;
  }

  // ----------------------------------------------
  // handleMousePressed
  // ----------------------------------------------
  void handleMousePressed()
  {
    angleDragStart = angle;
    toolMirror.setCurrent(this);
    toolManager.select(toolMirror);
  }

  // ----------------------------------------------
  // handleMouseDragged
  // ----------------------------------------------
  void handleMouseDragged()
  {
    if (checkKey(SHIFT))
    {
      float dx = mouseX-posMouseDragStart.x;
      //rotate( angleDragStart + map(deltaMouseDrag.x,0,width,0,360) );
      rotate( angleDragStart + dx );
      toolMirror.updateControls();
      //mirrorDescription.updateControls();
    }
    else 
      super.handleMouseDragged();
  }

  // ----------------------------------------------
  // toXML
  // ----------------------------------------------
  String toXML()
  {
    return "<mirror id=\""+id+"\" address=\""+address+"\" l=\""+length+"\" x=\""+pos.x+"\" y=\""+pos.y+"\" angle=\""+angle+"\" block=\""+ (block ? "true" : "false") +"\" />\n";
  }
}