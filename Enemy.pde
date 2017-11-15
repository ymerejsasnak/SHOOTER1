/*
  CLASS FOR INDIVIDUAL ENEMIES
*/
class Enemy {
  
  float x, y;
  
  float direction; // angle for enemies that move in straight lines
  float distance, angle; //  for enemies that move along curves (dist from player, angle of rotation)
  boolean clockwise; // (for determining rotation direction
  
  Timer oscilTimer; // for OSCIL enemies, timing of switching direction
  Timer randomTimer; // for timing direction change on 'RANDOM' movement enemies
  Timer freezeTimer;
  Timer teleportTimer; //for TELEPORT ENEMIES
  
  boolean dead = false;
  boolean frozen = false;
    
  float speed; // pixels per second
  float hp;
  int maxHP;
  int enemyPower;
  int enemySize;
  EnemyType enemyType;
  int reward;
  
  int numberCarried;
  EnemyDefinition carriedType;
    
  // define color based on movement type, with variation based on power/speed/hp/etc
  color fill;
  color outerStroke;
  int outerWeight;
  color innerStroke;
  int innerWeight;
  
  Enemy(float x, float y, EnemyDefinition enemyDef, int levelProgression) {
    
    this.x = x;
    this.y = y;
    
    speed = enemyDef.speed + ENEMY_SPEED_SCALE * levelProgression; // pixels per second
    hp = enemyDef.hp; // + levelProgression / ENEMY_HP_SCALE;
    maxHP = enemyDef.hp; // + levelProgression / ENEMY_HP_SCALE;
    enemyPower = enemyDef.power; // + levelProgression / ENEMY_POWER_SCALE;
    enemySize = enemyDef.size;
    enemyType = enemyDef.enemyType;
    reward = enemyDef.reward + levelProgression;
    
    // various things only used for specific enemies:
    numberCarried = enemyDef.numberCarried;
    carriedType = enemyDef.carriedEnemy;
    randomTimer = new Timer((int)random(RANDOM_TIMER_MIN, RANDOM_TIMER_MAX));
    oscilTimer = new Timer((int) random(OSCIL_TIMER_MIN, OSCIL_TIMER_MAX));
    teleportTimer = new Timer((int) random(TELEPORT_TIMER_MIN, TELEPORT_TIMER_MAX));
        
    
    // for enemies that move directly at player 
    direction = atan2(player.y - y, player.x - x);
    
    // but asteroids just pick arbitrary target and move in that direction until off screen
    if (enemyType == EnemyType.ASTEROID) {
      direction = atan2(random(height) - y, random(width) - x);
    }
    
    // setup distance, rotation angle, direction - for rotational enemies    
    if (enemyType == EnemyType.CIRCLES || enemyType == EnemyType.OSCIL) {
      distance = dist(player.x, player.y, x, y);
      clockwise = random(10) > 5;  // 50% chance to be clockwise or counter
      angle = atan2(y - player.y, x - player.x); // calculate starting angle based on spawn position
    }
    
    // set colors (separate this out into something else?)
    // (also use more variables in the settings for more variation between enemies of same 'type' but diff stats)
    switch (enemyType) {
      case STANDARD:
        fill = color(enemySize);
        outerStroke = color(50); 
        outerWeight = 2;
        innerStroke = color(enemySize, 0, 0);
        innerWeight = 5;
        break;
      case RANDOM:
        fill = color(150, 10, 30);
        outerStroke = color(150, 125, 125); 
        outerWeight = 1;
        innerStroke = color(0, 50, 50);
        innerWeight = 2;
        break;
      case CIRCLES:
        fill = color(20);
        outerStroke = color(50, 50, 220); 
        outerWeight = 4;
        innerStroke = color(20, 20, 100);
        innerWeight = 1;
        break;
      case OSCIL:
        fill = color(50, 150, 0);
        outerStroke = color(0, 150, 50); 
        outerWeight = 1;
        innerStroke = color(100, 50, 50);
        innerWeight = 5;
        break;
      case ASTEROID:
        fill = color(150, 100, 0);
        outerStroke = color(200, 150, 0); 
        outerWeight = 4;
        innerStroke = color(100, 50, 50);
        innerWeight = 1;
        break;
      case TELEPORT:
        fill = color(50, 20, 60);
        outerWeight = 2;
        outerStroke = color(20, 50, 60);
        innerStroke = color(10, 30, 50);
        innerWeight = 2;
        break;
      case CARRIER:
        fill = color(100, 100, 50);
        outerStroke = color(250, 0, 0);
        innerStroke = color(250, 0, 0);
        outerWeight = 1;
        innerWeight = 1;
        break;      
    }
  }
  
  
  // update position, check if off screen(??), check for collision w/ player(??)
  void update() {
    
    // first check if frozen
    if (frozen) {
      if (freezeTimer.check()) {
        frozen = false;
      } else {
        return; // exit method if it's frozen
      }
    }
      
    // random type, direction change
    if (enemyType == EnemyType.RANDOM  && randomTimer.check()){
      // chance to move directly toward player
      if (random(100) < CHANCE_TARGET_PLAYER) { 
        direction = atan2(player.y - y, player.x - x);
      } else {
        direction = random(0, 2 * PI); 
      }
    } 
    
    // teleport type, position change
    if (enemyType == EnemyType.TELEPORT && teleportTimer.check()) {
      float oldx, oldy; // store these to draw 'teleport line'
      oldx = x;
      oldy = y;
      
      //generate new x,y but not too close to the player
      x = random(width / 2 + TELEPORTER_DMZ, width);
      if (random(10) > 5) { x = width - x; }
      y = random(height / 2 + TELEPORTER_DMZ, height);
      if (random(10) > 5) { y = height - y; }
      
      stroke(outerStroke);
      strokeWeight(25);
      line(oldx, oldy, x, y); // draw a line to help indicate teleportation
      
      //recalc direction from new pos
      direction = atan2(player.y - y, player.x - x); 
      
      // gets faster each teleport (so will more likely reach player eventually)
      speed += TELEPORTER_SPEED_INCREASE; 
    }
    
    // if rotational type, update position
    if (enemyType == EnemyType.CIRCLES || enemyType == EnemyType.OSCIL) {
      int rotation;
      
      x = player.x + cos(angle) * distance;
      y = player.y + sin(angle) * distance;
      
      if (clockwise) { rotation = 1; } else { rotation = -1; }
       
      //increase angle as distance gets smaller
      angle += ARC_LENGTH / distance * rotation * deltaTime.getDelta();
      distance -= speed * deltaTime.getDelta();
      
    }  
    // else update position for straight line types
    else {
      x += cos(direction) * speed * deltaTime.getDelta();
      y += sin(direction) * speed * deltaTime.getDelta();
    }  
    
    if (enemyType == EnemyType.OSCIL && oscilTimer.check()) {
      clockwise = !clockwise;
    }
    
    // asteroid is only enemy that will go off-screen and not come back, so set to dead if it does
    if (enemyType == EnemyType.ASTEROID) {
      dead = (x > width + enemySize || x < 0 - enemySize ||
              y > height + enemySize || y < 0 - enemySize);
    }
    
    // check for collision with player
    if (dist(x, y, player.x, player.y) < enemySize / 2 + player.size / 2) {
      player.hitByEnemy(enemyPower);
      dead = true;
    }
  }
  
  
  // enemy hit by bullet, lower its hp by bullet power
  void hitByBullet(float bulletPower, BulletType bulletType) {
    if (bulletType == BulletType.FREEZE) {
      frozen = true;
      freezeTimer = new Timer(int(FREEZE_DURATION * player.freezeTimeMultiplier));
    } else if (bulletType == BulletType.GAS) {
      hp -= bulletPower * deltaTime.getDelta(); // gas is damage per second
    } else {
      hp -= bulletPower;
    }
  }
  
  
  //enemy hit by drone, act accordingly
  void hitByDrone(DroneType type) {
    switch(type) {
      case DAMAGE:
        hp -= DRONE_DPS * player.bulletPowerMultiplier * deltaTime.getDelta(); // damage type is dps not single hit
        break;
      case FREEZE:
        frozen = true;
        freezeTimer = new Timer(FREEZE_DURATION);
        break;
      case VAPORIZE:
        hp = 0;
        break;
    }
  }
  
  
  // draw enemy
  void display() {
    
    // enemy itself
    fill(fill, ENEMY_ALPHA);
    strokeWeight(outerWeight);
    stroke(outerStroke);
    ellipse(x, y, enemySize, enemySize);
    
    // inner hp indicator circle
    strokeWeight(innerWeight * 2);
    stroke(innerStroke, ENEMY_ALPHA);
    fill((float)hp / (float)maxHP * WHITE); // goes from 255/white for full life to 0/black for dead
    ellipse(x, y, enemySize / 2, enemySize / 2);
    
    // blue circle overlaid if frozen
    if (frozen) {
      fill(FROZEN_COLOR);
      noStroke();
      ellipse(x, y, enemySize, enemySize);
    }
  }
}