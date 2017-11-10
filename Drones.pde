final int LEFT_DRONE = 0;
final int RIGHT_DRONE = 1;

class Drones {
  
  Drone[] drones; 
   
  Drones() {
    drones = new Drone[2];
        
  }
  
  //first argument makes both start opposite each other
  void setDroneOne(DroneDefinition droneDefinition) {
    drones[LEFT_DRONE] = new Drone(0, droneDefinition);
  }
  void setDroneTwo(DroneDefinition droneDefinition) {
    drones[RIGHT_DRONE] = new Drone(PI, droneDefinition);
  }
  
  void resetAngles() {
    drones[LEFT_DRONE].angle = 0;
    drones[RIGHT_DRONE].angle = PI;
  }
  
  void run() {
     drones[LEFT_DRONE].update();
     drones[LEFT_DRONE].display();
     drones[RIGHT_DRONE].update();
     drones[RIGHT_DRONE].display();
  }
    
}
  
  



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
    size = droneDefinition.size;
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
    angle += rotSpeed;  //what about direction?
    x = player.x + cos(angle) * distance;
    y = player.y + sin(angle) * distance;
  }
    
    
  
  
  void display() {
    stroke(DRONE_STROKE);
    strokeWeight(DRONE_WEIGHT);
    fill(fill);
    ellipse(x, y, size, size);
    fill(BLACK);
    ellipse(x, y, size / 2, size / 2);  // half size black circle in center
  }
  
}