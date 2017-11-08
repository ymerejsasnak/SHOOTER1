final color BULLET_WHITE = color(200);
final color GAS_GREEN = color(0, 100, 0, 50);
final color FREEZE_BLUE = color(100, 100, 250, 200);


/*
  CLASS TO STORE AND CONTROL BULLET OBJECTS AS A WHOLE
 */
class Bullets {

  ArrayList<Bullet> bullets;
  
  Bullets() {

    bullets = new ArrayList<Bullet>();
   
  }

  // create a new bullet
  void addBullet(float angle, float x, float y, BulletDefinition bulletDefinition) {

    bullets.add(new Bullet(angle, x, y, bulletDefinition));
    if (bulletDefinition.bulletType == BulletType.SPREAD) {
      bullets.add(new Bullet(angle + SPREAD_ANGLE, x, y, bulletDefinition));
      bullets.add(new Bullet(angle - SPREAD_ANGLE, x, y, bulletDefinition));
    }
  }

  // 'run' the bullets, ie update their position, remove if dead, display if not
  void run() {

    for (int b = bullets.size() - 1; b >= 0; b--) {

      Bullet bullet = bullets.get(b);
      bullet.update();
      if (bullet.dead) { 
        bullets.remove(b);
      } else {
        bullet.display();
      }
    }
  }
}


/*
  CLASS FOR INDIVIDUAL BULLETS
 */
class Bullet {

  // ingame stats needed to run bullets
  float x, y;
  float angle;
  boolean dead = false;

  // stats for bullets that will need to be loaded depending on type...
  float power;
  float speed; //  pixels per second
  int bulletSize;
  BulletType bulletType;
  
  // ...and also colors
  color bFill;

  Bullet(float _angle, float _x, float _y, BulletDefinition bulletDefinition) {

    angle = _angle;
    
    x = _x;
    y = _y;
    
    this.bulletType = bulletDefinition.bulletType;
    this.bulletSize = bulletDefinition.size;
    this.speed = bulletDefinition.speed;
    this.power = bulletDefinition.power;
    
    // and set color based on type (also add a bit of randomness to gas angle/size)
    switch (bulletType) {
      case STANDARD:
      case SPREAD:
        this.bFill = BULLET_WHITE;
        break;
      case GAS:
        this.bFill = GAS_GREEN;
        this.angle += randomGaussian() * 0.5;
        this.bulletSize += randomGaussian() * 5;
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
      dead = (x > width + bulletSize || x < 0 - bulletSize ||
        y > height + bulletSize || y < 0 - bulletSize);
    }
  }

  // called from enemy class if bullet and enemy collide
  void hit() {
    if (bulletType != BulletType.GAS) {  // gas doesn't 'die' upon hitting enemy
      dead = true;
    }
  }

  // draw the bullet
  void display() {
    
    fill(bFill);
    noStroke();

    ellipse(x, y, bulletSize, bulletSize);
  }
}