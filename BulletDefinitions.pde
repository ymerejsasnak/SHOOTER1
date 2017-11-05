enum BulletType {
  STANDARD, FREEZE, GAS
}


enum BulletDefinition {
          //text desc,     type        size       speed        power    rate (ms between bullets) 
  BASIC("BASIC",      BulletType.STANDARD,     6,          200,          1,        150),
  PEA ("PEA",          BulletType.STANDARD,     2,          300,          1,        20),
  POWER("POWER",        BulletType.STANDARD,     10,         150,          10,        500),
  
  // for gas type, power is DPS since it doesn't 'die' upon hitting enemy
  GAS("GAS", BulletType.GAS,       50,            50,             5,         1000),
  
  //add timer to this so enemies eventually unfreeze
  FREEZE ("FREEZE", BulletType.FREEZE,    10,    300,      0,          200),
  
  
  ;
  
  String text;
  BulletType bulletType;
  int size;
  int speed;
  float power;
  int rate;
  
  private BulletDefinition(String text, BulletType bulletType, int size, int speed, float power, int rate) {
    this.text = text;
    this.bulletType = bulletType;
    this.size = size;
    this.speed = speed;
    this.power = power;
    this.rate = rate;
    
    
  }
}