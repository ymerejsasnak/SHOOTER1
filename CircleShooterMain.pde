/*
====NEXT TO DO====

THE BIG REFACTOR:
redo bullet class - make it parent class, with specific bullet types as subclasses, and fix anything related in other classes(player, game, etc)
redo button class - again, parent of specific children
redo selector class - same
redo drone class - same
redo enemy class - same
game class - not sure about this one--??make a gamestate class, where each state is its own object/subclass, controlled by game class?


-MAJOR, IMPORTANT-
new enemies - 
different movement types given that gameplay is slightly different now 
(ie, back and forth across screen, up and down across, shoot up from beside/behind player then target it, maybe others?

 
 BUG: turrets must be purchased in order (not at actual purchase time, but when starting a level) or else causes indexing error
 (either fix the way it's coded, or make it so you can't purchase SPECIFIC turrets, they just get added in same order no matter what)
 BUG?:issue with drones showing up when first purchased? not sure if this really happened, double check...
BUG: shop doesn't reflect loaded game
 
-MINOR, LESS IMPORTANT-
-add bullet speed upgrade also?
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
 -some more carrier types?
 -polish: sfx, music, graphics tweaks, game balance, etc  -add "juiciness"
 

 - what about better collision detection?
 

POSSIBLE REFACTORING:
 -selector class as parent class, level/turret/drone each as its own subclass?
 -should each 'runstate' method display its own buttons? make gamestates their own objects? 
 -add methods to various enums instead of all the if/switch statements?
 -getters/setters, private/public stuff for proper java-ness
 
 
 
 refactor plans: bullet types each as its own subclass of bullet, same with enemies, drones, gamestates
 */



// DECLARATIONS //
FileIO file;
Game game;
DeltaTime deltaTime;
Player player;
Drone drone;
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

  background(BG_COLOR);

  //calculate time (in seconds) since last loop
  deltaTime.calcDelta();

  //run the game (takes care of states, running player/enemies/bullets, etc.)
  game.run();

  // temp thing to show framerate
  text("Framerate: " + (int) frameRate, 100, height - 20);
  
  //temp thing to blur graphics...but should implement something like this
  //fill(0, 100);
  //noStroke();
  //rect(width/2, height/2, width, height);
  
}


void mousePressed() {

  game.processClick(mouseX, mouseY);
}