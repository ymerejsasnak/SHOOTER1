/*
  CLASS TO REPRESENT PLAYER
*/
class Player {
  
  int x = width / 2;
  int y = height / 2;
  int size = 50;
  float radius = size/2;
  
  
  float[] turretAngle = new float[4];
  float[] turretX = new float[4];
  float[] turretY = new float[4];
  ArrayList<Timer> turretTimers = new ArrayList<Timer>();
      
  
  int currency = 0;
  int hp = 20;
  int maxHP = 20;
  boolean dead = false;
  
  boolean turret2 = false;
  boolean turret3 = false;
  boolean turret4 = false;
  BulletDefinition[] selectedBulletType = new BulletDefinition[4];
  ArrayList<BulletDefinition> unlockedBullets = new ArrayList<BulletDefinition>();   
  ArrayList<DroneDefinition> unlockedDrones1 = new ArrayList<DroneDefinition>();
  ArrayList<DroneDefinition> unlockedDrones2 = new ArrayList<DroneDefinition>();
  
  int highestLevelUnlocked = 1;
  int[] highScores = new int[Level.values().length];
  
  float bulletPowerMultiplier = 1;
  float bulletSizeMultiplier = 1;
  float droneSizeMultiplier = 1;
  float freezeTimeMultiplier = 1;
  
  color fill = color(50, 100, 200);
  color stroke = color(40, 50, 250);
  int weight = 5;
  
  
  Player() {
    selectedBulletType[0] = BulletDefinition.BASIC;
    turretTimers = new ArrayList<Timer>(4);
    turretTimers.add(new Timer(selectedBulletType[0].rate));
    
  }
  
  void setStatus() {
    file.loadData();
    
    currency = file.currency;
    maxHP = file.maxHP;
    highestLevelUnlocked = file.highestLevel;
    
    selectedBulletType[0] = BulletDefinition.BASIC;
    turretTimers = new ArrayList<Timer>(4);
    turretTimers.add(new Timer(selectedBulletType[0].rate));
        
    
    if (file.turret2) {
      turret2 = true;
      selectedBulletType[1] = BulletDefinition.BASIC;
      turretTimers.add(new Timer(selectedBulletType[1].rate));
    }
    if (file.turret3) {
      turret3 = true;
      selectedBulletType[2] = BulletDefinition.BASIC;
      turretTimers.add(new Timer(selectedBulletType[2].rate));
    }
    if (file.turret4) {
      turret4 = true;
      selectedBulletType[3] = BulletDefinition.BASIC;
      turretTimers.add(new Timer(selectedBulletType[3].rate));
    }
     
    for (int i = 0; i < file.bullets.length; i++) {
      if (file.bullets[i] == 1) {
        unlockedBullets.add(BulletDefinition.values()[i + 1]); // +1 because basic is always unlocked
      }
    }
    for (int i = 0; i < file.drones1.length; i++) {
      if (file.drones1[i] == 1) {
        unlockedDrones1.add(DroneDefinition.values()[i]);
      }
    }
    for (int i = 0; i < file.drones2.length; i++) {
      if (file.drones2[i] == 1) {
        unlockedDrones2.add(DroneDefinition.values()[i]);
      }
    }
    
    
    bulletPowerMultiplier = file.bulletPowerMultiplier;
    bulletSizeMultiplier = file.bulletSizeMultiplier;
    droneSizeMultiplier = file.droneSizeMultiplier;
    freezeTimeMultiplier = file.freezeTimeMultiplier;
    
    highScores = file.highScores;
     
  }
  
  // get aiming angle and gun drawing coordinates
  void update() {
    
    turretAngle[0] = atan2(mouseY - y, mouseX - x);
    turretAngle[1] = turretAngle[0] + PI;
    turretAngle[2] = turretAngle[0] - PI/2;
    turretAngle[3] = turretAngle[0] + PI/2;
           
    for(int i = 0; i < selectedBulletType.length; i++){
       turretX[i] = x + cos(turretAngle[i]) * (radius + GUN_LENGTH);
       turretY[i] = y + sin(turretAngle[i]) * (radius + GUN_LENGTH);
    }
  }
  
  // shoot a bullet at given angle, timed based on millisecs
  void shoot() {
    
    for(int i = 0; i < selectedBulletType.length; i++){
       if (selectedBulletType[i] != null && turretTimers.get(i).check()) {
          
          bullets.addBullet(turretAngle[i], turretX[i], turretY[i], selectedBulletType[i]);
                    
       }      
    } 
  }
  
  // called from enemy class when it hits the player, reduce HP by enemy power
  void hitByEnemy(int ePower) {
    
    hp -= ePower;
    if (hp <= 0) {
      dead = true;
    }
    
  }
  
  void restartTurretTimers() {
    for (Timer t: turretTimers) {
      t.restart();
    }
    
  }
     
  // draw player w/ gun(s)
  void display() {
    fill(fill);
    strokeWeight(weight);
    stroke(stroke);
    
    for(int i = 0; i < selectedBulletType.length; i++){
      if (selectedBulletType[i] != null) {
        line(x, y, turretX[i], turretY[i]);
      }
    }
    
    ellipse(x, y, size, size);
    
    // show life circle 
    fill((float)hp / (float)maxHP * WHITE);
    ellipse(x, y, size / 2, size / 2);
       
    
  }
}