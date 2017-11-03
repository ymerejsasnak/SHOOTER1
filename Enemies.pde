/*
  CLASS TO STORE AND CONTROL ENEMY OBJECTS AS A WHOLE
*/
class Enemies {
  
  ArrayList<Enemy> enemies;
  int lastSpawnTime;
    
  Enemies() {
    
    enemies = new ArrayList<Enemy>();
    lastSpawnTime = 0;
    
  }
  
  // 'run' the enemies, ie add enemies according to rate/max amount,
  // then update positions, check for collision with bullets, remove dead, display rest
  // should this be broken up a bit more????
  void run() {
    
    // temporary values, will eventually load these from level definitions
    int temp_rate = LEVEL_THREE_SPAWN_RATE; // enemies per second
    int temp_max_count = LEVEL_THREE_MAX_ENEMIES;
    
    // generate new enemy if enough time has passed (convert to millisecs between)
    // and if max number is not reached
    
    int wait = 1000 / temp_rate;
    
    if (wait <= millis() - lastSpawnTime && enemies.size() < temp_max_count) {  
      
      int choice = (int) random(0, game.currentLevel.length);
      EnemyDefinition typeToSpawn = game.currentLevel[choice];
      
      enemies.add(new Enemy(typeToSpawn));   
      lastSpawnTime = millis();
    }
  
    // iterate through all enemies (backwards to allow non-issue deletion)
    for (int e = enemies.size() - 1; e >= 0; e--) {
      
      Enemy enemy = enemies.get(e);
      enemy.update();
      
      // brute force collision detection between enemy and bullets 
      // (eventually find a better way to allow better framerates w/ lots onscreen
      for (Bullet b: bullets.bullets){
        if (dist(enemy.x, enemy.y, b.x, b.y) <= (enemy.enemySize/2 + b.bulletSize/2)) {
          enemy.hit(b.power, b.bulletType); // go to submethod to subtract bullet power from enemy
          b.hit(); // also deal with bullet 'hit' condition
        }
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
  float oscilTimer, oscilDuration; // for OSCIL enemies
  
  boolean dead = false;
  boolean frozen = false;
    
  float speed; // pixels per second
  float hp;
  int maxHP;
  int power;
  int enemySize;
  MovementType movementType;
  
  int moveTimer; // for timing direction change on 'RANDOM' movement enemies
  int moveDuration; // in ms
    
  // define color based on movement type, with variation based on power/speed/hp/etc
  color fill = color(200, 50, 0);
  color outerStroke = color(100, 100, 0);
  int outerWeight = 5;
  color innerStroke = color (200, 100, 50);
  int innerWeight = 10;
  
  Enemy(EnemyDefinition enemyDef) {
    
    speed = enemyDef.speed; // pixels per second
    hp = enemyDef.hp;
    maxHP = enemyDef.hp;
    power = enemyDef.power;
    enemySize = enemyDef.size;
    movementType = enemyDef.movementType;
    
    moveTimer = 0;
    moveDuration = (int) random(300, 1000);
    
    oscilTimer = 0;
    oscilDuration = (int) random(400, 700);
    
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
      clockwise = random(10) > 5;
      distance = dist(player.x, player.y, x, y);
      angle = atan2(y - player.y, x - player.x);
    }
    
    
    
  }
  
  // update position, check if off screen(??), check for collision w/ player(??)
  void update() {
    
    if (frozen) { return; } //no movement if frozen
    
    if (movementType == MovementType.RANDOM  && millis() - moveTimer > moveDuration){
      // chance to move directly toward player
      if (random(100) > 80) {
        direction = atan2(player.y - y, player.x - x);
      } else {
        direction = random(0, 2 * PI); 
      }
      moveTimer = millis();
    } 
    
    if (movementType == MovementType.CIRCLES || movementType == MovementType.OSCIL) {
      int rotation = 1;
      x = player.x + cos(angle) * distance;
      y = player.y + sin(angle) * distance;
      if (!clockwise) {rotation = -1;} else { rotation = 1; }
      angle += .5 * rotation * deltaTime.getDelta();
      distance -= speed * deltaTime.getDelta();
      
    }     
    else {
      x += cos(direction) * speed * deltaTime.getDelta();
      y += sin(direction) * speed * deltaTime.getDelta();
    }  
    
    if (movementType == MovementType.OSCIL && millis() - oscilTimer > oscilDuration) {
      clockwise = !clockwise;
      oscilTimer = millis();
    }
    
    if (movementType == MovementType.ASTEROID) {
      dead = (x > width + enemySize || x < 0 - enemySize ||
              y > height + enemySize || y < 0 - enemySize);
    }
    
    //CHECK FOR COLLISION WITH PLAYER HERE(?)
    if (dist(x, y, player.x, player.y) < enemySize/2 + player.size/2) {
      player.hit(power);
      dead = true;
    }
    
  }
  
  // enemy hit by bullet, lower its hp by bullet power
  void hit(float bPower, BulletType bulletType) {
    if (bulletType == BulletType.FREEZE) {
      frozen = true;
    } else {
      hp -= bPower;
      if (hp <= 0) {
        dead = true;
      }
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
    fill((float)hp / (float)maxHP * 255);
    ellipse(x, y, enemySize/2, enemySize/2);
    
    // blue circle overlaid if frozen
    if (frozen) {
      fill(0, 0, 255, 100);
      noStroke();
      ellipse(x, y, enemySize, enemySize);
    }
    
  }
}