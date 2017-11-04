/*
  CLASS TO REPRESENT PLAYER
*/
class Player {
  
  int x = width / 2;
  int y = height / 2;
  int size = 50;
  float radius = size/2;
  
  BulletDefinition[] turretTypes = new BulletDefinition[4];
  float[] turretAngle = new float[4];
  float[] turretX = new float[4];
  float[] turretY = new float[4];
  ArrayList<Timer> turretTimers = new ArrayList<Timer>();
  
  int currency;
  int hp = 20;
  int maxHP = 20;
  boolean dead = false;
  
  color fill = color(50, 100, 200);
  color stroke = color(40, 50, 250);
  int weight = 5;
  
  BulletDefinition bulletDefinition;
  
  Player() {
    currency = 0;
    
    //hard coded loading for testing
    turretTypes[0] = BulletDefinition.POWER;
    turretTimers.add(new Timer(turretTypes[0].rate));
    
    turretTypes[1] = BulletDefinition.POWER;
    turretTimers.add(new Timer(turretTypes[1].rate));
    
    turretTypes[2] = BulletDefinition.POWER;
    turretTimers.add(new Timer(turretTypes[2].rate));
    
    turretTypes[3] = BulletDefinition.POWER;
    turretTimers.add(new Timer(turretTypes[3].rate));
    
  }
  
  // get aiming angle and gun drawing coordinates
  void update() {
    
    turretAngle[0] = atan2(mouseY - y, mouseX - x);
    turretAngle[1] = turretAngle[0] + PI;
    turretAngle[2] = turretAngle[0] - PI/2;
    turretAngle[3] = turretAngle[0] + PI/2;
           
    for(int i = 0; i < turretTypes.length; i++){
       turretX[i] = x + cos(turretAngle[i]) * (radius + GUN_LENGTH);
       turretY[i] = y + sin(turretAngle[i]) * (radius + GUN_LENGTH);
    }
  }
  
  // shoot a bullet at given angle, timed based on millisecs
  void shoot() {
    
    for(int i = 0; i < turretTypes.length; i++){
       if (turretTypes[i] != null && turretTimers.get(i).check()) {
          
          bullets.addBullet(turretAngle[i], turretX[i], turretY[i], turretTypes[i]);
          
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
    
    for(int i = 0; i < turretTypes.length; i++){
      if (turretTypes[i] != null) {
        line(x, y, turretX[i], turretY[i]);
      }
    }
    
    ellipse(x, y, size, size);
    
    // show life circle 
    fill((float)hp / (float)maxHP * 255);
    ellipse(x, y, size/2, size/2);
       
    
  }
}