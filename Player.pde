/*
  CLASS TO REPRESENT PLAYER
*/
class Player {
  
  int x = width / 2;
  int y = height / 2;
  int size = 50;
  float radius = size/2;
  
  float angle;
  float gunX, gunY;
  
  BulletDefinition[] turrets = new BulletDefinition[] {null, null, null, null};
  
  int hp = 20;
  int maxHP = 20;
  boolean dead = false;
  
  //int[] fireRatesfireRate_main, fireRate_back, fireRate_left, fireRate_right; // bullets per second
  int[] lastFireTime = {0, 0, 0, 0};
  
  color fill = color(50, 100, 200);
  color stroke = color(40, 50, 250);
  int weight = 5;
  
  BulletDefinition bulletDefinition;
  
  Player() {
    turrets[0] = BulletDefinition.BASIC;
   turrets[1] = BulletDefinition.PEA;
   turrets[2] = BulletDefinition.FREEZE;
   turrets[3] = BulletDefinition.GAS;
    
    //fireRate_main = turret_main.rate;
    //fireRate_back = turret_back.rate;
    //fireRate_left = turret_left.rate;
    //fireRate_right = turret_right.rate;
  }
  
  // get aiming angle and gun drawing coordinates
  void update() {
    
    angle = atan2(mouseY - y, mouseX - x);
    gunX = x + cos(angle) * (radius + GUN_LENGTH);
    gunY = y + sin(angle) * (radius + GUN_LENGTH);
    
  }
  
  // shoot a bullet at given angle, timed based on millisecs
  void shoot() {
    
    for(int i = 0; i < turrets.length; i++){
       if (turrets[i] != null) {
         // convert 'bullets per second' to 'milliseconds between bullets'  
        int wait = 1000 / turrets[i].rate;
        
        
        if (wait <= millis() - lastFireTime[i]) {
          float turretAngle = angle;
          float turretX = gunX;
          float turretY = gunY;
          switch(i) {
            case 1:
              turretAngle += PI; // 1 is back turret
              break;
            case 2:
              turretAngle -= PI/2; // left
              break;
            case 3:
              turretAngle += PI/2; //right
              break;
          }
          
          turretX = x + cos(turretAngle) * (radius + GUN_LENGTH);
          turretY = y + sin(turretAngle) * (radius + GUN_LENGTH);
          
          bullets.addBullet(turretAngle, turretX, turretY, turrets[i]);
          lastFireTime[i] = millis();
        }
      }
       
    }
    
    
    
  }
  
  // called from enemy class when it hits the player, reduce HP by enemy power
  void hit(int ePower) {
    
    hp -= ePower;
    if (hp <= 0) {
      dead = true;
    }
    
  }
     
  // draw player w/ gun(s)
  void display() {
    
    fill(fill);
    strokeWeight(weight);
    stroke(stroke);
    
    float turretAngle = angle;
     float turretX = gunX;
     float turretY = gunY;
    for(int i = 0; i < turrets.length; i++){ //major code repetition here, same as above
       if (turrets[i] != null) {
           
          switch(i) {
            case 1:
              turretAngle += PI; // 1 is back turret
              break;
            case 2:
              turretAngle += PI/2; // left
              break;
            case 3:
              turretAngle += PI; //right
              break;
          }
        }
        
        turretX = x + cos(turretAngle) * (radius + GUN_LENGTH);
        turretY = y + sin(turretAngle) * (radius + GUN_LENGTH);
        line(x, y, turretX, turretY);
    }
    ellipse(x, y, size, size);
    
    // show life circle (same code as in enemy class....not very DRY....)
    fill((float)hp / (float)maxHP * 255);
    ellipse(x, y, size/2, size/2);
       
    
  }
}