class Grid
{
  float size = 20;
  float opacity = 40.0f;
  
  

  
  // ----------------------------------------------
  void setSize(float size)
  {
    this.size = size;  
  }

  // ----------------------------------------------
  PVector getClosestPoint(float x, float y)
  {
    int xgrid = int(x/size);
    int ygrid = int(y/size);

    if ( x%size >= 0.5*size) xgrid+=1;
    if ( y%size >= 0.5*size) ygrid+=1;
    
    return new PVector(xgrid*size, ygrid*size);
  }
  
  // ----------------------------------------------
  void draw()
  {
    pushStyle();
    stroke(255,opacity);

    float x = 0;    
    while(x<=width)
    {
      line(x,0,x,height);
      x+=size;
    }

    float y = 0;    
    while(y<=height)
    {
      line(0,y,width,y);
      y+=size;
    }



    popStyle();
  }

}