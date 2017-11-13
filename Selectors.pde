/*
  CLASS TO CREATE AND MANAGE INDIVIDUAL 'SELECTOR' CONTROL OBJECTS
*/

class Selectors {
  
  ArrayList<Selector> selectors;
  
  Selectors() {
    
    selectors = new ArrayList<Selector>();
    selectors.add(new Selector(SelectorID.LEVEL, SELECTOR_SIZE * 3/2, height - SELECTOR_SIZE * 2));
       
    selectors.add(new Selector(SelectorID.TURRET_ONE, width * 1/2, SELECTOR_SIZE));
    selectors.add(new Selector(SelectorID.TURRET_TWO, width * 1/2, SELECTOR_SIZE * 2));
    selectors.add(new Selector(SelectorID.TURRET_THREE, width * 1/2 - SELECTOR_SIZE, SELECTOR_SIZE * 3/2));
    selectors.add(new Selector(SelectorID.TURRET_FOUR, width * 1/2 + SELECTOR_SIZE, SELECTOR_SIZE * 3/2));
    
    selectors.add(new Selector(SelectorID.DRONE_ONE, width * 1/2 - SELECTOR_SIZE * 5/2, SELECTOR_SIZE * 3/2));
    selectors.add(new Selector(SelectorID.DRONE_TWO, width * 1/2 + SELECTOR_SIZE * 5/2, SELECTOR_SIZE * 3/2));
 
  }
  
  
  // check if selector was clicked on
  SelectorID checkSelectors(int _mouseX, int _mouseY) {
    
    SelectorID clickedSelector = SelectorID.NONE;
      for (Selector s: selectors) {
        if (s.clickCheck(_mouseX, _mouseY)) {
          clickedSelector = s.id; // store selector ID to switch on below
        };
      }
    return clickedSelector;
  }
  
  
  // 'cycle' options on appropriate selector based on click
  void cycle(SelectorID clickedSelector) {
    switch (clickedSelector) { 
        case NONE:
          break;
        case LEVEL:
          selectors.get(0).cycle();
          break;
        case TURRET_ONE:
          selectors.get(1).cycle();
          break;
        case TURRET_TWO:
          selectors.get(2).cycle();
          break;
        case TURRET_THREE:
          selectors.get(3).cycle();
          break;
        case TURRET_FOUR:
          selectors.get(4).cycle();
          break;
        case DRONE_ONE:
          selectors.get(5).cycle();
          break;
        case DRONE_TWO:
          selectors.get(6).cycle();
          break;        
      }
  }
  
  
  // run through selectors, updating available options
  void update() {
    for (Selector s: selectors) {
      s.update(); 
    } 
  }
  
  
  // show selectors (only runs in SELECT state, based on if statement in Game class)
  void displaySelectors() {
    for (Selector s: selectors) {
      s.display();
    }
  }
}