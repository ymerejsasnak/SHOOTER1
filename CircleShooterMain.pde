/*
====NEXT TO DO====

BUGS - 

shop doesn't reflect loaded game (ie, shows unlocked stuff as still purchasable)



NEW STUFF -

new enemies - 
different movement types given that gameplay is slightly different now 
(ie, back and forth across screen, up and down across, shoot up from beside/behind player then target it, maybe others?
 also some more carrier types?
  -more enum constructors for extra variables for certain enemy/bullet types (ie osciltimer, rotation speed, teleport/random time, etc.)
  (and then can make more variation on those types for enemy defs)
  
 cleardata method in fileIO? (for if player loads game, then exits to title and chooses new game)

add bullet speed upgrade? drone damage upgrade? more hp or power upgrades??
 
 -?enemy hp and attack based partially off level (and only a little on 'danger level', danger level is mostly speedup)


 
 GAME POLISH AND 'JUICE":
 -simple music (menus minimal, level adds beat and melody or is different music?)
 -sfx - bullet sound (for diff types), hit enemy sound, enemy killed sound, player hit/killed sound, click button sound
 -keep working on game balance/level definitions/power levels/etc
 -enemy simple 'hit by bullet' animation
 -enemy size pulsing
 -enemy trail? (ie save list of previous positions to draw fading line)
 -bullet trails?
  -basic/simple death animation (at least for enemies, probably also player)
 -particle effects for hit enemy and death animations
 
 -make death state/screen (simple: you died, currency earned, enemies killed, 
 click to continue, etc) and take care of stuff in run level loop under if (player.dead) there

 -change select boxes so they show representative picture with labelling beneath it? or something more informative?
 (should show power/rate and picture? something like that?)

 
 
POSSIBLE REFACTORING:
 
 -getters/setters, private/public stuff for proper java-ness....also less 'side effects' in methods where possible
-cleanup/comments/etc on refactored stuff and everything in general(esp buttons class?)
-game class - not sure about this one--??make a gamestate class, where each state is its own object/subclass, controlled by game class?
(but seems ok for now, so leave it for now)  
-and should each 'runstate' method display its own buttons? 
 - what about better collision detection?
 


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