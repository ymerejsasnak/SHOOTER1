enum BulletType {
  STANDARD, FREEZE, GAS, SPREAD, DRAIN
}


enum BulletDefinition {
          //text desc,     type               size       speed        power         rate (ms between bullets)                   (for balancing, calc possible DPS)
  BASIC("BASIC SHOT",      BulletType.STANDARD,     6,          200,          1,        200),                                    // 1000 / 200 * 1 = 5
  PEA ("PEA SHOT",          BulletType.STANDARD,     2,          300,          .5,        40),                                    // 1000 / 40 * .5  = 12.5
  POWER("POWER SHOT",        BulletType.STANDARD,     10,         150,          10,        400),                                 // 1000 / 400 * 10 = 25
  BOMB("BOMB SHOT",        BulletType.STANDARD,       20,          75,         100,         2000),                                // 1000 / 2000 * 100 = 50
  
  SPREAD("SPREAD SHOT",      BulletType.SPREAD,     6,          200,          1,        300),
  
  DRAIN("DRAIN SHOT",      BulletType.DRAIN,     6,          200,          1,        400),   
  
  // for gas type, power is DPS since it doesn't 'die' upon hitting enemy                                                          (these harder to calc - dont die, speed matters)
  BUBBLE("GAS BUBBLE", BulletType.GAS,       50,            50,             10,         1000),                                    // 1000 / 1000 * 10 = 10 / 50 = .25
  SPRAY("GAS SPRAY",  BulletType.GAS,         15,            75,            5,          200),                                    // 1000 / 200  * 5 = 25 / 75 =   .33
  
  
  FREEZE ("FREEZE", BulletType.FREEZE,      10,               300,        0,          200),
  
  
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