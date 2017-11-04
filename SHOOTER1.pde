/*
NEXT TO DO:
-work on adding to, and toward finalizing, bullet defs, enemy defs, and level defs
-add level progression (ie, gets harder as it goes on)
-selection screen (first levels, then player stuff)
-player status, upgrades, and load/save
-endless refactoring

EVENTUALLY:
 -make death state/screen (simple: you died, currency earned, enemies killed, 
 click to continue, etc) and take care of stuff in run level loop under
 if (player.dead) there
 -refactoring: make getters/setters, private/public stuff,
 -add drones or no???? (miner, defender, freeze, kamikaze
 -ANOTHER POSSIBLE ENEMY TYPE? -- SPLITS INTO TWO OTHER SMALLER ONES (OF DEFINED TYPE) WHEN KILLED)
 -ANOTHER POSSIBLE BULLET TYPE -- spread?  generates 3 bullets at turret, 1 straight 2 others at opposite angles
 -fluff stuff (sfx, music, graphics tweaks, etc)
 */


// GAME CONSTANTS //
final int BG_COLOR = 10; // almost black
final int TEXT_COLOR = 200; // kind of white

final int ENEMY_ALPHA = 150; // how transparent are enemies?

final int BUTTON_SIZE = 70;
final int BUTTON_TEXT_SIZE = 20;
final int BUTTON_TEXT_OFFSET = 7; // needed to move text down a bit so it looks centered

final int GUN_LENGTH = 10;
final int FREEZE_DURATION = 2000;  //ms
////////////////////


// DECLARATIONS //
Game game;
DeltaTime deltaTime;
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