/*
  CLASS TO STORE AND CONTROL BULLET OBJECTS AS A WHOLE
 */
class Bullets {

  ArrayList<Bullet> bullets;
  BulletDefinition bulletDefinition;

  Bullets() {

    bullets = new ArrayList<Bullet>();
    bulletDefinition = player.bulletDefinition;
  }

  // create a new bullet
  void addBullet(float angle, float x, float y) {

    bullets.add(new Bullet(angle, x, y, bulletDefinition.bulletType, bulletDefinition.size, bulletDefinition.speed, bulletDefinition.power));
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
  color bFill = color(200, 200, 180);
  color bStroke = color(255, 255, 200);
  int bWeight = 2;

  Bullet(float _angle, float _x, float _y, BulletType bulletType, int bulletSize, int speed, float power) {

    angle = _angle;
    x = _x;
    y = _y;
    
    this.bulletType = bulletType;
    this.bulletSize = bulletSize;
    this.speed = speed;
    this.power = power;
    
    if (bulletType == BulletType.GAS) {
      bFill = color(100, 200, 100, 50);
      bWeight = 0;
    }
  }

  // update position of bullet and check if it goes off screen
  void update() {

    x += cos(angle) * speed * time.getDelta();
    y += sin(angle) * speed * time.getDelta();

    if (!dead) {
      dead = (x > width + bulletSize || x < 0 - bulletSize ||
        y > height + bulletSize || y < 0 - bulletSize);
    }
  }

  // called from enemy class if bullet and enemy collide
  void hit() {
    if (bulletType != BulletType.GAS) {  // gas doesn't 'die' upon hitting enemy (should probably make a timer for damage)
      dead = true;
    }
  }

  // draw the bullet
  void display() {
    fill(bFill);
    strokeWeight(bWeight);
    stroke(bStroke);

    ellipse(x, y, bulletSize, bulletSize);
  }
}