/*
  CLASS TO CREATE AND MANAGE ALL INDIVIDUAL BUTTON OBJECTS
*/

class Buttons {
  
  ArrayList<Button> titleButtons;
  ArrayList<Button> selectButtons;
  ArrayList<Button> levelButtons;
  ArrayList<Button> shopButtons;
   
  ArrayList<Button> activeButtons;
  
    
  Buttons() {
           
    // define/load possible buttons for each gamestate
    titleButtons = new ArrayList<Button>();
    titleButtons.add(new Button(ButtonID.QUIT, "QUIT", width * 1/2, height * 4/5));
    titleButtons.add(new Button(ButtonID.NEW, "NEW", width * 1/4, height * 3/5));
    titleButtons.add(new Button(ButtonID.LOAD, "LOAD", width * 3/4, height * 3/5));
    
    selectButtons = new ArrayList<Button>();
    selectButtons.add(new Button(ButtonID.START, "START", width * 1/4, height * 7/8));
    selectButtons.add(new Button(ButtonID.SHOP, "SHOP", width * 2/4, height * 7/8));
    selectButtons.add(new Button(ButtonID.QUIT, "QUIT", width * 3/4, height * 7/8));
                                           
    levelButtons = new ArrayList<Button>();
    levelButtons.add(new Button(ButtonID.RETURN_TO_SELECT, "QUIT", width - BUTTON_SIZE, height - BUTTON_SIZE));
        
                                
    shopButtons = new ArrayList<Button>();           //cost is defined here in last parameter - bad spot, at least do constants!
    shopButtons.add(new Button(ButtonID.POWER, "POWER", width * 1/9, height * 1/6, 300));
    shopButtons.add(new Button(ButtonID.SPRAY, "SPRAY", width * 2/9, height * 1/6, 600));
    shopButtons.add(new Button(ButtonID.PEA, "PEA", width * 3/9, height * 1/6, 700));
    shopButtons.add(new Button(ButtonID.BOMB, "BOMB", width * 4/9, height * 1/6, 900));
    shopButtons.add(new Button(ButtonID.BUBBLE, "BUBBLE", width * 5/9, height * 1/6, 1100));
    shopButtons.add(new Button(ButtonID.FREEZE, "FREEZE", width * 6/9, height * 1/6, 1300));
    shopButtons.add(new Button(ButtonID.DRAIN, "DRAIN", width * 7/9, height * 1/6, 1500));
    shopButtons.add(new Button(ButtonID.SPREAD, "SPREAD", width * 8/9, height * 1/6, 2000));
    
    
    shopButtons.add(new Button(ButtonID.REAR_TURRET, "REAR", width * 1/9, height * 2/6, 1000));
    shopButtons.add(new Button(ButtonID.LEFT_TURRET, "LEFT", width * 2/9, height * 2/6, 4000));
    shopButtons.add(new Button(ButtonID.RIGHT_TURRET, "RIGHT", width * 3/9, height * 2/6, 5000));
    
    shopButtons.add(new Button(ButtonID.ATTACKER1, "ATTACKER 1", width * 1/9, height * 3/6, 2000));
    shopButtons.add(new Button(ButtonID.DEFENDER1, "DEFENDER 1", width * 2/9, height * 3/6, 3000));
    shopButtons.add(new Button(ButtonID.FREEZER1, "FREEZER 1", width * 3/9, height * 3/6, 3000));
    shopButtons.add(new Button(ButtonID.MOON1, "MOON 1", width * 4/9, height * 3/6, 3000));
    shopButtons.add(new Button(ButtonID.VAPORIZER1, "VAPORIZER 1", width * 5/9, height * 3/6, 6000));
    
    shopButtons.add(new Button(ButtonID.ATTACKER2, "ATTACKER 2", width * 1/9, height * 4/6, 4000));
    shopButtons.add(new Button(ButtonID.DEFENDER2, "DEFENDER 2", width * 2/9, height * 4/6, 8000));
    shopButtons.add(new Button(ButtonID.FREEZER2, "FREEZER 2", width * 3/9, height * 4/6, 8000));
    shopButtons.add(new Button(ButtonID.MOON2, "MOON 2", width * 4/9, height * 4/6, 8000));
    shopButtons.add(new Button(ButtonID.VAPORIZER2, "VAPORIZER 2", width * 5/9, height * 4/6, 10000));
    
    shopButtons.add(new Button(ButtonID.MAX_HP, "MAX HP x2", width * 1/9, height * 5/6, 15000));
    shopButtons.add(new Button(ButtonID.BULLET_POWER, "POWER x2", width * 2/9, height * 5/6, 15000));
    shopButtons.add(new Button(ButtonID.BULLET_SIZE, "BULLET SIZE x2", width * 3/9, height * 5/6, 5000));
    shopButtons.add(new Button(ButtonID.DRONE_SIZE, "DRONE SIZE x2", width * 4/9, height * 5/6, 10000));
    shopButtons.add(new Button(ButtonID.FREEZE_TIME, "FREEZE TIME x2", width * 5/9, height * 5/6, 10000));
    
    shopButtons.add(new Button(ButtonID.RETURN_TO_SELECT, "BACK", width * 8/9, height * 8/9));
        
    // by default title screen buttons are active
    activeButtons = titleButtons;
  }
  
  
  // method called from Game to check which(if any) button was pressed
  // returns Button object to use in switch statement in Game class to change gamestate/run shop
  Button checkButtons(int _mouseX, int _mouseY) {
   
    Button pressedButton = null;
    for (Button b: activeButtons) {
      if (b.clickCheck(_mouseX, _mouseY)) {
        pressedButton = b;
      };
    }
    return pressedButton;
  }
  
  
  // set proper buttons to 'active' based on current gamestate
  void setActive(GameState state) {
    if (state == GameState.SELECT) {
      activeButtons = selectButtons;
    } else if (state == GameState.SHOP) {
      activeButtons = shopButtons;
    } else if (state == GameState.LEVEL) {
      activeButtons = levelButtons; 
    }
  }
  
  
  
   void updateShop() {
    for (Button b: activeButtons) {
      if (b.cost > 0) {
        if (player.currency >= b.cost) {
          b.affordable = true;
        }
        else {
          b.affordable = false;
        }
      }
    }
    
  }
  
  
  // show active buttons
  void displayButtons() {
    for (Button b: activeButtons) {
      b.display();
    }
  }  
}