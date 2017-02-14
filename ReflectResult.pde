// ----------------------------------------------
// class ReflectResult
// ----------------------------------------------
class ReflectResult
{
  Vec2D   pos;
  Vec2D   reflectDir;
  Mirror  mirror;
  ReflectResult() {
  }

  // ----------------------------------------------
  // class toString
  // ----------------------------------------------
  String toString()
  {
    return "pos:"+pos.toString() +" / reflection dir:" + reflectDir.toString();
  }
}