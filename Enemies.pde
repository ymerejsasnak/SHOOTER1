/*
  CLASS TO STORE AND CONTROL ENEMY OBJECTS AS A WHOLE
*/
class Enemies {
  
  ArrayList<Enemy> enemies;
  Timer spawnTimer;
  int maxEnemies;
  int spawnIndex = 0;
    
  Enemies() {
    
    enemies = new ArrayList<Enemy>();
    spawnTimer = new Timer(game.currentLevelDefinition.spawnWait);
    maxEnemies = game.currentLevelDefinition.maxEnemies;
    
  }
  
  // 'run' the enemies, ie add enemies according to rate/max amount,
  // then update positions, check for collision with bullets, remove dead, display rest
  // ******should this be broken up a bit more????***** (maybe seperate generation and update/death into sep methods)
  void run(int levelProgression) {
    
    // generate new enemy if enough time has passed and if max number is not reached 
    //(note, timer will reset itself, so even if total goes below max, will still have to wait out next time cycle)
    if (spawnTimer.check() && enemies.size() < maxEnemies) {  
      
      // choose from defined list of enemies for current level
      //int choice = (int) random(0, game.currentLevelDefinition.spawnableEnemies.length);
      
      EnemyDefinition enemyToSpawn = game.currentLevelDefinition.spawnableEnemies[spawnIndex];
      spawnIndex = (spawnIndex + 1) % game.currentLevelDefinition.spawnableEnemies.length;
      
      // randomly choose between the four screen sides to generate enemy (off screen)
      int choice2 = (int) random(0, 4);
      float x = 0, y = 0;
      switch(choice2) {
        case 0:
          x = 0 - enemyToSpawn.size/2;
          y = random(height);
          break;
        case 1:
          x = width + enemyToSpawn.size/2;
          y = random(height);
          break;
        case 2:
          x = random(width);
          y = 0 - enemyToSpawn.size/2;      
          break;
        case 3:
          x = random(width);
          y = height + enemyToSpawn.size/2;      
          break;
      }
      enemies.add(new Enemy(x, y, enemyToSpawn, levelProgression));   
    }
  
  
    // iterate through all enemies (backwards to allow deletion)
    for (int e = enemies.size() - 1; e >= 0; e--) {
      
      Enemy enemy = enemies.get(e);
      enemy.update();
      
      // brute force collision detection between enemy and bullets 
      // (eventually find a better way to allow better framerates w/ lots onscreen?)
      for (Bullet b: bullets.bullets){
        if (dist(enemy.x, enemy.y, b.x, b.y) <= (enemy.enemySize / 2 + b.bulletSize / 2)) {   // divide by 2 to get radius
          enemy.hitByBullet(b.power, b.bulletType); // go to submethod to subtract bullet power from enemy
          b.hitEnemy(); // also deal with bullet 'hit' condition
        }
      }     
      
      // also check if hit drones:
      Drone drone = drones.drone1;
      if (drone != null && dist(drone.x, drone.y, enemy.x, enemy.y) <= drone.size / 2 + enemy.enemySize / 2) {
        enemy.hitByDrone(drone.type);
      }
      drone = drones.drone2;
      if (drone != null && dist(drone.x, drone.y, enemy.x, enemy.y) <= drone.size / 2 + enemy.enemySize / 2) {
        enemy.hitByDrone(drone.type);
      }
      
      // if hp reduced to 0, it's dead, get currency and kill score
      if (enemy.hp <= 0) {
        enemy.dead = true;
        player.currency += enemy.reward; // kill enemy, get some currency
        game.enemiesKilled += 1;
      }
      
      // if dead, remove (and generate carried type if a carrier), then display those not dead
      if (enemy.dead) {
        if (enemy.enemyType == EnemyType.CARRIER) {
          for (int i = 0; i < enemy.numberCarried; i++) {
            enemies.add(new Enemy(enemy.x + random(-enemy.enemySize / 2, enemy.enemySize / 2), 
                                  enemy.y + random(-enemy.enemySize / 2, enemy.enemySize / 2),
                                  enemy.carriedType, levelProgression));              
          }
        }
        enemies.remove(e);
      } else {
        enemy.display();
      } 
    }    
  }   
} 