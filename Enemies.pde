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
      
      // spawn enemies in order listed in definition by incrementing index      
      EnemyDefinition enemyToSpawn = game.currentLevelDefinition.spawnableEnemies[spawnIndex];
      spawnIndex = (spawnIndex + 1) % game.currentLevelDefinition.spawnableEnemies.length;
      
      // randomly choose between the top half of sides or top of screen to generate enemy (off screen)
      int choice2 = (int) random(0, 4);
      float x = 0, y = 0;
      switch(choice2) {
        case 0:
          x = 0 - enemyToSpawn.size/2;
          y = random(height/2);
          break;
        case 1:
          x = width + enemyToSpawn.size/2;
          y = random(height/2);
          break;
        case 2:
        case 3:
          x = random(width);
          y = 0 - enemyToSpawn.size/2;      
          break;
      }
      
      addEnemy(x, y, enemyToSpawn, levelProgression);
      
    }
  
  
    // iterate through all enemies (backwards to allow deletion)
    for (int enemyIndex = enemies.size() - 1; enemyIndex >= 0; enemyIndex--) {
      
      Enemy enemy = enemies.get(enemyIndex);
      
      // brute force collision detection between enemy and bullets 
      // (eventually find a better way to allow better framerates w/ lots onscreen?)
      for (Bullet b: bullets.bullets){
        if (dist(enemy.x, enemy.y, b.x, b.y) <= (enemy.enemySize / 2 + b.bulletSize / 2)) {   // divide by 2 to get radius
          enemy.hitByBullet(b.damageEnemy(), b.freezeEnemy()); // go to submethod to subtract bullet power from enemy
        }
      }     
      
      // also check if hit drones:
      if (drone != null && dist(drone.x, drone.y, enemy.x, enemy.y) <= drone.size / 2 + enemy.enemySize / 2) {
        enemy.hitByDrone(drone.damageEnemy(), drone.freezeEnemy());
      }
      
      
      // if hp reduced to 0, it's dead, get currency and kill score
      if (enemy.hp <= 0) {
        enemy.dead = true;
        player.currency += enemy.reward; // kill enemy, get some currency
        game.enemiesKilled += 1;
      }
      
      
      enemy.update();
      
      // if dead, remove (and generate carried type if a carrier), then display those not dead
      if (enemy.dead) {
        
        enemies.remove(enemyIndex);
      } else {
        enemy.display();
      } 
    }    
  }   
  
  void addEnemy(float x, float y, EnemyDefinition enemyToSpawn, int levelProgression) {
    // add the correct enemy subclass to enemies list
      switch(enemyToSpawn.enemyType) {
        case STANDARD:
          enemies.add(new StandardEnemy(x, y, enemyToSpawn, levelProgression));   
          break;
        case RANDOM:
          enemies.add(new RandomEnemy(x, y, enemyToSpawn, levelProgression));   
          break;
        case CIRCLES:
          enemies.add(new CirclesEnemy(x, y, enemyToSpawn, levelProgression));   
          break;
        case OSCIL:
          enemies.add(new OscilEnemy(x, y, enemyToSpawn, levelProgression));   
          break;
        case ASTEROID:
          enemies.add(new AsteroidEnemy(x, y, enemyToSpawn, levelProgression));   
          break;
        case TELEPORT:
          enemies.add(new TeleportEnemy(x, y, enemyToSpawn, levelProgression));   
          break;
        case CARRIER:
          enemies.add(new CarrierEnemy(x, y, enemyToSpawn, levelProgression));   
          break;
      }
  }
} 