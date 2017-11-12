enum EnemyType {
  STANDARD,  // moves directly toward player
  RANDOM,    // changes direction randomly at set intervals, but sometimes moves directly at player
  ASTEROID,  // shoots across screen
  CIRCLES,   // circles player, getting closer and closer
  OSCIL,     // moves toward player in an oscillating sort of motion
  TELEPORT,  // moves toward player, but also teleports to a random position periodically
  CARRIER;   // moves toward player, spawns other enemies when killed
}

enum EnemyDefinition {
  
      //                 type          speed   hp   attack  size  reward
  EASY            (EnemyType.STANDARD,   75,    2,    1,     80,    1),
  REGULAR         (EnemyType.STANDARD,  100,    3,    2,     50,    2),
  BIGGIE          (EnemyType.STANDARD,   25,   20,    4,    150,    5),
  HUGE            (EnemyType.STANDARD,   20,   50,   10,    200,   10),
  FAST            (EnemyType.STANDARD,  300,    1,    2,     30,    5),
  
  RANDOM1         (  EnemyType.RANDOM,  100,    1,    1,     30,    3),
  RANDOM2         (  EnemyType.RANDOM,  200,    2,    2,     40,    4),
  BIGRAND         (  EnemyType.RANDOM,  100,   10,    5,    100,    5),
  
  ASTEROID        (EnemyType.ASTEROID,  500,    2,    3,     30,   10),
  BIGGEROID       (EnemyType.ASTEROID,  400,    5,    5,     80,   10),
  
  CIRCLES1        ( EnemyType.CIRCLES,   50,    1,    1,     50,    2),
  CIRCLES2        ( EnemyType.CIRCLES,  100,    2,    2,     30,    4),  
  
  OSCIL1          (   EnemyType.OSCIL,   50,    1,    1,     50,    4),
  OSCIL2          (   EnemyType.OSCIL,  100,    2,    2,     30,    7),
  
  TELEPORT        (EnemyType.TELEPORT,  150,    5,    5,     50,    7),
  
       //                                                                 type carried,            # carried
  REGULAR_CARRIER ( EnemyType.CARRIER,   25,    5,   10,    150,    5,    EnemyDefinition.REGULAR,     3),
  CIRCLES_CARRIER ( EnemyType.CARRIER,   25,    5,   10,    150,    5,   EnemyDefinition.CIRCLES1,     3),
  OSCIL_CARRIER   ( EnemyType.CARRIER,   25,    5,   10,    150,    5,     EnemyDefinition.OSCIL1,     3),
  
  ;
  
  
  EnemyType enemyType;
  float speed;
  int hp;
  int power;
  int size;
  int reward;
  
  EnemyDefinition carriedEnemy;
  int numberCarried;
   
  // constructor for non-carrier types
  private EnemyDefinition(EnemyType enemyType, float speed, int hp, int power, int size, int reward) {
    this.enemyType = enemyType;
    this.speed = speed;
    this.hp = hp;
    this.power = power;
    this.size = size;
    this.reward = reward;
  }
  
  // constructor for carrier types (extra last parameters for enemy type and number to spawn when this dies)
  private EnemyDefinition(EnemyType enemyType, float speed, int hp, int power, int size, int reward,
                          EnemyDefinition carriedEnemy, int numberCarried) {
    this.enemyType = enemyType;
    this.speed = speed;
    this.hp = hp;
    this.power = power;
    this.size = size;
    this.reward = reward;
    this.carriedEnemy = carriedEnemy;
    this.numberCarried = numberCarried;
  }
  
}