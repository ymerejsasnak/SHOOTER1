/*
  CLASS TO MAKE ANIMATION AND STUFF INDEPENDANT FROM FRAME RATE
*/
class Time {
  float last;
  float delta;
  
  Time() {
    last = 0;
    delta = 0;
  }
  
  // calculate delta time, but divide by 1000 to return it as seconds decimal
  // so all 'speeds' and whatnot can be PER SECOND;
  void calcDelta() {
    delta = (millis() - last) / 1000;
    last = millis();
  }
  
  float getDelta() {
    return delta;
  }
}