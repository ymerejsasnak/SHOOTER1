/*
  CLASS FOR INDIVIDUAL BULLETS
 */
 
class Bullet {

  // ingame stats needed to run bullets
  float x, y;
  float angle;
  boolean dead = false;

  // stats (and color) for bullets that will need to be loaded depending on type...
  float power;
  float speed; //  pixels per second
  int bulletSize;
  BulletType bulletType;
  color bFill;

  Bullet(float angle, float x, float y, BulletDefinition bulletDefinition) {

    this.angle = angle;
    this.x = x;
    this.y = y;
    
    this.bulletType = bulletDefinition.bulletType;
    this.bulletSize = int(bulletDefinition.size * player.bulletSizeMultiplier);
    this.speed = bulletDefinition.speed;
    this.power = bulletDefinition.power * player.bulletPowerMultiplier;
    
  }

  // update position of bullet and check if it goes off screen
  void update() {
    
    x += cos(angle) * speed * deltaTime.getDelta();
    y += sin(angle) * speed * deltaTime.getDelta();

    if (!dead) {
      dead = (x > width + bulletSize/2 || x < 0 - bulletSize/2 ||
        y > height + bulletSize/2 || y < 0 - bulletSize/2);
    }
  }


  boolean freezeEnemy() {
    return false;  
  }
  
  
  float damageEnemy() {
    dead = true;
    return power;
  }


  // draw the bullet
  void display() {
    
    fill(bFill);
    noStroke();

    ellipse(x, y, bulletSize, bulletSize);
  }
}


class Standard extends Bullet {
  
  Standard(float angle, float x, float y, BulletDefinition bulletDefinition) {
    super(angle, x, y, bulletDefinition);
    this.bFill = BULLET_WHITE;
  }
  
}


class Gas extends Bullet {
  
 Gas(float angle, float x, float y, BulletDefinition bulletDefinition){
   super(angle, x, y, bulletDefinition);
   this.bFill = GAS_GREEN;
   this.angle += randomGaussian() * GAS_ANGLE_RANDOMNESS;
   this.bulletSize += randomGaussian() * GAS_SIZE_RANDOMNESS;
 }
 
 float damageEnemy() {
   dead = false; // gas bullet doesn't 'die' upon hitting enemy
   return super.damageEnemy() * deltaTime.getDelta();
 }
 
}


class Freeze extends Bullet {
  
 Freeze(float angle, float x, float y, BulletDefinition bulletDefinition) {
    super(angle, x, y, bulletDefinition); 
    this.bFill = FREEZE_BLUE;
 }
 
 boolean freezeEnemy() {
   return true;
 }
 
}


class Drain extends Bullet {
  
  Drain(float angle, float x, float y, BulletDefinition bulletDefinition) {
    super(angle, x, y, bulletDefinition);
    this.bFill = DRAIN_YELLOW;
  }
  
  float damageEnemy() {
    player.hp += power;
    player.hp = min(player.hp, player.maxHP);
    return super.damageEnemy();
  }
}