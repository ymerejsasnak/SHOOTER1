enum MovementType {
  STANDARD, RANDOM, ASTEROID, CIRCLES, OSCIL;
}

enum EnemyDefinition {
  
            //movement type,    speed(pps), hp,  attack  size,  reward
  EASY   (MovementType.STANDARD,    75,     2,    1,    80,    1),
  REGULAR(MovementType.STANDARD,    100,    3,    2,    50,    2),
  BIGGIE (MovementType.STANDARD,    25,    20,    4,   150,    5),
  HUGE   (MovementType.STANDARD,    20,    50,   10,   200,   10),
  FAST   (MovementType.STANDARD,    300,    1,    2,    75,     5),
  
  RANDOM1(MovementType.RANDOM,      100,    1,    1,    30,    3),
  RANDOM2(MovementType.RANDOM,      200,    2,    2,    40,    4),
  BIGRAND(MovementType.RANDOM,      100,    10,   5,    100,   5),
  
  ASTEROID(MovementType.ASTEROID,   500,    2,    3,    30,    10),
  BIGGEROID(MovementType.ASTEROID,  400,    5,    5,    80,   10),
  
  CIRCLES1(MovementType.CIRCLES,    50,   1,  1,      50,       2),
  CIRCLES2(MovementType.CIRCLES,    100,  2,  2,      30,       4),  
  
  OSCIL1( MovementType.OSCIL,    50,   1,   1,   50,           4),
  OSCIL2(MovementType.OSCIL,     100,  2,   2,   30,           7),
  ;
  
  
  
  
  MovementType movementType;
  float speed;
  int hp;
  int power;
  int size;
  int reward;
   
  private EnemyDefinition(MovementType movementType, float speed, int hp, int power, int size, int reward) {
    this.movementType = movementType;
    this.speed = speed;
    this.hp = hp;
    this.power = power;
    this.size = size;
    this.reward = reward;
  }
  
}