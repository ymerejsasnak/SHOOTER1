enum BulletType {
  STANDARD, FREEZE, GAS
}


enum BulletDefinition {
                      //type        size       speed        power    rate (ms between bullets) 
  BASIC(BulletType.STANDARD,     6,          200,          1,        150),
  PEA ( BulletType.STANDARD,     2,          300,          1,        20),
  POWER(BulletType.STANDARD,     10,         150,          10,        500),
  
  // for gas type, power is DPS since it doesn't 'die' upon hitting enemy
  GAS(BulletType.GAS,       50,            50,             1,         1000),
  
  //add timer to this so enemies eventually unfreeze
  FREEZE (BulletType.FREEZE,    10,    300,      0,          200),
  
  
  ;
  
  BulletType bulletType;
  int size;
  int speed;
  float power;
  int rate;
  
  private BulletDefinition(BulletType bulletType, int size, int speed, float power, int rate) {
    this.bulletType = bulletType;
    this.size = size;
    this.speed = speed;
    this.power = power;
    this.rate = rate;
    
    
  }
}