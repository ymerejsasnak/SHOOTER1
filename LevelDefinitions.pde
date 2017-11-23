enum Level {
  //      text    spawnwait   max#          
  //                                      enemy list
  ONE  ( "Level 1",   500,    2, 
        new EnemyDefinition[] {EnemyDefinition.EASY,
                               EnemyDefinition.REGULAR}),
        
  TWO  ( "Level 2",   1000,    2, 
        new EnemyDefinition[] {EnemyDefinition.REGULAR,
                               EnemyDefinition.CIRCLES1}),
  
  THREE( "Level 3",   1000,    2,
        new EnemyDefinition[] {EnemyDefinition.REGULAR,
                               EnemyDefinition.REGULAR,
                               EnemyDefinition.REGULAR,
                               EnemyDefinition.REGULAR,
                               EnemyDefinition.BIGGIE,
                               EnemyDefinition.RANDOM1,
                               EnemyDefinition.RANDOM1}),
                               
  FOUR ( "Level 4",    100,    25, 
        new EnemyDefinition[] {EnemyDefinition.SWARMER}),
                               
  FIVE ( "Level 5",    800,    3, 
        new EnemyDefinition[] {EnemyDefinition.CIRCLES2,
                               EnemyDefinition.OSCIL2, 
                               EnemyDefinition.BIGRAND,
                               EnemyDefinition.BACKFORTH1}),
                               
  SIX  ( "Level 6",   100,    3, 
        new EnemyDefinition[] {EnemyDefinition.HUGE,
                               EnemyDefinition.BIGGEROID,
                               EnemyDefinition.BIGGIE,
                               EnemyDefinition.ASTEROID}),
                               
  SEVEN( "Level 7",    100,    3, 
        new EnemyDefinition[] {EnemyDefinition.RANDOM2,
                               EnemyDefinition.FAST,
                               EnemyDefinition.FAST,
                               EnemyDefinition.FAST}),
                               
  EIGHT( "Level 8",    200,    3, 
        new EnemyDefinition[] {EnemyDefinition.FAST,
                               EnemyDefinition.ASTEROID,
                               EnemyDefinition.OSCIL2}),
                               
  NINE ( "Level 9",    500,    5, 
        new EnemyDefinition[] {EnemyDefinition.TELEPORT,
                               EnemyDefinition.TELEPORT,
                               EnemyDefinition.HUGE,
                               EnemyDefinition.REGULAR_CARRIER,
                               EnemyDefinition.FAST}),
        
  TEN  ("Level 10",   1000,    2, 
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