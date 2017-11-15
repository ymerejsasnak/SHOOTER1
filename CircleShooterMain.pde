/*
====NEXT TO DO====

-MAJOR, IMPORTANT-
 -shop screen/state to buy upgrades:
 bullet types, extra turrets, drones, hp upgrade, power multiplier, bullet size multiplier, drone size multiplier, freeze time multiplier
 (possibly subclass button to shopbutton to add booleans such as 'can afford' and 'purchased'
 (also maybe make separate enum for shopbutton IDs)
 ==plan costs of everything in shop:
 order of weapons (cost-wise)? -- spray + power, bubble + pea + bomb, freeze + spread + drain
 order of drones (cost-wise)? --  attacker, defender + moon, freeze, vaporize+++
 upgrades that start cheaper (but will grow) - hp, power, first turret
 upgrades that start more expensive (and have less upgrades total) - last 2 turrets, bullet size, drone size, freeze time
 
 -fileIO - implement savedata (after shop) and cleardata(for new games - also if file doesn't exist, create it)
 also exception checking for load if file not found (in which case it just starts new game/makes new file?)
 
 
 BUG: turrets must be purchased in order (not at actual purchase time, but when starting a level) or else causes indexing error

 
-MINOR, LESS IMPORTANT-
 -implement high score showing and saving
 -enemy colors based on more variables
 -repetetive code in selector class (and drones class?) when dealing with drones!
 -more comments in the setstatus method in player class?
 -change select boxes so they show representative picture with labelling beneath it? or something more informative?
 (should show power/rate and picture? something like that?)
 -make death state/screen (simple: you died, currency earned, enemies killed, 
 click to continue, etc) and take care of stuff in run level loop under
 if (player.dead) there
 -basic/simple death animation (at least for enemies, probably also player)
 -?enemy hp and attack based partially off level (and only a little on 'danger level', danger level is mostly speedup)
 -more enum constructors for extra variables for certain enemy/bullet types (ie osciltimer, rotation speed, teleport/random time, etc.)
  (and then can make more variation on those types for enemy defs)
 -some more enemy defs (at least more carrier types, maybe a smaller teleporter? any others?)
 (actually, should be possible to make carrier of carriers...should I try this or no?)
 -and then, after that, fix level definitions to reflect new enemies
 -polish: sfx, music, graphics tweaks, game balance, etc
 

 - what about better collision detection?
 

POSSIBLE REFACTORING:
 -selector class as parent class, level/turret/drone each as its own subclass?
 -should each 'runstate' method display its own buttons? make gamestates their own objects? 
 -add methods to various enums instead of all the if/switch statements?
 -getters/setters, private/public stuff for proper java-ness
 */



// DECLARATIONS //
FileIO file;
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
  file = new FileIO();
  game = new Game();
}


void draw() {

  //background(BG_COLOR);

  //calculate time (in seconds) since last loop
  deltaTime.calcDelta();

  //run the game (takes care of states, running player/enemies/bullets, etc.)
  game.run();

  // temp thing to show framerate
  text("Framerate: " + (int) frameRate, 100, height - 20);
  
  //temp thing to blur graphics...but should implement something like this
  fill(0, 100);
  noStroke();
  rect(width/2, height/2, width, height);
  
}


void mousePressed() {

  game.processClick(mouseX, mouseY);
}