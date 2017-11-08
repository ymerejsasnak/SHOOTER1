class Drones {
  
  Drone[] drones; 
   
  Drones() {
    drones = new Drone[2];
        
  }
  
  //first argument makes both start opposite each other
  void setDroneOne(DroneDefinition droneDefinition) {
    drones[0] = new Drone(0, droneDefinition);
  }
  void setDroneTwo(DroneDefinition droneDefinition) {
    drones[1] = new Drone(PI, droneDefinition);
  }
  
  void resetAngles() {
    drones[0].angle = 0;
    drones[1].angle = PI;
  }
  
  void run() {
     drones[0].update();
     drones[0].display();
     drones[1].update();
     drones[1].display();
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
        fill = color(100, 10, 10);
        break;      
      case FREEZE:
        fill = color(150, 150, 220);
        break;
      case VAPORIZE:
        fill = color(240, 230, 210);
        break;      
    }
  }
  
  void update() {
    angle += rotSpeed;  //what about direction?
    x = player.x + cos(angle) * distance;
    y = player.y + sin(angle) * distance;
  }
    
    
  
  
  void display() {
    stroke(100);
    strokeWeight(2);
    fill(fill);
    ellipse(x, y, size, size);
    fill(0);
    ellipse(x, y, size/2, size/2);
  }
  
}