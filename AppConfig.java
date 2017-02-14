import java.util.*;
import javax.xml.bind.annotation.*;

// ----------------------------------------------
// AppConfig
// ----------------------------------------------
@XmlRootElement(name="config")
public class AppConfig {

  @XmlElement(name="mirror")
  ArrayList<MirrorInfo> mirrorInfos = new ArrayList<MirrorInfo>();

  @XmlElement(name="laser")
  ArrayList<LaserInfo> laserInfos = new ArrayList<LaserInfo>();
}