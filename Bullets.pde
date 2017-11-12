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
    if (bulletDefinition.bulletType == BulletType.SPREAD) { // add 2 more if spread at opposite angles
      bullets.add(new Bullet(angle + SPREAD_ANGLE, x, y, bulletDefinition));
      bullets.add(new Bullet(angle - SPREAD_ANGLE, x, y, bulletDefinition));
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