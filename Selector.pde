// enum to identify selector clicked
enum SelectorID {
  NONE, // (could have just checked for null?)
  LEVEL,
  TURRET_ONE, TURRET_TWO, TURRET_THREE, TURRET_FOUR,
  DRONE_ONE, DRONE_TWO,
  ;
}

/*
  CLASS TO BUILD 'SELECTOR' (cycle through available options on click) BOXES FOR SELECTION SCREEN
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
  ArrayList<DroneDefinition> drone1Selections = new ArrayList<DroneDefinition>();
  ArrayList<DroneDefinition> drone2Selections = new ArrayList<DroneDefinition>();
  
  
  Selector(SelectorID _id, int x, int y) {
    
    id = _id;
    selectorX = x;
    selectorY = y;
    selectorSize = SELECTOR_SIZE;
  }
  
  
  // click to go to next available option (IF any options, ie total > 0)
  void cycle() {
    
    if (totalOptions > 0) {
      currentIndex = (currentIndex + 1) % totalOptions;
    }
    
    // act based on which was clicked (need to DRY drone bits in this and below)
    switch(id) {
      case NONE:
        break;
      case LEVEL:
        game.currentLevel = currentIndex + 1;
        game.currentLevelDefinition = levelSelections.get(currentIndex);
        selectorText = levelSelections.get(currentIndex).text + "\n" + player.highScores[currentIndex];
        break;
      case TURRET_ONE:
        cycleTurret(0);
        break;
      case TURRET_TWO:
        if (player.turret2) {
          cycleTurret(1);
        }
        break;
      case TURRET_THREE:
        if (player.turret3) {
          cycleTurret(2);
        }  
        break;
      case TURRET_FOUR:
        if (player.turret4) {
          cycleTurret(3);
        }
        break;
      case DRONE_ONE:
        if (player.unlockedDrones1.size() > 0) {
          drones.setDroneOne(drone1Selections.get(currentIndex));
          selectorText = drone1Selections.get(currentIndex).text;
        }
        break;
      case DRONE_TWO:
        if (player.unlockedDrones2.size() > 0) {
          drones.setDroneTwo(drone2Selections.get(currentIndex));
          selectorText = drone2Selections.get(currentIndex).text;
        }
        break;
    }
  }
  
  
  // submethod to make above switch statement non-repetetive
  void cycleTurret(int turretIndex) {
    player.selectedBulletType[turretIndex] = bulletSelections.get(currentIndex);
    player.turretTimers.set(turretIndex, new Timer(player.selectedBulletType[turretIndex].rate));
    selectorText = bulletSelections.get(currentIndex).text;   
  }
  
  
  // fill selectors with available options (used whenever going to select screen)
  void update() {
       
    switch(id) {
      case LEVEL:
        levelSelections = new ArrayList<Level>();
        for (int i = 0; i < player.highestLevelUnlocked; i++) {
          levelSelections.add(Level.values()[i]);
        }
        totalOptions = levelSelections.size();
        selectorText = levelSelections.get(currentIndex).text  + "\n" + player.highScores[currentIndex];
        break;
      case TURRET_ONE:
          loadBullets();
        break;
      case TURRET_TWO:
        if (player.turret2) {
          loadBullets();
        }
        break;
      case TURRET_THREE:
        if (player.turret3) {
          loadBullets();
        }
        break;
      case TURRET_FOUR:
        if (player.turret4) {
          loadBullets();
        } 
        break;
      case DRONE_ONE:
        if (player.unlockedDrones1.size() > 0) {
          drone1Selections = player.unlockedDrones1;
          totalOptions = drone1Selections.size();
          selectorText = drone1Selections.get(currentIndex).text;
        }
        break;
      case DRONE_TWO:
        if (player.unlockedDrones2.size() > 0) {
          drone2Selections = player.unlockedDrones2;
          totalOptions = drone2Selections.size();
          selectorText = drone2Selections.get(currentIndex).text;
        }
        break;
    }   
  }
  
  
  // helpful bit to make above switch statement non-repetetive (good example of a method that should be private?)
  void loadBullets() {
    bulletSelections = new ArrayList<BulletDefinition>();
    bulletSelections.add(BulletDefinition.BASIC);
    bulletSelections.addAll(player.unlockedBullets);
    totalOptions = bulletSelections.size();
    selectorText = bulletSelections.get(currentIndex).text;
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