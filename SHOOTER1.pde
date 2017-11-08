/*
NEXT TO DO:
 -lockable/unlockable levels, lockable/unlockable turrets/bullets/drones
 player status, with upgrades:  HP, power multiplier (affects attacker drone too?)
                              , bullet size multiplier(?), drone size(???), freeze time(??????)
 and load/save of 3 players
 
 
-change select boxes so they show representative picture with labelling beneath it?
 
-endless refactoring/code cleanup and game balance and bug hunting
---refactor selector class - selector is parent class, with level/turret/drone as subclasses for cleaner/better code?
----?levelprogress/danger seems to have some issue resetting self or something???
----?fix enemy spawn so it doesn't reset timer if there is no spawn due to max enemies? (if no noticable difference, don't worry about it?)
----?fix rotation for OSCIL/CIRCLES enemies
----?better way to manage/load buttons?  and fix various issues/ugliness w/ buttons/selectors
----?do all timers need to be reset upon starting level???? (issues w/ bullet timing, etc?)
      (add method to start/restart timer and maybe method to stop/pause timer)
      ?buttons clicked affect buttons on next state/screen?
EVENTUALLY:
 -make death state/screen (simple: you died, currency earned, enemies killed, 
 click to continue, etc) and take care of stuff in run level loop under
 if (player.dead) there
 
 -refactoring: make getters/setters, private/public stuff,
 
 -ANOTHER POSSIBLE ENEMY TYPE? -- SPLITS INTO TWO OTHER SMALLER ONES (OF DEFINED TYPE) WHEN KILLED)
 -ANOTHER POSSIBLE BULLET TYPE -- spread?  generates 3 bullets at turret, 1 straight 2 others at opposite angles
 -ANOTHER POSSIBLE ENEMY TYPE? -- teleporting enemy!
 
 -fluff stuff (sfx, music, graphics tweaks, etc)
 */


// GAME CONSTANTS //
final int BG_COLOR = 10; // almost black
final int TEXT_COLOR = 200; // kind of white

final int ENEMY_ALPHA = 150; // how transparent are enemies?

final int BUTTON_SIZE = 70;
final int BUTTON_TEXT_SIZE = 20;
final int BUTTON_TEXT_OFFSET = 7; // needed to move text down a bit so it looks centered

final int SELECTOR_SIZE = 150;
final int SELECTOR_TEXT_SIZE = 20;
final int SELECTOR_TEXT_OFFSET = BUTTON_TEXT_OFFSET;

final int GUN_LENGTH = 10;
final int FREEZE_DURATION = 2000;  //ms
////////////////////


// DECLARATIONS //
Game game;
DeltaTime deltaTime;
Drones drones;
Player player;
Bullets bullets;
Enemies enemies;
//////////////////



void setup() {

  size(1200, 800);
  ellipseMode(CENTER);
  rectMode(CENTER);
  textAlign(CENTER);
  frameRate(60);

  deltaTime = new DeltaTime();
  game = new Game();

}


void draw() {

  background(BG_COLOR);

  //calculate time (in seconds) since last loop
  deltaTime.calcDelta();

  //run the game (takes care of states, running player/enemies/bullets, etc.)
  game.run();

  // temp thing to show framerate
  text("Framerate: " + (int) frameRate, 100, height - 20);
  
  
  
  
}


void mousePressed() {

  game.processClick(mouseX, mouseY);
}