// enum to identify button pressed
enum ButtonID {
  // default value
  NONE, 
  // title screen buttons
  QUIT, NEW, LOAD,
  // select screen buttons
  START, SHOP, TO_TITLE, 
  // shop buttons (maybe make separate enum for these for better organization)
  POWER, SPRAY, PEA, BUBBLE, BOMB, FREEZE, SPREAD, DRAIN,
  LEFT_TURRET, RIGHT_TURRET, 
  ATTACKER, DEFENDER, FREEZER, MOON, VAPORIZER,
  MAX_HP, BULLET_POWER, BULLET_SIZE, DRONE_SIZE, FREEZE_TIME,
  // level screen buttons
  RETURN_TO_SELECT 
  ;
}

/*
  CLASS TO BUILD BASIC BUTTONS FOR EACH SCREEN
 */
 
class Button {

  int buttonX, buttonY;
  int buttonSize;
  String buttonText;
  ButtonID id;
  
  // shop only
  int cost = 0; // if 0, not a shop button
  boolean affordable = true;
  boolean purchased = false;
  
  // constructor for regular buttons
  Button(ButtonID id, String text, int x, int y) {

    this.id = id;
    buttonText = text;
    buttonX = x;
    buttonY = y;
    buttonSize = BUTTON_SIZE;
  }
  
  // constructor for shop buttons
  Button(ButtonID id, String text, int x, int y, int cost) {

    this.id = id;
    buttonText = text;
    buttonX = x;
    buttonY = y;
    buttonSize = BUTTON_SIZE;
    this.cost = cost;
    affordable = false;
  }
  
    
  void display() {
    fill(BUTTON_BG);
    noStroke();
    rect(buttonX, buttonY, buttonSize, buttonSize, BUTTON_CORNER);
    
    if (cost > 0 && !purchased) {
      fill(TEXT_COLOR);
      text("cost: " + cost, buttonX, buttonY + BUTTON_TEXT_SIZE + BUTTON_TEXT_OFFSET);
    }
      
    if (affordable && !purchased) {
      fill(TEXT_COLOR);
      textSize(BUTTON_TEXT_SIZE);
      text(buttonText, buttonX, buttonY + BUTTON_TEXT_OFFSET);   
    }
    
  }

  // determine if touch/click was in the bounds of the button
  boolean clickCheck(int _mouseX, int _mouseY) {
    
    int half = buttonSize / 2;
    return _mouseX < buttonX + half &&
           _mouseX > buttonX - half &&
           _mouseY < buttonY + half &&
           _mouseY > buttonY - half;
  }
}