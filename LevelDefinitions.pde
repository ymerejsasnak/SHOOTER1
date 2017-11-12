enum Level {
  //      text    spawnwait   max#          
  //                                      enemy list
  ONE  ( "Level 1",   1000,    20, 
        new EnemyDefinition[] {EnemyDefinition.EASY,
                               EnemyDefinition.REGULAR}),
        
  TWO  ( "Level 2",   1000,    20, 
        new EnemyDefinition[] {EnemyDefinition.REGULAR,
                               EnemyDefinition.CIRCLES1}),
  
  THREE( "Level 3",   1000,    20,
        new EnemyDefinition[] {EnemyDefinition.REGULAR,
                               EnemyDefinition.REGULAR,
                               EnemyDefinition.BIGGIE,
                               EnemyDefinition.BIGRAND}),
                               
  FOUR ( "Level 4",    900,    30, 
        new EnemyDefinition[] {EnemyDefinition.CIRCLES2,
                               EnemyDefinition.CIRCLES1,
                               EnemyDefinition.ASTEROID}),
                               
  FIVE ( "Level 5",    800,    30, 
        new EnemyDefinition[] {EnemyDefinition.CIRCLES2,
                               EnemyDefinition.OSCIL2, 
                               EnemyDefinition.RANDOM1, 
                               EnemyDefinition.BIGGEROID}),
                               
  SIX  ( "Level 6",   1200,    10, 
        new EnemyDefinition[] {EnemyDefinition.HUGE,
                               EnemyDefinition.ASTEROID}),
                               
  SEVEN( "Level 7",    600,    40, 
        new EnemyDefinition[] {EnemyDefinition.RANDOM2,
                               EnemyDefinition.FAST}),
                               
  EIGHT( "Level 8",    500,    50, 
        new EnemyDefinition[] {EnemyDefinition.FAST,
                               EnemyDefinition.ASTEROID,
                               EnemyDefinition.OSCIL2}),
                               
  NINE ( "Level 9",    900,    10, 
        new EnemyDefinition[] {EnemyDefinition.TELEPORT,
                               EnemyDefinition.TELEPORT,
                               EnemyDefinition.HUGE}),
        
  TEN  ("Level 10",   1000,    30, 
        new EnemyDefinition[] {EnemyDefinition.REGULAR_CARRIER,
                               EnemyDefinition.CIRCLES_CARRIER,
                               EnemyDefinition.OSCIL_CARRIER}),
  
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