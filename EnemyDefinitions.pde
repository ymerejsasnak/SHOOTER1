enum MovementType {
  STANDARD, RANDOM, ASTEROID, CIRCLES, OSCIL;
}

enum EnemyDefinition {
  
            //movement type,    speed(pps), hp,  attack  size,  reward
  EASY   (MovementType.STANDARD,    75,     2,    1,    80,    1),
  REGULAR(MovementType.STANDARD,    100,    3,    2,    50,    2),
  BIGGIE (MovementType.STANDARD,    25,    10,    4,   150,    5),
  
  // basic versions for writing movement code
  RANDOM (MovementType.RANDOM,      200,    1,    1,    30,    3),
  
  ASTEROID(MovementType.ASTEROID,   500,    2,    3,    30,    10),
  
  CIRCLES (MovementType.CIRCLES,    50,   1,  1,   50,         2),
  
  OSCIL ( MovementType.OSCIL,    50,   1,   1,   50,           4),
  
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