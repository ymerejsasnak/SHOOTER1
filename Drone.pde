/*
  CLASS FOR DRONE
*/

class Drone {
  
  float x, y;
  float angle = 0;
  int distance;
  int size;
  float rotSpeed;
  int rotDirection;
  DroneType type;
  color fill;
    
  Drone(DroneDefinition droneDefinition) {
    
    distance = droneDefinition.distance;
    size = int(droneDefinition.size * player.droneSizeMultiplier);
    rotSpeed = droneDefinition.rotSpeed;
    type = droneDefinition.type;
  }
  
  void resetAngle() {
    angle = 0;
  }
  
  boolean freezeEnemy() {
    return false;
  }
  
  float damageEnemy() {
    return 0;
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


class DamageDrone extends Drone {
  
  DamageDrone(DroneDefinition droneDefinition) {
    super(droneDefinition);
    fill = DAMAGE_FILL;
  }
  
  float damageEnemy() {
    return DRONE_DPS * deltaTime.getDelta(); // damage is dps not single hit
  }
  
}


class FreezeDrone extends Drone {

  FreezeDrone(DroneDefinition droneDefinition) {
    super(droneDefinition);
    fill = FREEZE_FILL;
  }
  
  boolean freezeEnemy() {
    return true;
  }

}


class VaporizeDrone extends Drone {

  VaporizeDrone(DroneDefinition droneDefinition) {
    super(droneDefinition);
    fill = VAPORIZE_FILL;
  }
  
  float damageEnemy() {
    return VAPORIZE_DAMAGE; 
  }

}