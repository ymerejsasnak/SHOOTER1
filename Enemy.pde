/*
  CLASS FOR INDIVIDUAL ENEMIES
*/
class Enemy {
  
  float x, y;
  
  float speed; // pixels per second
  float hp;
  int maxHP;
  int enemyPower;
  int enemySize;
  EnemyType enemyType; //needed?
  int reward;
  
  // define color based on movement type, with variation based on power/speed/hp/etc
  color fill;
  color outerStroke;
  int outerWeight;
  color innerStroke;
  int innerWeight;
  
  boolean dead = false;
  boolean frozen = false;
  Timer freezeTimer;  
  
  Enemy(float x, float y, EnemyDefinition enemyDef, int levelProgression) {
    
    this.x = x;
    this.y = y;
    
    speed = enemyDef.speed + min(ENEMY_SPEED_SCALE * levelProgression, MAX_ENEMY_SPEEDUP); // pixels per second
    hp = enemyDef.hp + min(int(levelProgression / ENEMY_HP_SCALE), MAX_ENEMY_HPUP);
    maxHP = enemyDef.hp + min(int(levelProgression / ENEMY_HP_SCALE), MAX_ENEMY_HPUP);
    enemyPower = enemyDef.power; // + levelProgression / ENEMY_POWER_SCALE;
    enemySize = enemyDef.size;
    enemyType = enemyDef.enemyType;//?
    reward = enemyDef.reward + levelProgression;
  }
  
  
  float targetPlayer() {
    return atan2(player.y - y, player.x - x); 
  }
  
  
  // basic method to update status of enemy, positional updates and whatnot done in subclasses
  void update() {
    
    // if frozen, check timer
    if (frozen && freezeTimer.check()) {
        frozen = false;
    }  
    
    // check for collision with player
    if (dist(x, y, player.x, player.y) < enemySize / 2 + player.size / 2) {
      player.hitByEnemy(enemyPower);
      dead = true;
      //return false; // exit if dead
    }
  }
  
  
  // enemy hit by bullet, lower its hp by bullet power
  void hitByBullet(float damage, boolean freeze) {
    if (freeze) {
      frozen = true;
      freezeTimer = new Timer(int(FREEZE_DURATION * player.freezeTimeMultiplier));
    }
    hp -= damage;
  }
  
  
  //enemy hit by drone, act accordingly
  void hitByDrone(float damage, boolean freeze) {
    if (freeze) {
      frozen = true;
      freezeTimer = new Timer(FREEZE_DURATION);
    }
    hp -= damage;
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



class TargettingEnemy extends Enemy {
  
  float direction; // angle for enemies that move in straight lines
  
  TargettingEnemy(float x, float y, EnemyDefinition enemyDef, int levelProgression) {
    super(x, y, enemyDef, levelProgression);
    
    // aim directly at player 
    direction = targetPlayer();
  }
  
  void update() {
    super.update();
    
    if (frozen) {
      return;
    }
    
    x += cos(direction) * speed * deltaTime.getDelta();
    y += sin(direction) * speed * deltaTime.getDelta();
  }
  
}

class RotationalEnemy extends Enemy {
  
  float distance, angle; //  for enemies that move along curves (dist from player, angle of rotation)
  boolean clockwise; // (for determining rotation direction
  
  RotationalEnemy(float x, float y, EnemyDefinition enemyDef, int levelProgression) {
    super(x, y, enemyDef, levelProgression);
    
    distance = dist(player.x, player.y, x, y);
    clockwise = random(10) > 5;  // 50% chance to be clockwise or counter
    angle = atan2(y - player.y, x - player.x); // calculate starting angle based on spawn position
  }
  
  void update() {
    super.update();
    
    if (frozen) {
      return;
    }
    
    // rotation positive if clockwise, negative if counterclockwise
    int rotation = clockwise ? 1 : -1;
               
    //increase angle as distance gets smaller
    angle += ARC_LENGTH / distance * rotation * deltaTime.getDelta();
    distance -= speed * deltaTime.getDelta();
    
    x = player.x + cos(angle) * distance;
    y = player.y + sin(angle) * distance;
  } 
}



class StandardEnemy extends TargettingEnemy {
  StandardEnemy(float x, float y, EnemyDefinition enemyDef, int levelProgression) {
    super(x, y, enemyDef, levelProgression);
    fill = color(enemySize);
    outerStroke = color(50); 
    outerWeight = 2;
    innerStroke = color(enemySize, 0, 0);
    innerWeight = 5;
  }
}
   
  
class RandomEnemy extends TargettingEnemy {
  Timer randomTimer; // for timing direction change on 'RANDOM' movement enemies
  RandomEnemy(float x, float y, EnemyDefinition enemyDef, int levelProgression) {
    super(x, y, enemyDef, levelProgression);
    
    randomTimer = new Timer((int)random(RANDOM_TIMER_MIN, RANDOM_TIMER_MAX));
    fill = color(150, 10, 30);
    outerStroke = color(speed + 50, 125, 125); 
    outerWeight = 1;
    innerStroke = color(0, enemySize, 50);
    innerWeight = 2;
  }
  
  void update() {
    super.update();
    // direction change
    if (randomTimer.check()){
      // chance to move directly toward player
      if (random(100) < CHANCE_TARGET_PLAYER) { 
        direction = targetPlayer();
      } else {
        direction = random(0, 2 * PI); 
      }
    } 
  }
}


class AsteroidEnemy extends TargettingEnemy {
  AsteroidEnemy(float x, float y, EnemyDefinition enemyDef, int levelProgression) {
    super(x, y, enemyDef, levelProgression);
    fill = color(150, enemySize, 0);
    outerStroke = color(200, 150, 0); 
    outerWeight = 4;
    innerStroke = color(100, 50, enemySize);
    innerWeight = 1;
    // also asteroids just pick arbitrary target and move in that direction until off screen
    direction = atan2(random(height) - y, random(width) - x);
  }
  
  void update() {
    super.update();
    // asteroid is only enemy that will go off-screen and not come back, so set to dead if it does
    dead = (x > width + enemySize || x < 0 - enemySize ||
            y > height + enemySize || y < 0 - enemySize);   
  }
}


class TeleportEnemy extends TargettingEnemy {
  Timer teleportTimer;
  TeleportEnemy(float x, float y, EnemyDefinition enemyDef, int levelProgression) {
    super(x, y, enemyDef, levelProgression);
    teleportTimer = new Timer((int) random(TELEPORT_TIMER_MIN, TELEPORT_TIMER_MAX));
    
    fill = color(50, 20, 60);
    outerWeight = 2;
    outerStroke = color(20, 50, 60);
    innerStroke = color(10, 30, 50);
    innerWeight = 2;
  }
  
  void update() {
    super.update();
    
    // position change
    if (teleportTimer.check()) {
      float oldx, oldy; // store these to draw 'teleport line'  (move this to its own display function once everything organized)
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
      direction = targetPlayer();
      
      // gets faster each teleport (so will more likely reach player eventually)
      speed += TELEPORTER_SPEED_INCREASE; 
    }
  }
}


class CarrierEnemy extends TargettingEnemy {
  int numberCarried;
  EnemyDefinition carriedType;
  
  CarrierEnemy(float x, float y, EnemyDefinition enemyDef, int levelProgression) {
    super(x, y, enemyDef, levelProgression);
    numberCarried = enemyDef.numberCarried;
    carriedType = enemyDef.carriedEnemy;
    
    fill = color(100, 100, 50);
    outerStroke = color(250, 0, 0);
    innerStroke = color(250, 0, 0);
    outerWeight = 1;
    innerWeight = 1;
  }
  
  void update() {
    super.update();
    if (dead) {
      for (int i = 0; i < numberCarried; i++) {
        enemies.addEnemy(x + random(-enemySize / 2, enemySize / 2), 
                         y + random(-enemySize / 2, enemySize / 2),
                         carriedType, game.levelProgression);              
      }
    }
    
  }
}


class CirclesEnemy extends RotationalEnemy {
  CirclesEnemy(float x, float y, EnemyDefinition enemyDef, int levelProgression) {
    super(x, y, enemyDef, levelProgression);
    fill = color(enemySize);
    outerStroke = color(enemySize, enemySize, 220); 
    outerWeight = 4;
    innerStroke = color(20, 20, speed);
    innerWeight = 1;     
  }
  
  void update() {
    super.update();
    if (y >= height - enemySize && x < player.x) {
      clockwise = true;
    } else if ( y >= height - enemySize && x > player.x) {
      clockwise = false;
    }
  }
}


class OscilEnemy extends RotationalEnemy {
  Timer oscilTimer; // timing of switching direction
  
  OscilEnemy(float x, float y, EnemyDefinition enemyDef, int levelProgression) {
    super(x, y, enemyDef, levelProgression);
    oscilTimer = new Timer((int) random(OSCIL_TIMER_MIN, OSCIL_TIMER_MAX));
    
    fill = color(50, speed + 100, 0);
    outerStroke = color(0, speed + 50, 50); 
    outerWeight = 1;
    innerStroke = color(100, 50, enemySize);
    innerWeight = 5;
  }
  
  void update() {
    super.update();
    if (oscilTimer.check()) {
      clockwise = !clockwise;
    }
  }
}