/*
NEXT TO DO:
 -lockable/unlockable levels, lockable/unlockable turrets/bullets/drones
 player status/upgrades
 and load/save of 3 players
 
 easier to have a shop screen with buttons to buy turrets, buy bullets, drones upgrades
 
 info to save per player:
 name?
 saveslot?
 currency
 high scores per level (enemies killed and danger level reached)
 power multiplier upgrade, bullet size mult, drone size mult, freeze time mult
 maxHP
 levels unlocked (first is default)
 turret unlocks (first unlocked bye default)
 bullet unlocks (basic shot unlocked for each turret by default)
 drone unlocks (attacker is default)
 
 
 EVENTUALLY:
 
 -hunt magic numbers!
 -overload enum constructors for extra variables for certain enemy/bullet types (ie osciltimer, rotation speed, etc.)
 
-change select boxes so they show representative picture with labelling beneath it?
 
-endless refactoring/code cleanup and game balance and bug hunting

---refactor selector class - selector is parent class, with level/turret/drone as subclasses for cleaner/better code?
----?better way to manage/load buttons?  and fix various issues/ugliness w/ buttons/selectors
 (also these are probably important to make shop/upgrades/player loading easier to implement in long run)



  -make death state/screen (simple: you died, currency earned, enemies killed, 
 click to continue, etc) and take care of stuff in run level loop under
 if (player.dead) there
 
 -refactoring: make getters/setters, private/public stuff,
 
 -ANOTHER POSSIBLE ENEMY TYPE? -- SPLITS INTO TWO OTHER SMALLER ONES (OF DEFINED TYPE) WHEN KILLED)
 -ANOTHER POSSIBLE ENEMY TYPE? -- teleporting enemy!
 (and more defs in general?)
 
 
 -fluff stuff (sfx, music, graphics tweaks, etc)
 
 FUTURE:
 -bonus modes? preset weapons and enemies with diff goals
   -all freeze weapons, how long can you survive?
   -bomb shots?, how much damage can you take before you kill X enemies?
   -license to kill mode (basic shot but 1 hit kill, you also 1 hit kill...how long/how many kills?)
 
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