import javax.xml.bind.annotation.*;

// ----------------------------------------------
// class MirrorInfo
// ----------------------------------------------
public class MirrorInfo {

  @XmlAttribute
  String id;
  @XmlAttribute
  float x;
  @XmlAttribute
  float y;
  @XmlAttribute
  float angle;
  @XmlAttribute
  float l;
  @XmlAttribute
  boolean block;
  @XmlAttribute
  int address;
}