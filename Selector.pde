// enum to identify button pressed
enum SelectorID {
  // default value
  NONE, 
  LEVEL,
  TURRET_ONE,
  TURRET_TWO,
  TURRET_THREE,
  TURRET_FOUR 
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
  
  ArrayList<Level> levelSelections = new ArrayList<Level>(); //= new ArrayList<Level>(Arrays.asList(Level.ONE, Level.TWO, Level.THREE, Level.FOUR, Level.FIVE, Level.SIX, Level.SEVEN, Level.EIGHT));
  ArrayList<BulletDefinition> bulletSelections = new ArrayList<BulletDefinition>();
  
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
    }
  
  }
  
  void cycle() {
    currentIndex = (currentIndex + 1) % totalOptions;
    if (id == SelectorID.LEVEL) {
      game.currentLevel = levelSelections.get(currentIndex);
    }
      
  }
  
  void display() {
    fill(TEXT_COLOR);
    String text = levelSelections.get(currentIndex).text;
    textSize(SELECTOR_TEXT_SIZE);
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