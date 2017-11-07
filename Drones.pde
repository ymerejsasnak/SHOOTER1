class Drones {
  
  Drone[] drones; 
  
  Drones() {
    drones = new Drone[2];
    
  }
  
  void setDroneOne(DroneDefinition droneDefinition) {
    drones[0] = new Drone(droneDefinition);
  }
  
  
  void run() {
     drones[0].update();
     drones[0].display();
     //drones[1].update();
     //drones[1].display();
  }
    
}
  
  



class Drone {
  
  float x, y;
  float angle;
  int distance;
  int size;
  float rotSpeed;
  DroneType type;
  
  Drone(DroneDefinition droneDefinition) {
    angle = random(2 * PI);
    distance = droneDefinition.distance;
    size = droneDefinition.size;
    rotSpeed = droneDefinition.rotSpeed;
    type = droneDefinition.type;
  }
  
  void update() {
    angle += rotSpeed;  //what about direction?
    x = player.x + cos(angle) * distance;
    y = player.y + sin(angle) * distance;
  }
    
    
  
  
  void display() {
    noStroke();
    fill(0,0,250, 100);
    ellipse(x, y, size, size);
  }
  
}