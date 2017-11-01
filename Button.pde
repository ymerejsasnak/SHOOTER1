// enum to identify button pressed
enum ButtonID {
  // default value
  NONE, 
  // title screen buttons
  PLAY, QUIT, 
  // select screen buttons
  START, TO_TITLE, 
  // level screen buttons
  PAUSE, 
  // pause screen buttons
  RESUME, QUIT_LEVEL 
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

  Button(ButtonID _id, String text, int x, int y, int size) {

    id = _id;
    buttonText = text;
    buttonX = x;
    buttonY = y;
    buttonSize = size;
  }

  void display() {

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