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

    switch(bulletDefinition.bulletType) {
      case SPREAD://intentional fallthrough so it draws 2 extra and standard bullet
        bullets.add(new StandardBullet(angle + SPREAD_ANGLE, x, y, bulletDefinition));
        bullets.add(new StandardBullet(angle - SPREAD_ANGLE, x, y, bulletDefinition));
      case STANDARD:
        bullets.add(new StandardBullet(angle, x, y, bulletDefinition));
        break;
      case GAS:
        bullets.add(new GasBullet(angle, x, y, bulletDefinition));
        break;
      case FREEZE:
        bullets.add(new FreezeBullet(angle, x, y, bulletDefinition));
        break;
      case DRAIN:
        bullets.add(new DrainBullet(angle, x, y, bulletDefinition));
        break;
    }
  }

  // 'run' the bullets, ie update their position, remove if dead, display if not
  // (loop backwards so deleting items doesn't mess it up)
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