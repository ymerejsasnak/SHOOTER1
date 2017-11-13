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
  REAR_TURRET, LEFT_TURRET, RIGHT_TURRET,
  ATTACKER1, DEFENDER1, FREEZER1, MOON1, VAPORIZER1,
  ATTACKER2, DEFENDER2, FREEZER2, MOON2, VAPORIZER2,
  MAX_HP, BULLET_POWER, BULLET_SIZE, DRONE_SIZE, FREEZE_TIME,
  // level screen buttons
  QUIT_LEVEL 
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
  
  Button(ButtonID id, String text, int x, int y, int size) {

    this.id = id;
    buttonText = text;
    buttonX = x;
    buttonY = y;
    buttonSize = size;
  }
  
  void display() {
    fill(BUTTON_BG);
    noStroke();
    rect(buttonX, buttonY, BUTTON_SIZE, BUTTON_SIZE, BUTTON_CORNER);
    
    fill(TEXT_COLOR);
    textSize(BUTTON_TEXT_SIZE);
    text(buttonText, buttonX, buttonY + BUTTON_TEXT_OFFSET);
    
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