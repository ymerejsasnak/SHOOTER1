/*
  CLASS TO BUILD 'SELECTOR' (cycle through available options on click) BOXES FOR SELECTION SCREEN
 */
class Selector {

  int selectorX, selectorY;
  int selectorSize;
  String selectorText;
  int currentIndex = 0;
  int totalOptions;
  
  
  
  Selector(int x, int y) {
    
    selectorX = x;
    selectorY = y;
    selectorSize = SELECTOR_SIZE;
  }
  
  
  // click to go to next available option (IF any options, ie total > 0)
  void cycle() {
    
    if (totalOptions > 0) {
      currentIndex = (currentIndex + 1) % totalOptions;
    }
    
  }
  
  
  // submethod to make above switch statement non-repetetive
  void cycleTurret(int turretIndex, ArrayList<BulletDefinition> bulletSelections) {
    player.selectedBulletType[turretIndex] = bulletSelections.get(currentIndex);
    player.turretTimers.set(turretIndex, new Timer(player.selectedBulletType[turretIndex].rate));
    selectorText = bulletSelections.get(currentIndex).text;   
  }
  
  
  // fill selectors with available options (used whenever going to select screen)
  void update() {
       
    //done in subclasses...but there is a generic way to do it if we make an ArrayList<> selections with a variable type 
      //note : currently no call to super in any of the subclasses, so add that if doing stuff up here
  }
  
  
  // helpful bit to make above switch statement non-repetetive (good example of a method that should be private?)
  ArrayList<BulletDefinition> loadBullets() {
    ArrayList<BulletDefinition> bulletSelections = new ArrayList<BulletDefinition>();
    bulletSelections.add(BulletDefinition.BASIC);
    bulletSelections.addAll(player.unlockedBullets);
    totalOptions = bulletSelections.size();
    selectorText = bulletSelections.get(currentIndex).text;
    return bulletSelections;
  }
  
  
  // display selectors (these settings will likely change to make it look better eventually)
  void display() {
    fill(TEXT_COLOR);
    textSize(SELECTOR_TEXT_SIZE);
    noFill();
    stroke(255);
    strokeWeight(2);
    rect(selectorX, selectorY, SELECTOR_SIZE, SELECTOR_SIZE, 10);
    
    // set to default text, only change IF there are in fact options available
    String text = "-";
    if (selectorText != null) {
      text = selectorText;
    }
    text(text, selectorX, selectorY + SELECTOR_TEXT_OFFSET);
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


class LevelSelector extends Selector {
  ArrayList<Level> levelSelections = new ArrayList<Level>();
  
  LevelSelector(){
    super(SELECTOR_SIZE * 3/2, height - SELECTOR_SIZE * 2);
  }
  
  void cycle() {
    super.cycle();
    game.currentLevel = currentIndex + 1;
    game.currentLevelDefinition = levelSelections.get(currentIndex);
    selectorText = levelSelections.get(currentIndex).text + "\n" + player.highScores[currentIndex];
  }
  
  void update() {
    levelSelections = new ArrayList<Level>();
    for (int i = 0; i < player.highestLevelUnlocked; i++) {
      levelSelections.add(Level.values()[i]);
    }
    totalOptions = levelSelections.size();
    selectorText = levelSelections.get(currentIndex).text  + "\n" + player.highScores[currentIndex];
  }
  
}

class Turret1Selector extends Selector {
  ArrayList<BulletDefinition> bulletSelections = new ArrayList<BulletDefinition>();
  Turret1Selector(){
    super(width * 1/3, SELECTOR_SIZE);
  }
  
  void cycle() {
    super.cycle();
    cycleTurret(0, bulletSelections);
  }
  
  void update() {
    bulletSelections = loadBullets();
  }
         
}

class Turret2Selector extends Selector {
  ArrayList<BulletDefinition> bulletSelections = new ArrayList<BulletDefinition>();
  Turret2Selector(){
    super(width * 1/3 - SELECTOR_SIZE, SELECTOR_SIZE * 3/2);
  }
  
  void cycle() {
    super.cycle();
    if (player.turret2) {
      cycleTurret(1, bulletSelections);
    }
  }
  
  void update() {
    if (player.turret2) {
      bulletSelections = loadBullets();
    }
  }
  
}

class Turret3Selector extends Selector {
  ArrayList<BulletDefinition> bulletSelections = new ArrayList<BulletDefinition>();
  Turret3Selector(){
    super(width * 1/3 + SELECTOR_SIZE, SELECTOR_SIZE * 3/2);
  }
  
  void cycle() {
    super.cycle();
    if (player.turret3) {
      cycleTurret(2, bulletSelections);
    }
  }
  
  void update() {
    if (player.turret3) {
      bulletSelections = loadBullets();
    }
  }
  
}

class DroneSelector extends Selector {
  
  ArrayList<DroneDefinition> droneSelections = new ArrayList<DroneDefinition>();
  DroneSelector(){
    super(width * 2/3, SELECTOR_SIZE * 3/2);
  }
  
  void cycle() {
    super.cycle();
    
    if (player.unlockedDrones.size() > 0) {
      setDrone();      
      selectorText = droneSelections.get(currentIndex).text;
    }
  }
  
  void update() {
    if (player.unlockedDrones.size() > 0) {
      droneSelections = player.unlockedDrones;
      totalOptions = droneSelections.size();
      selectorText = droneSelections.get(currentIndex).text;
      setDrone();
    } 
  }
  
  
  void setDrone() {
    switch (droneSelections.get(currentIndex)) {
        case ATTACKER:
        case DEFENDER:
          drone = new DamageDrone(droneSelections.get(currentIndex));
          break;
        case FREEZER:
        case BIG_FREEZER:
          drone = new FreezeDrone(droneSelections.get(currentIndex));
          break;
        case VAPORIZER:
          drone = new VaporizeDrone(droneSelections.get(currentIndex));
          break;
      }
  }
  
  
}




        
  