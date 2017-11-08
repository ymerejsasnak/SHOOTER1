// enum to identify button pressed
enum SelectorID {
  // default value
  NONE, 
  LEVEL,
  TURRET_ONE, TURRET_TWO, TURRET_THREE, TURRET_FOUR,
  DRONE_ONE, DRONE_TWO,
  ;
}

/*
  CLASS TO BUILD 'SELECTOR' (cycle through available options on click) BOX FOR SELECTION SCREEN
 */
class Selector {

  int selectorX, selectorY;
  int selectorSize;
  String selectorText;
  SelectorID id;
  int currentIndex = 0;
  int totalOptions;
  
  ArrayList<Level> levelSelections = new ArrayList<Level>();
  ArrayList<BulletDefinition> bulletSelections = new ArrayList<BulletDefinition>();
  ArrayList<DroneDefinition> droneSelections = new ArrayList<DroneDefinition>();
  
  Selector(SelectorID _id, int x, int y) {
    
    id = _id;
    selectorX = x;
    selectorY = y;
    selectorSize = SELECTOR_SIZE;
    
    if (id == SelectorID.LEVEL) {
      for (Level level: Level.values()) {
        levelSelections.add(level);
      }
      totalOptions = levelSelections.size();
      selectorText = levelSelections.get(currentIndex).text;
    
    } else if (id == SelectorID.TURRET_ONE || id == SelectorID.TURRET_TWO || 
               id == SelectorID.TURRET_THREE || id == SelectorID.TURRET_FOUR){
      for (BulletDefinition bullet: BulletDefinition.values()) {
        bulletSelections.add(bullet);
      }
      totalOptions = bulletSelections.size();
      selectorText = bulletSelections.get(currentIndex).text;
    
    } else {
      for (DroneDefinition drone: DroneDefinition.values()) {
        droneSelections.add(drone); 
      }
      totalOptions = droneSelections.size();
      selectorText = droneSelections.get(currentIndex).text;
    }
    
  
  }
  
  void cycle() {
    currentIndex = (currentIndex + 1) % totalOptions;
    switch(id) {
      case NONE:
        break;
      case LEVEL:
        game.currentLevel = levelSelections.get(currentIndex);
        selectorText = levelSelections.get(currentIndex).text;
        break;
      case TURRET_ONE:
        player.turretTypes[0] = bulletSelections.get(currentIndex);
        player.turretTimers.set(0, new Timer(player.turretTypes[0].rate));
        selectorText = bulletSelections.get(currentIndex).text;
        break;
      case TURRET_TWO:
        player.turretTypes[1] = bulletSelections.get(currentIndex);
        player.turretTimers.set(1, new Timer(player.turretTypes[1].rate));
        selectorText = bulletSelections.get(currentIndex).text;
        break;
      case TURRET_THREE:
        player.turretTypes[2] = bulletSelections.get(currentIndex);
        player.turretTimers.set(2, new Timer(player.turretTypes[2].rate));
        selectorText = bulletSelections.get(currentIndex).text;
        break;
      case TURRET_FOUR:
        player.turretTypes[3] = bulletSelections.get(currentIndex);
        player.turretTimers.set(3, new Timer(player.turretTypes[3].rate));
        selectorText = bulletSelections.get(currentIndex).text;
        break;
      case DRONE_ONE:
        drones.setDroneOne(droneSelections.get(currentIndex));
        selectorText = droneSelections.get(currentIndex).text;
        break;
      case DRONE_TWO:
        drones.setDroneTwo(droneSelections.get(currentIndex));
        selectorText = droneSelections.get(currentIndex).text;
        break;
    }
    
          
      
  }
  
  void display() {
    fill(TEXT_COLOR);
    textSize(SELECTOR_TEXT_SIZE);
    noFill();
    stroke(255);
    strokeWeight(2);
    rect(selectorX, selectorY, SELECTOR_SIZE, SELECTOR_SIZE, 10);
    text(selectorText, selectorX, selectorY + SELECTOR_TEXT_OFFSET);
  }

  // determine if touch/click was in the bounds of the selector
  boolean clickCheck(int _mouseX, int _mouseY) {
    
    int half = selectorSize / 2;
    return _mouseX < selectorX + half &&
           _mouseX > selectorX - half &&
           _mouseY < selectorY + half &&
           _mouseY > selectorY - half;
  }
}