/*
NOTES AND TO DO:
 -make death state/screen (simple: you died, currency earned, enemies killed, 
 click to continue, etc) and take care of stuff in run level loop under
 if (player.dead) there
 -refactoring: make getters/setters, private/public stuff,
 load more stuff into Game rather than global, 
 REFACTOR ENEMIES/ENEMY CLASS!!!! (and level loading, etc), bullets player etc
 -work on enemy definitions
 -work on level definitions/loading and running levels (just array of enemy definitions to use and choose from randomly)
 -work on bullet types (freeze, bombs, gas?, big/slow bullets) and extra turrets
 -work on select screen
 -add drones! (miner, defender, freeze, kamikaze
 -ANOTHER POSSIBLE ENEMY TYPE? -- SPLITS INTO TWO OTHER SMALLER ONES (OF DEFINED TYPE) WHEN KILLED)
 */


// GAME CONSTANTS //
final int BG_COLOR = 10; // almost black
final int TEXT_COLOR = 200; // kind of white
final int ENEMY_ALPHA = 150; // how transparent are enemies?
final int BUTTON_TEXT_SIZE = 20;
final int BUTTON_TEXT_OFFSET = 7; // needed to move text down a bit so it looks centered
final int GUN_LENGTH = 10;
////////////////////


// DECLARATIONS //
Game game;
// declare these V inside game class? 
Time time;
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

  time = new Time();
  game = new Game();

  // put in game class?
  
  player = new Player(BulletDefinition.POWER); //this is not where bullets should ultimately be loaded
}


void draw() {

  background(BG_COLOR);

  //calculate time (in seconds) since last loop
  time.calcDelta();

  game.run();

  // temp thing to show framerate
  text("Framerate: " + (int) frameRate, 100, height - 20);
}


void mousePressed() {

  game.processClick(mouseX, mouseY);
}