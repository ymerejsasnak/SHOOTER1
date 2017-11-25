enum Level {
  //      text    spawnwait   max#          
  //                                      enemy list
  ONE  ( "Level 1",   1000,    3, 
        new EnemyDefinition[] {EnemyDefinition.EASY,
                               EnemyDefinition.REGULAR,
                               EnemyDefinition.BACKFORTH1,
                               EnemyDefinition.RANDOM1}),
        
  TWO  ( "Level 2",   900,    3, 
        new EnemyDefinition[] {EnemyDefinition.BIGGIE,
                               EnemyDefinition.CIRCLES1,
                               EnemyDefinition.BIGRAND,
                               EnemyDefinition.RANDOM2}),
  
  THREE( "Level 3",   100,    25,
        new EnemyDefinition[] {EnemyDefinition.SWARMER,
                               EnemyDefinition.SWARMER,
                               EnemyDefinition.SWARMER,
                               EnemyDefinition.SWARMER,
                               EnemyDefinition.SWARMER,
                               EnemyDefinition.SWARMER,
                               EnemyDefinition.SWARMER,
                               EnemyDefinition.BACKFORTH1,
                               EnemyDefinition.ASTEROID}),
                               
  FOUR ( "Level 4",    800,    5, 
        new EnemyDefinition[] {EnemyDefinition.CIRCLES2,
                               EnemyDefinition.OSCIL1,
                               EnemyDefinition.TELEPORT,
                               EnemyDefinition.RANDOM2}),
                               
  FIVE ( "Level 5",    600,    5, 
        new EnemyDefinition[] {EnemyDefinition.BIGGEROID,
                               EnemyDefinition.HUGE, 
                               EnemyDefinition.FAST,
                               EnemyDefinition.FAST,
                               EnemyDefinition.FAST,
                               EnemyDefinition.OSCIL2}),
                               
  SIX  ( "Level 6",   700,    3, 
        new EnemyDefinition[] {EnemyDefinition.REGULAR_CARRIER,
                               EnemyDefinition.CIRCLES_CARRIER,
                               EnemyDefinition.OSCIL_CARRIER,
                               EnemyDefinition.CARRIER_CARRIER}),
                               
  
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