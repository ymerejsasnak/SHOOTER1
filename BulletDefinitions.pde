enum BulletType {
  STANDARD, FREEZE, GAS, SPREAD, DRAIN
}


enum BulletDefinition {
  // note: for gas type, power is DPS since it doesn't 'die' upon hitting enemy     
  
  //           text              type           size  speed  power  rate (ms between bullets)                
  BASIC  ( "BASIC SHOT",  BulletType.STANDARD,    6,   200,     1,   200),        
  
  POWER  ( "POWER SHOT",  BulletType.STANDARD,   10,   150,     5,   400),     
  SPRAY  (  "GAS SPRAY",       BulletType.GAS,   15,    75,     5,   200),   
  
  PEA    (   "PEA SHOT",  BulletType.STANDARD,    2,   300,    .5,    40),    
  BOMB   (  "BOMB SHOT",  BulletType.STANDARD,   20,    75,    20,  1000),    
  BUBBLE ( "GAS BUBBLE",       BulletType.GAS,   50,    50,    10,  1000),  
  
  FREEZE (     "FREEZE",    BulletType.FREEZE,   10,   300,     0,   200),
  DRAIN  ( "DRAIN SHOT",     BulletType.DRAIN,    6,   200,     1,   400),   
  SPREAD ("SPREAD SHOT",    BulletType.SPREAD,    3,   200,    .5,   300),                                              
 
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