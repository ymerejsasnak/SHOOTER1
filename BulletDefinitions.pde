enum BulletType {
  STANDARD, FREEZE, GAS
}


enum BulletDefinition {
                      //type        size       speed        power    rate (bullets/sec)   
  BASIC(BulletType.STANDARD,     6,          200,          1,        7),
  PEA ( BulletType.STANDARD,     2,          300,          1,        50),
  POWER(BulletType.STANDARD,     10,         150,          10,        2),
  
  //need to time this, (currently based on frames)
  GAS(BulletType.GAS,       50,            50,             .05,         1),
  
  //add timer to this so enemies eventually unfreeze
  FREEZE (BulletType.FREEZE,    10,    300,      0,          5),
  
  
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