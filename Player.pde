/*
  CLASS TO REPRESENT PLAYER
*/
class Player {
  
  int x = width / 2;
  int y = height;
  int size = PLAYER_SIZE;
  float radius = size/2;
  
  float[] turretAngle = new float[3];
  float[] turretX = new float[3];
  float[] turretY = new float[3];
  ArrayList<Timer> turretTimers = new ArrayList<Timer>();
  
  int currency = 0;
  int hp = STARTING_HP;
  int maxHP = STARTING_HP;
  boolean dead = false;
  
  boolean turret2 = false;
  boolean turret3 = false;
  BulletDefinition[] selectedBulletType = new BulletDefinition[3];
  ArrayList<BulletDefinition> unlockedBullets = new ArrayList<BulletDefinition>();   
  ArrayList<DroneDefinition> unlockedDrones = new ArrayList<DroneDefinition>();
  
  int highestLevelUnlocked = 1;
  int[] highScores = new int[Level.values().length];
  
  // these can go as high as 2, each upgrade raises them by maybe a tenth?
  float bulletPowerMultiplier = 1;
  float bulletSizeMultiplier = 1;
  float droneSizeMultiplier = 1;
  float freezeTimeMultiplier = 1;
  
  color fill = PLAYER_COLOR;
  color stroke = PLAYER_STROKE;
  int weight = PLAYER_STROKE_WEIGHT;
  
  
  Player() {
    
    selectedBulletType[0] = BulletDefinition.BASIC; 
    turretTimers = new ArrayList<Timer>();
    turretTimers.add(new Timer(selectedBulletType[0].rate));
    
  }
  
  
  void setStatus() {
    
    file.loadData();
    
    currency = file.currency;
    maxHP = file.maxHP;
    highestLevelUnlocked = file.highestLevel;
    
    selectedBulletType[0] = BulletDefinition.BASIC;
    turretTimers = new ArrayList<Timer>();
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
    
     
    for (int i = 0; i < file.bullets.length; i++) {
      if (file.bullets[i] == 1) {
        unlockedBullets.add(BulletDefinition.values()[i + 1]); // +1 because basic is always unlocked
      }
    }
    
    for (int i = 0; i < file.drones.length; i++) {
      if (file.drones[i] == 1) {
        unlockedDrones.add(DroneDefinition.values()[i]);
      }
      if (unlockedDrones.size() > 0) {
        drone = new Drone(0, unlockedDrones.get(0));
      }
    }
    
    
    
    bulletPowerMultiplier = file.bulletPowerMultiplier;
    bulletSizeMultiplier = file.bulletSizeMultiplier;
    droneSizeMultiplier = file.droneSizeMultiplier;
    freezeTimeMultiplier = file.freezeTimeMultiplier;
    
    highScores = file.highScores;  
  }
  
  
  // get aiming angle and gun drawing coordinates (based on mouse position)
  void update() {
    
    turretAngle[0] = atan2(mouseY - y, mouseX - x);
    turretAngle[1] = turretAngle[0] + PI/5;
    turretAngle[2] = turretAngle[0] - PI/5;
    
    
           
    for(int i = 0; i < selectedBulletType.length; i++){
       turretX[i] = x + cos(turretAngle[i]) * (radius + GUN_LENGTH);
       turretY[i] = y + sin(turretAngle[i]) * (radius + GUN_LENGTH);
    }
  }
  
  
  // shoot a bullet at given angle, timed with turretTimer
  void shoot() {
    
    for(int i = 0; i < selectedBulletType.length; i++){
       if (selectedBulletType[i] != null) {
         if(turretTimers.get(i).check()) {
            bullets.addBullet(turretAngle[i], turretX[i], turretY[i], selectedBulletType[i]);                 
         }
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
  
  
  // restart all turret timers in one go, for starting level
  void restartTurretTimers() {
    for (Timer t: turretTimers) {
      t.restart();
    }
    
  }
     
     
  // draw player
  void display() {
    
    fill(fill);
    strokeWeight(weight);
    stroke(stroke);
    
    // draw each turret
    for(int i = 0; i < selectedBulletType.length; i++){
      if (selectedBulletType[i] != null) {
        line(x, y, turretX[i], turretY[i]);
      }
    }
    
    // draw main player body
    ellipse(x, y, size, size);
    
    // draw life circle 
    fill((float)hp / (float)maxHP * WHITE);
    ellipse(x, y, size / 2, size / 2);
  }
}