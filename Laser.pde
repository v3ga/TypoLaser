// ----------------------------------------------
// class Laser
// ----------------------------------------------
class Laser extends GraphicItem
{
  float lengthMax = 1000;
  Ray2D ray, rayOut;
  Vec2D defaultDir = new Vec2D(0,-1);
  float angle = 0;
  float angleDragStart=0;
  int nbReflectsMax = 40;
  int nbReflect=0;

  ArrayList<Line2D> reflects;
  

  color colorOut;
  color colorOver;
  color c;


  // ----------------------------------------------
  // Laser
  // ----------------------------------------------
  Laser(LaserInfo data)
  {
    super();
    ray = new Ray2D(new Vec2D(data.x, data.y), defaultDir );
    pos(data.x, data.y);
    rotate(data.angle);

    init();
  }

  // ----------------------------------------------
  // Laser
  // ----------------------------------------------
  Laser(float ox, float oy)
  {
    super();
    ray = new Ray2D(new Vec2D(ox, oy), new Vec2D(0, -1) );
    pos(ox, oy);

    init();
  }

  // ----------------------------------------------
  // init
  // ----------------------------------------------
  void init()
  {
    colorOut = color(#FF0000);
    colorOver = color(#00FF00);
  }

  // ----------------------------------------------
  // getAngle
  // ----------------------------------------------
  float getAngle()
  {
    return angle;
  }

  // ----------------------------------------------
  // rotate
  // ----------------------------------------------
  void rotate(float angle)
  {
    this.angle = angle;
    Vec2D d = defaultDir.getRotated(radians(this.angle));
    ray.setDirection( d );
  }

  // ----------------------------------------------
  // cast
  // ----------------------------------------------
  void cast(ArrayList<Mirror> mirrors)
  {
    reflects = new ArrayList<Line2D>();
    ReflectResult r=null;
    nbReflect = 0;
    Mirror mirrorSrc=null;

    Ray2D castRay = ray;
    do
    {
      r = intersect(castRay, mirrors, mirrorSrc);
      if (r!=null)
      {
        // Create a line
        Line2D lineToMirror = new Line2D(castRay, r.pos);
        reflects.add(lineToMirror);

        // Emit a new ray (if non blocking)
        if (!r.mirror.block)
        {
          castRay = new Ray2D(r.pos, r.reflectDir);

          // Avoid test with "emitting mirror"
          mirrorSrc = r.mirror;

          // Increment number of reflections                
          nbReflect++;

          // Last will be rayout
          rayOut = castRay;
        }
        else{
          r = null;
          rayOut = null;
        }
    }
    }
    while (r!=null && nbReflect<=nbReflectsMax);

  }

  // ----------------------------------------------
  // intersect
  // ----------------------------------------------
  ReflectResult intersect(Ray2D ray, ArrayList<Mirror> mirrors, Mirror mirrorSrc)
  {
    if (mirrors==null) return null; 
    ReflectResult r = null;
    ReflectResult rclosest = null;
    float distanceMin = 999999;
    for (Mirror m : mirrors)
    {
      if (m != mirrorSrc) {
        r = m.reflect(ray.toLine2DWithPointAtDistance(lengthMax));
        if (r != null)
        {
          float distance = dist(ray.x, ray.y, r.pos.x, r.pos.y);  
          if (distance < distanceMin)
          {
            distanceMin = distance;
            rclosest = r;
          }
        }

        //        println(m.id+" / "+( r!=null ? "intersection "+r : "nada"));
      }
    }
    //        println("----");

    return rclosest;
  }

  // ----------------------------------------------
  // draw
  // ----------------------------------------------
  void draw()
  {
    c = colorOut;
    if (isMouseOver() || isSelected)
      c = colorOver;

    // Source
    pushStyle();
    noStroke();
    fill(c);
    ellipse(pos.x, pos.y, 5, 5);

    // Lines
    stroke(c);
    strokeWeight(3);
    if (reflects != null && reflects.size()>0)
    {
      for (Line2D l : reflects)
      {
        line(l.a.x, l.a.y, l.b.x, l.b.y);
      }

      if (rayOut != null){
        Vec2D b = rayOut.getPointAtDistance(lengthMax);
        line(rayOut.x, rayOut.y, b.x, b.y);
      }
    }
    else
    {
      Vec2D b = ray.getPointAtDistance(lengthMax);
      line(ray.x, ray.y, b.x, b.y);
    }
    popStyle();
  }

  // ----------------------------------------------
  // isMouseOver
  // ----------------------------------------------
  boolean isMouseOver()
  {
    return dist(mouseX, mouseY, pos.x, pos.y)<=10;
  }

  // ----------------------------------------------
  // handleMousePressed
  // ----------------------------------------------
  void handleMousePressed()
  {
    angleDragStart = angle;
    toolLaser.setCurrent(this);
    toolManager.select(toolLaser);
  }

  // ----------------------------------------------
  // handleMouseDragged
  // ----------------------------------------------
  void handleMouseDragged()
  {
    if (checkKey(SHIFT))
    {
      float dx = mouseX-posMouseDragStart.x;
      float newAngle = angleDragStart+dx;
// UGLY UGLY
      if (newAngle <= 0.0)
        newAngle = 360+newAngle;
      else
      if (newAngle >= 360.0)
        newAngle = newAngle-360;
// UGLY UGLY

      rotate( newAngle );
      //laserDescription.updateControls();    
      toolLaser.updateControls();
    }
    else
      super.handleMouseDragged();
    
    cast(mirrors);
  }

  // ----------------------------------------------
  // pos
  // ----------------------------------------------
  void pos(float x, float y) 
  {
    pos.set(x, y);
    ray.set(x, y);
  }

  // ----------------------------------------------
  // toXML
  // ----------------------------------------------
  String toXML()
  {
    return "<laser id=\""+id+"\" x=\""+pos.x+"\" y=\""+pos.y+"\" angle=\""+angle+"\" />\n";
  }

}