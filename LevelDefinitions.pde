//currently all are temporary definitions for testing purposes

enum Level {
  // text description,ms between spawns, max enemies, enemy list
  ONE("Level 1", 1000, 20, new EnemyDefinition[] {EnemyDefinition.EASY}),
  TWO("Level 2", 500, 20, new EnemyDefinition[] {EnemyDefinition.REGULAR, EnemyDefinition.BIGGIE, EnemyDefinition.CIRCLES}),
  THREE("Level 3", 20, 50, new EnemyDefinition[] {EnemyDefinition.RANDOM, EnemyDefinition.ASTEROID, EnemyDefinition.OSCIL}),

  //DUMMY COPIES OF ONE FOR NOW
  FOUR("Level poop", 1000, 20, new EnemyDefinition[] {EnemyDefinition.EASY}),
  FIVE("Level x", 1000, 20, new EnemyDefinition[] {EnemyDefinition.EASY}),
  SIX("Level xx", 1000, 20, new EnemyDefinition[] {EnemyDefinition.EASY}),
  SEVEN("Level werwer", 1000, 20, new EnemyDefinition[] {EnemyDefinition.EASY}),
  EIGHT("Level :)", 1000, 20, new EnemyDefinition[] {EnemyDefinition.EASY}),
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