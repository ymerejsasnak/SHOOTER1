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
    titleButtons.add(new Button(ButtonID.QUIT, "QUIT", width * 1/2, height * 4/5, BUTTON_SIZE));
    titleButtons.add(new Button(ButtonID.NEW, "NEW", width * 1/4, height * 3/5, BUTTON_SIZE));
    titleButtons.add(new Button(ButtonID.LOAD, "LOAD", width * 3/4, height * 3/5, BUTTON_SIZE));
    
    selectButtons = new ArrayList<Button>();
    selectButtons.add(new Button(ButtonID.START, "START", width * 1/4, height * 7/8, BUTTON_SIZE));
    selectButtons.add(new Button(ButtonID.SHOP, "SHOP", width * 2/4, height * 7/8, BUTTON_SIZE));
    selectButtons.add(new Button(ButtonID.QUIT, "QUIT", width * 3/4, height * 7/8, BUTTON_SIZE));
                                           
    levelButtons = new ArrayList<Button>();
    levelButtons.add(new Button(ButtonID.QUIT_LEVEL, "QUIT", width - BUTTON_SIZE, height - BUTTON_SIZE, BUTTON_SIZE));
        
                                
    //shopButtons = new ArrayList<Button>(); //note ids begin at index 7
    //for (int i = 0; i < BulletDefinition.values().length; i++) {
    //  shopButtons.add(new Button(ButtonID.values()[i + 7]));
   // }
        
        
    // by default title screen buttons are active
    activeButtons = titleButtons;
  }
  
  
  // method called from Game to check which(if any) button was pressed
  // returns ButtonID to use in switch statement in Game class to change gamestate
  ButtonID checkButtons(int _mouseX, int _mouseY) {
   
    ButtonID pressedButton = ButtonID.NONE;
    for (Button b: activeButtons) {
      if (b.clickCheck(_mouseX, _mouseY)) {
        pressedButton = b.id;
      };
    }
    return pressedButton;
  }
  
  
  // set proper buttons to 'active' based on current gamestate
  void setActive(GameState state) {
    if (state == GameState.SELECT) {
      activeButtons = selectButtons;
    } else {
      activeButtons = levelButtons; 
    }
  }
  
  
  // show active buttons
  void displayButtons() {
    for (Button b: activeButtons) {
      b.display();
    }
  }  
}