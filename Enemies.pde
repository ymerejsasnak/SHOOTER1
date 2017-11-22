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
  
  
  // 'run' the enemies, ie add enemies according to rate/max amount,
  // then update positions, check for collision with bullets, remove dead, display rest
  void run(int levelProgression) {
    
    spawnEnemy(levelProgression);
  
  
    // iterate through all enemies (backwards to allow deletion)
    for (int enemyIndex = enemies.size() - 1; enemyIndex >= 0; enemyIndex--) {
      
      Enemy enemy = enemies.get(enemyIndex);
      
      //update pos
      enemy.update();
      //check for collision w/ bullet/drone
      enemy.collisionCheck();
      
      // if hp reduced to 0, it's dead
      if (enemy.hp <= 0) {
        enemy.death();
      }
           
      // if dead, remove, otherwise display it
      if (enemy.dead) {       
        enemies.remove(enemyIndex);
      } else {
        enemy.display();
      } 
    }    
    
  }   
  
  
  void spawnEnemy(int levelProgression) {
    // generate new enemy if enough time has passed and if max number is not reached 
    if (enemies.size() < maxEnemies && spawnTimer.check()) {  
      
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
  }
  
  
  
} 