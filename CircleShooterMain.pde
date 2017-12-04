/*
====NEXT TO DO====

Enemy Tab, line 115 -- began idea of using perlin noise to make enemies wiggle, but needs work

notes from quick playthrough: -danger level should be much higher to unlock next level
                              -random enemies should be removed if they go off screen (because they can get behind player - no fair)
                              -level 6 - cut carrier of carriers, add something non-carrier for variety
                              -level 7 (new) - carrier of carriers, carrier of asteroids (new), and some others (fast? swarm? oscil/circle/rand2?)
                              - maybe level 8 (new) - MASSIVE enemy (super slow, super high hp), w/ carriers/swarm/asteroids? to distract-
                              - maybe change way levels are coded so EACH TYPE of enemy in level list has a max (given by appearances in the list)
                              - change hp to be one-hit death with 'shield' upgrade(s) to allow a hit
BUGS - 

teleporters still teleport when frozen

shop doesn't reflect loaded game (ie, shows unlocked stuff as still purchasable)



NEW STUFF -

- cleardata method in fileIO? (for if player loads game, then exits to title and chooses new game)

 -keep working on game balance/level definitions/power levels/etc
  (given new level structure, make danger level goal higher, and adjust things accordingly?)
 
 
 GAME POLISH AND 'JUICE":
 -simple music (menus minimal, level adds beat and melody or is different music?)
 -sfx - bullet sound (for diff types), hit enemy sound, enemy killed sound, player hit/killed sound, click button sound
 -enemy simple 'hit by bullet' animation
 -enemy size pulsing
 -enemy trail? (ie save list of previous positions to draw fading line)
 -better teleporter 'teleport line'
 -bullet trails?
  -basic/simple death animation (at least for enemies, probably also player)
 -particle effects (class) for hit enemy and death animations
 
 
 -make death state/screen (simple: you died, currency earned, enemies killed, 
 click to continue, etc) and take care of stuff in run level loop under if (player.dead) there

-better labeling, descriptions of shop items, and levels

-how to play screen, story screen (ie weird 'you are a circle' story)

 
 
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