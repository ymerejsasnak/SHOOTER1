//currently all are temporary definitions for testing purposes

enum Level {
  // ms between spawns, max enemies, enemy list
  ONE(1000, 20, new EnemyDefinition[] {EnemyDefinition.EASY, EnemyDefinition.RANDOM}),
  TWO(500, 20, new EnemyDefinition[] {EnemyDefinition.REGULAR, EnemyDefinition.RANDOM, EnemyDefinition.CIRCLES}),
  THREE(200, 20, new EnemyDefinition[] {EnemyDefinition.BIGGIE, EnemyDefinition.ASTEROID, EnemyDefinition.OSCIL}),


  ;
  
  
  int spawnWait;
  int maxEnemies;
  EnemyDefinition[] spawnableEnemies;
  
  private Level(int spawnWait, int maxEnemies, EnemyDefinition[] spawnableEnemies) {
    this.spawnWait = spawnWait;
    this.maxEnemies = maxEnemies;
    this.spawnableEnemies = spawnableEnemies;
  }
}