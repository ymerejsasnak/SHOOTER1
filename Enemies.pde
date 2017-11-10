/*
  CLASS TO STORE AND CONTROL ENEMY OBJECTS AS A WHOLE
*/
class Enemies {
  
  ArrayList<Enemy> enemies;
  Timer spawnTimer;
  int maxEnemies;
    
  Enemies() {
    
    enemies = new ArrayList<Enemy>();
    spawnTimer = new Timer(game.currentLevel.spawnWait);
    maxEnemies = game.currentLevel.maxEnemies;
    
  }
  
  // 'run' the enemies, ie add enemies according to rate/max amount,
  // then update positions, check for collision with bullets, remove dead, display rest
  // should this be broken up a bit more????
  void run(int levelProgression) {
    
    // generate new enemy if enough time has passed 
    // and if max number is not reached (note, timer will reset itself, so even if total goes below max, will  still have to wait out next time cycle)
    if (spawnTimer.check() && enemies.size() < maxEnemies) {  
      
      int choice = (int) random(0, game.currentLevel.spawnableEnemies.length);
      EnemyDefinition typeToSpawn = game.currentLevel.spawnableEnemies[choice];
      
      enemies.add(new Enemy(typeToSpawn, levelProgression));   
    }
  
    // iterate through all enemies (backwards to allow deletion)
    for (int e = enemies.size() - 1; e >= 0; e--) {
      
      Enemy enemy = enemies.get(e);
      enemy.update();
      
      // brute force collision detection between enemy and bullets 
      // (eventually find a better way to allow better framerates w/ lots onscreen
      for (Bullet b: bullets.bullets){
        if (dist(enemy.x, enemy.y, b.x, b.y) <= (enemy.enemySize / 2 + b.bulletSize / 2)) {   // divide by 2 to get radius
          enemy.hitByBullet(b.power, b.bulletType); // go to submethod to subtract bullet power from enemy
          b.hit(); // also deal with bullet 'hit' condition
        }
      }
      
      
      // also check if hit drones:
      Drone drone = drones.drones[0];
      if (dist(drone.x, drone.y, enemy.x, enemy.y) <= drone.size / 2 + enemy.enemySize / 2) {
        enemy.hitByDrone(drone.type);
      }
      drone = drones.drones[1];
      if (dist(drone.x, drone.y, enemy.x, enemy.y) <= drone.size / 2 + enemy.enemySize / 2) {
        enemy.hitByDrone(drone.type);
      }
      
      if (enemy.hp <= 0) {
        enemy.dead = true;
        player.currency += enemy.reward; // kill enemy, get some currency
        game.enemiesKilled += 1;
      }
      
      if (enemy.dead) {
        enemies.remove(e);
      } else {
        enemy.display();
      }
      
    }   
  } 
}


/*
  CLASS FOR INDIVIDUAL ENEMIES
*/
class Enemy {
  
  float x, y;
  
  float direction; // for enemies that move in straight lines
  float distance, angle; //  for enemies that move along curves (dist from player, angle, rot direction)
  boolean clockwise;
  
  Timer oscilTimer; // for OSCIL enemies, timing of switching direction
  Timer randomTimer; // for timing direction change on 'RANDOM' movement enemies
  Timer freezeTimer;
  Timer teleportTimer; //for TELEPORT ENEMIES
  
  boolean dead = false;
  boolean frozen = false;
    
  float speed; // pixels per second
  float hp;
  int maxHP;
  int power;
  int enemySize;
  MovementType movementType;
  int reward;
  
    
  // define color based on movement type, with variation based on power/speed/hp/etc
  color fill;
  color outerStroke;
  int outerWeight;
  color innerStroke;
  int innerWeight;
  
