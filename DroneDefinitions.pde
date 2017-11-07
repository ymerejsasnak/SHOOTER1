enum DroneType {
 DRAIN, FREEZE, VAPORIZE 
}





enum DroneDefinition {
           //text,       attack type,       size,     rotation speed, radius to use as distance      
  DRAIN   ("DRAIN",    DroneType.DRAIN,       20,            .01,              200),
  FREEZE  ("FREEZE",   DroneType.FREEZE,      15,            .015,              300),
  VAPORIZE("VAPORIZE", DroneType.VAPORIZE,     5,            .016,             400 )
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