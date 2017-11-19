enum DroneType {
 DAMAGE, FREEZE, VAPORIZE 
}

enum DroneDefinition {
  //note: speed here is in radians per second since it's rotational speed
  //            text          attack type      size  speed  distance (from player)      
  ATTACKER  ( "ATTACKER",    DroneType.DAMAGE,  40,   .02,    300),
  DEFENDER  ( "DEFENDER",    DroneType.DAMAGE,  50,   .01,     90),
  FREEZER   (  "FREEZER",    DroneType.FREEZE,  25,   .04,    300),
  MOON      ("COLD MOON",    DroneType.FREEZE,  75,  .005,    525),
  VAPORIZER ("VAPORIZER",  DroneType.VAPORIZE,  15,  .016,    550),
  
  ;
  
  String text;
  DroneType type;
  int size;
  float rotSpeed;
  int distance;
  
  private DroneDefinition(String text, DroneType type, int size, float rotSpeed, int distance) {
    this.text = text;
    this.type = type;
    this.size = size;
    this.rotSpeed = rotSpeed;
    this.distance = distance;
  }
}