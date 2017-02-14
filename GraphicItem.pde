// ----------------------------------------------
// class GraphicItem
// ----------------------------------------------
class GraphicItem
{
  String id;
  Vec2D pos;
  Vec2D posMouseDragStart;
  Vec2D deltaMouseDrag;
  boolean isSelected=false;

  // ----------------------------------------------
  // GraphicItem
  // ----------------------------------------------
  GraphicItem()
  {
    pos = new Vec2D();
    // Drag
    posMouseDragStart = new Vec2D();
    deltaMouseDrag = new Vec2D();
  }

  // ----------------------------------------------
  // draw
  // ----------------------------------------------
  void draw() {
  }

  // ----------------------------------------------
  // isMouseOver
  // ----------------------------------------------
  boolean isMouseOver() {
    return false;
  }

  // ----------------------------------------------
  // pos
  // ----------------------------------------------
  void pos(float x, float y) {
  }

  // ----------------------------------------------
  // mousePressed
  // ----------------------------------------------
  void mousePressed()
  {
    posMouseDragStart.set(mouseX, mouseY);
    deltaMouseDrag.set(mouseX-pos.x, mouseY-pos.y);
    handleMousePressed();
  }

  // ----------------------------------------------
  // mouseDragged
  // ----------------------------------------------
  void mouseDragged()
  {
    handleMouseDragged();
  }

  // ----------------------------------------------
  // handleMousePressed
  // ----------------------------------------------
  void handleMousePressed() {
  }

  // ----------------------------------------------
  // handleMouseDragged
  // ----------------------------------------------
  void handleMouseDragged()
  {
    pos(mouseX-deltaMouseDrag.x, mouseY-deltaMouseDrag.y);
  }

  // ----------------------------------------------
  // toXML
  // ----------------------------------------------
  String toXML()
  {
    return "";
  }
}

// ----------------------------------------------
// class GraphicItemManager
// ----------------------------------------------
class GraphicItemManager extends ArrayList<GraphicItem> 
{
  GraphicItem itemOver;
  GraphicItem itemSelected;

  // ----------------------------------------------
  // GraphicItemManager
  // ----------------------------------------------
  GraphicItemManager()
  {
  }

  // ----------------------------------------------
  // update
  // ----------------------------------------------
  void update()
  {
  }

  // ----------------------------------------------
  // draw
  // ----------------------------------------------
  void draw()
  {
    for (GraphicItem item : this)
    {
      pushMatrix();
      item.draw();
      popMatrix();
    }
  }

  // ----------------------------------------------
  // hasItemMouseOver
  // ----------------------------------------------
  boolean hasItemMouseOver()
  {
    return itemOver !=null;
  }

  // ----------------------------------------------
  // mouseMoved
  // ----------------------------------------------
  void mouseMoved()
  {
    itemOver = null;
    for (GraphicItem item : this)
    {
      if (item.isMouseOver()) {
        itemOver = item;
        break;
      }
    }
  }

  // ----------------------------------------------
  // mousePressed
  // ----------------------------------------------
  void mousePressed()
  {
    for (GraphicItem item : this)
      item.isSelected = false;

    itemSelected = null;
    if (itemOver!=null)
    {
      itemOver.isSelected = true;
      itemOver.mousePressed();
      itemSelected = itemOver;
    }
  }

  // ----------------------------------------------
  // mouseDragged
  // ----------------------------------------------
  void mouseDragged()
  {
    if (itemOver!=null) {
      itemOver.mouseDragged();
    }
  }
}