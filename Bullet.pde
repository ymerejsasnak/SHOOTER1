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
    this.power = int(bulletDefinition.power * player.bulletPowerMultiplier);
    
    // and set color based on type (also add a bit of randomness to gas angle/size)
    switch (bulletType) {
      case STANDARD:
      case SPREAD:
        this.bFill = BULLET_WHITE;
        break;
      case DRAIN:
        this.bFill = DRAIN_YELLOW;
        break;
      case GAS:
        this.bFill = GAS_GREEN;
        this.angle += randomGaussian() * GAS_ANGLE_RANDOMNESS;
        this.bulletSize += randomGaussian() * GAS_SIZE_RANDOMNESS;
        break;
      case FREEZE:
        this.bFill = FREEZE_BLUE;
        break;
    }
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

  // called from enemy class if bullet and enemy collide
  void hitEnemy() {
    if (bulletType != BulletType.GAS) {  // gas doesn't 'die' upon hitting enemy
      dead = true;
    }
    if (bulletType == BulletType.DRAIN) {
      player.hp += power;
      player.hp = min(player.hp, player.maxHP);
    }
  }

  // draw the bullet
  void display() {
    
    fill(bFill);
    noStroke();

    ellipse(x, y, bulletSize, bulletSize);
  }
}