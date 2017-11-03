//currently all are temporary definitions for testing purposes

final int LEVEL_ONE_SPAWN_RATE = 2; // enemies spawned per second
final int LEVEL_ONE_MAX_ENEMIES = 20; // maximum allowable enemies 'on screen'
final EnemyDefinition[] LEVEL_ONE = new EnemyDefinition[]{
  EnemyDefinition.EASY, 
  EnemyDefinition.RANDOM
};

final int LEVEL_TWO_SPAWN_RATE = 3; // enemies spawned per second
final int LEVEL_TWO_MAX_ENEMIES = 20; // maximum allowable enemies 'on screen'
final EnemyDefinition[] LEVEL_TWO = new EnemyDefinition[]{
  EnemyDefinition.EASY, 
  EnemyDefinition.REGULAR, 
  EnemyDefinition.RANDOM,
  EnemyDefinition.OSCIL,
  EnemyDefinition.CIRCLES,
  EnemyDefinition.BIGGIE
};

final int LEVEL_THREE_SPAWN_RATE = 5; // enemies spawned per second
final int LEVEL_THREE_MAX_ENEMIES = 30; // maximum allowable enemies 'on screen'
final EnemyDefinition[] LEVEL_THREE = new EnemyDefinition[]{
  EnemyDefinition.ASTEROID
};