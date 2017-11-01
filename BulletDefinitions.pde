enum BulletType {
  STANDARD, FREEZE, BOMB, GAS
}

enum BulletDefinition {
                      //type        size       speed        power    rate (bullets/sec)
  BASIC(BulletType.STANDARD,     5,          250,          1,        7),
  PEA ( BulletType.STANDARD,     2,          400,          1,        20),
  POWER(BulletType.STANDARD,     10,         150,          10,        2),
  
  GAS(BulletType.GAS,       50,            50,             .05,         1),
  
  
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