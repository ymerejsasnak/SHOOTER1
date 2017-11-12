/*
  CLASS FOR INDIVIDUAL DRONES
*/

class Drone {
  
  float x, y;
  float angle;
  int distance;
  int size;
  float rotSpeed;
  DroneType type;
  color fill;
    
  Drone(float angle, DroneDefinition droneDefinition) {
    
    this.angle = angle;
    distance = droneDefinition.distance;
    size = int(droneDefinition.size * player.droneSizeMultiplier);
    rotSpeed = droneDefinition.rotSpeed;
    type = droneDefinition.type;
    
    switch(type){
      case DAMAGE:
        fill = DAMAGE_FILL;
        break;      
      case FREEZE:
        fill = FREEZE_FILL;
        break;
      case VAPORIZE:
        fill = VAPORIZE_FILL;
        break;      
    }
  }
  
  
  void update() {
    angle += rotSpeed;
    x = player.x + cos(angle) * distance;
    y = player.y + sin(angle) * distance;
  } 
  
 
  void display() {
    stroke(DRONE_STROKE);
    strokeWeight(DRONE_STROKE_WEIGHT);
    fill(fill);
    ellipse(x, y, size, size);
    fill(BLACK);
    ellipse(x, y, size / 2, size / 2);  // half size black circle in center
  }
  
}