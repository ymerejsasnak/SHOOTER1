/* 
Generic timer for various timed events in game (spawn rate, fire rate, freeze time, etc)
*/

class Timer {
  //all time in millis
  int timerStart = millis();
  int waitTime;
  int elapsed; // save elapsed time when pausing
  
  Timer(int waitTime) {
    this.waitTime = waitTime; //millis to wait
  }
  
  // check if wait has passed
  boolean check() {
    if (millis() - timerStart >= waitTime){
      timerStart = millis();
      return true;
    } else {
      return false;
    }
  }
  
  // need to be able to restart already loaded timers when restarting the level
  void restart() {
    timerStart = millis();
  }
  
}