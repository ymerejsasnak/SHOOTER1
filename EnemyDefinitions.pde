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
  REGULAR         (EnemyType.STANDARD,  100,    3,    1,     50,    2),
  BIGGIE          (EnemyType.STANDARD,   25,   15,    4,    150,    5),
  HUGE            (EnemyType.STANDARD,   20,   30,    9,    200,    7),
  FAST            (EnemyType.STANDARD,  300,    1,    2,     30,    4),
  
  RANDOM1         (  EnemyType.RANDOM,   75,    1,    2,     50,    2),
  RANDOM2         (  EnemyType.RANDOM,  150,    2,    3,     30,    3),
  BIGRAND         (  EnemyType.RANDOM,  100,   10,    5,    100,    2),
  
  ASTEROID        (EnemyType.ASTEROID,  500,    2,    3,     30,   10),
  BIGGEROID       (EnemyType.ASTEROID,  400,    5,    5,     80,   10),
  
  CIRCLES1        ( EnemyType.CIRCLES,   50,    1,    1,     50,    2),
  CIRCLES2        ( EnemyType.CIRCLES,  100,    2,    3,     30,    5),  
  
  OSCIL1          (   EnemyType.OSCIL,   50,    1,    1,     50,    3),
  OSCIL2          (   EnemyType.OSCIL,  100,    2,    3,     30,    5),
  
  TELEPORT        (EnemyType.TELEPORT,  150,    5,    4,     50,    5),
  
       //                                                                 type carried,            # carried
  REGULAR_CARRIER ( EnemyType.CARRIER,   25,    5,    5,    150,    3,    EnemyDefinition.REGULAR,     3),
  CIRCLES_CARRIER ( EnemyType.CARRIER,   25,    5,    5,    150,    3,   EnemyDefinition.CIRCLES1,     3),
  OSCIL_CARRIER   ( EnemyType.CARRIER,   25,    5,    5,    150,    3,     EnemyDefinition.OSCIL1,     3),
  
  CARRIER_CARRIER ( EnemyType.CARRIER,   25,    5,    5,    200,    3,    EnemyDefinition.REGULAR_CARRIER,  3),
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