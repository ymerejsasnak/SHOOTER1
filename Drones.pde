/*
  CLASS TO CONTROL DRONE OBJECTS
*/

class Drones {
  
  Drone drone1;
  Drone drone2;
   
  //first argument is start angle - makes both start opposite each other
  void setDroneOne(DroneDefinition droneDefinition) {
    drone1 = new Drone(0, droneDefinition);
  }
  void setDroneTwo(DroneDefinition droneDefinition) {
    drone2 = new Drone(PI, droneDefinition);
  }
  
  void resetAngles() {
    if (drone1 != null) {
      drone1.angle = 0;
    }
    if (drone2 != null) {
      drone2.angle = PI;
    }
  }
  
  void run() {
    if (drone1 != null) {
      drone1.update();
      drone1.display();
    }
    if (drone2 != null) {
      drone2.update();
      drone2.display();
    }
  }   
}