/*
  CLASS FOR DRONE
*/

class Drone {
  
  float x, y;
  float angle;
  int distance;
  int size;
  float rotSpeed;
  int rotDirection;
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
  
  void resetAngles() {
    if (drone != null) {
      angle = 0;
    }
  }

  
  void update() {
    if (y > height - size/2 && x > player.x) {
      rotDirection = -1;
    } else if (y > height - size/2 && x < player.x) {
      rotDirection = 1; 
    }
    angle += rotSpeed * rotDirection;
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