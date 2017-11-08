//currently all are temporary definitions for testing purposes

enum Level {
  // text description,ms between spawns, max enemies, enemy list
  ONE("Level 1", 1000, 20, new EnemyDefinition[] {EnemyDefinition.EASY}),
  TWO("Level 2", 900, 20, new EnemyDefinition[] {EnemyDefinition.REGULAR, EnemyDefinition.REGULAR, EnemyDefinition.CIRCLES1}),
  THREE("Level 3", 900, 20, new EnemyDefinition[] {EnemyDefinition.REGULAR, EnemyDefinition.REGULAR, EnemyDefinition.BIGGIE, EnemyDefinition.BIGRAND}),
  FOUR("Level 4", 800, 30, new EnemyDefinition[] {EnemyDefinition.CIRCLES2, EnemyDefinition.CIRCLES1, EnemyDefinition.ASTEROID}),
  FIVE("Level 5", 800, 30, new EnemyDefinition[] {EnemyDefinition.CIRCLES2, EnemyDefinition.OSCIL2, EnemyDefinition.RANDOM1, EnemyDefinition.BIGGEROID}),
  SIX("Level 6", 700, 10, new EnemyDefinition[] {EnemyDefinition.HUGE, EnemyDefinition.HUGE, EnemyDefinition.ASTEROID}),
  SEVEN("Level 7", 600, 40, new EnemyDefinition[] {EnemyDefinition.RANDOM2, EnemyDefinition.FAST}),
  EIGHT("Level 8", 500, 50, new EnemyDefinition[] {EnemyDefinition.FAST, EnemyDefinition.ASTEROID, EnemyDefinition.OSCIL2}),
  ;
  
  
  String text;
  int spawnWait;
  int maxEnemies;
  EnemyDefinition[] spawnableEnemies;
  
  private Level(String text, int spawnWait, int maxEnemies, EnemyDefinition[] spawnableEnemies) {
    this.text = text;
    this.spawnWait = spawnWait;
    this.maxEnemies = maxEnemies;
    this.spawnableEnemies = spawnableEnemies;
  }
}