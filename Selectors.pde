/*
  CLASS TO CREATE AND MANAGE INDIVIDUAL 'SELECTOR' CONTROL OBJECTS
*/

class Selectors {
  
  ArrayList<Selector> selectors;
  
  Selectors() {
    
    selectors = new ArrayList<Selector>();
    selectors.add(new LevelSelector());
    selectors.add(new Turret1Selector());
    selectors.add(new Turret2Selector());
    selectors.add(new Turret3Selector());
    selectors.add(new DroneSelector());
    
  }
  
  
  // check if selector was clicked on
  void selectorAction(int _mouseX, int _mouseY) {
    
    for (Selector s: selectors) {
      if (s.clickCheck(_mouseX, _mouseY)) {
        s.cycle();
      }
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