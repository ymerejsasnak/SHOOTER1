/*
  CLASS TO REPRESENT PLAYER
*/
class Player {
  
  int x = width / 2;
  int y = height / 2;
  int size = 50;
  float radius = size/2;
  
  float angle;
  float gunX, gunY;
  
  int hp = 20;
  int maxHP = 20;
  boolean dead = false;
  
  int fireRate; // bullets per second
  int lastFireTime;
  
  color fill = color(50, 100, 200);
  color stroke = color(40, 50, 250);
  int weight = 5;
  
  BulletDefinition bulletDefinition;
  
  Player(BulletDefinition bulletDefinition) {
    this.bulletDefinition = bulletDefinition; // to send to bullets class
    fireRate = bulletDefinition.rate;
  }
  
  // get aiming angle and gun drawing coordinates
  void update() {
    
    angle = atan2(mouseY - y, mouseX - x);
    gunX = x + cos(angle) * (radius + GUN_LENGTH);
    gunY = y + sin(angle) * (radius + GUN_LENGTH);
    
  }
  
  // shoot a bullet at given angle, timed based on millisecs
  void shoot() {
    
    // convert 'bullets per second' to 'milliseconds between bullets'  
    int wait = 1000 / fireRate;
    
    if (wait <= millis() - lastFireTime) {
      bullets.addBullet(angle, gunX, gunY);
      lastFireTime = millis();
    }
    
  }
  
  // called from enemy class when it hits the player, reduce HP by enemy power
  void hit(int ePower) {
    
    hp -= ePower;
    if (hp <= 0) {
      dead = true;
    }
    
  }
     
  // draw player w/ gun(s)
  void display() {
    
    fill(fill);
    strokeWeight(weight);
    stroke(stroke);
    
    line(x, y, gunX, gunY);
    ellipse(x, y, size, size);
    
    // show life circle (same code as in enemy class....not very DRY....)
    fill((float)hp / (float)maxHP * 255);
    ellipse(x, y, size/2, size/2);
       
    
  }
}