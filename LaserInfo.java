import javax.xml.bind.annotation.*;

// ----------------------------------------------
// class LaserInfo
// ----------------------------------------------
public class LaserInfo {

  @XmlAttribute
  float x;
  @XmlAttribute
  float y;
  @XmlAttribute
  float angle;
}