  Enemy(EnemyDefinition enemyDef, int levelProgression) {
    
    speed = enemyDef.speed + levelProgression * 5; // pixels per second
    hp = enemyDef.hp + levelProgression;
    maxHP = enemyDef.hp + levelProgression;
    power = enemyDef.power + levelProgression / 5;
    enemySize = enemyDef.size;
    movementType = enemyDef.movementType;
    reward = enemyDef.reward * (levelProgression + 1);
    
    randomTimer = new Timer((int)random(RANDOM_TIMER_MIN, RANDOM_TIMER_MAX));
    oscilTimer = new Timer((int) random(OSCIL_TIMER_MIN, OSCIL_TIMER_MAX));
    teleportTimer = new Timer((int) random(TELEPORT_TIMER_MIN, TELEPORT_TIMER_MAX));
    
    // randomly choose between the four screen sides to generate enemy
    int choice = (int) random(0, 4);
    switch(choice) {
      case 0:
        x = 0 - enemySize;
        y = random(height);
        break;
      case 1:
        x = width + enemySize;
        y = random(height);
        break;
      case 2:
        x = random(width);
        y = 0 - enemySize;      
        break;
      case 3:
        x = random(width);
        y = height + enemySize;      
        break;
    }
    
    //xxx all start aimed at playerxxxxx
    direction = atan2(player.y - y, player.x - x);
    if (movementType == MovementType.ASTEROID) {
      direction = atan2(random(height) - y, random(width) - x);
    }
    
    if (movementType == MovementType.CIRCLES || movementType == MovementType.OSCIL) {
      clockwise = random(10) > 5;  // 50% chance to be clockwise or counter
      distance = dist(player.x, player.y, x, y);
      angle = atan2(y - player.y, x - player.x);
    }
    
    // set colors (should I move these to the top as constants or does it really matter?????)
    switch (movementType) {
      case STANDARD:
        fill = color(enemySize);
        outerStroke = color(50); 
        outerWeight = 2;
        innerStroke = color(enemySize, 0, 0);
        innerWeight = 5;
        break;
      case RANDOM:
        fill = color(150, 10, 30);
        outerStroke = color(200, 125, 125); 
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
        outerStroke = color(0, 200, 50); 
        outerWeight = 1;
        innerStroke = color(100, 50, 50);
        innerWeight = 5;
        break;
      case ASTEROID:
      fill = color(200, 100, 0);
        outerStroke = color(250, 150, 0); 
        outerWeight = 4;
        innerStroke = color(100, 50, 50);
        innerWeight = 1;
        break;      
    }
    
  }
  
  // update position, check if off screen(??), check for collision w/ player(??)
  void update() {
    
    if (frozen) {
      if (freezeTimer.check()) {
        frozen = false;
      } else {
        return; 
      } //no movement if frozen
    }
      
    if (movementType == MovementType.RANDOM  && randomTimer.check()){
      // chance to move directly toward player
      if (random(100) < CHANCE_TARGET_PLAYER) { 
        direction = atan2(player.y - y, player.x - x);
      } else {
        direction = random(0, 2 * PI); 
      }

    } 
    
    if (movementType == MovementType.CIRCLES || movementType == MovementType.OSCIL) {
      int rotation;
      
      x = player.x + cos(angle) * distance;
      y = player.y + sin(angle) * distance;
      
      if (clockwise) { rotation = 1; } else { rotation = -1; }
       
       //increase angle as distance gets smaller
      angle += ARC_LENGTH / distance * rotation * deltaTime.getDelta();
      distance -= speed * deltaTime.getDelta();
      
    }     
    else {
      x += cos(direction) * speed * deltaTime.getDelta();
      y += sin(direction) * speed * deltaTime.getDelta();
    }  
    
    if (movementType == MovementType.OSCIL && oscilTimer.check()) {
      clockwise = !clockwise;
    }
    
    // asteroid is only enemy that will go significantly off-screen and not come back, so set to dead if it does
    if (movementType == MovementType.ASTEROID) {
      dead = (x > width + enemySize || x < 0 - enemySize ||
              y > height + enemySize || y < 0 - enemySize);
    }
    
    //CHECK FOR COLLISION WITH PLAYER HERE(?)
    if (dist(x, y, player.x, player.y) < enemySize / 2 + player.size / 2) {
      player.hit(power);
      dead = true;
    }
    
  }
  
  // enemy hit by bullet, lower its hp by bullet power
  void hitByBullet(float bPower, BulletType bulletType) {
    if (bulletType == BulletType.FREEZE) {
      frozen = true;
      freezeTimer = new Timer(FREEZE_DURATION);
    } else if (bulletType == BulletType.GAS) {
      hp -= bPower * deltaTime.getDelta();
    } else {
      hp -= bPower;
    }
  }
  
  //enemy hit by drone, act accordingly
  void hitByDrone(DroneType type) {
    switch(type) {
      case DAMAGE:
        hp -= DRONE_DPS * deltaTime.getDelta();
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
    
    // inner 'life' circle
    strokeWeight(innerWeight * 2);
    stroke(innerStroke, ENEMY_ALPHA);
    fill((float)hp / (float)maxHP * WHITE);
    ellipse(x, y, enemySize / 2, enemySize / 2);
    
    // blue circle overlaid if frozen
    if (frozen) {
      fill(FREEZE_COLOR);
      noStroke();
      ellipse(x, y, enemySize, enemySize);
    }
    
  }
}