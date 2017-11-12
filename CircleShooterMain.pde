/*
NEXT TO DO:
 -shop screen (button on select screen) to buy upgrades:  (not seperate state, more like pop-up window)
 bullet types, extra turrets, drones, hp upgrade, power multiplier, bullet size multiplier?, drone size multiplier, freeze time multiplier
 (easiest to make all seperate buttons?)
 
 have to actually implement the various upgrades to size/power/etc too
 
 -start with only level 1, others unlocked upon meeting danger level req in prev level
 
  
 plan costs of everything in shop:
 order of weapons (cost-wise)? -- spray + power, bubble + pea + bomb, freeze + spread + drain
 order of drones (cost-wise)? --  attacker, defender + moon, freeze, vaporize+++
 upgrades that start cheaper (but will grow) - hp, power, first turret
 upgrades that start more expensive (and have less upgrades total) - last 2 turrets, bullet size, drone size, freeze time
 
 
 EVENTUALLY:
 -hunt magic numbers! remaining: game button/selector positions (but inevitable?), some stuff in player class? (pos, size)
 
 -overload enum constructors for extra variables for certain enemy/bullet types (ie osciltimer, rotation speed, teleport/random time, etc.)
  (and then can make more variation on those types for enemy defs)
 
 -change select boxes so they show representative picture with labelling beneath it? or something more informative?
 
 -endless refactoring/code cleanup and game balance and bug hunting
 
 
 ---refactor selector class - selector is parent class, with level/turret/drone as subclasses for cleaner/better code?
    (and related status loading shit...it's kind of a mess)
 ----?better way to manage/load buttons?  and fix various issues/ugliness w/ buttons/selectors
 (also these are probably important to make shop/upgrades/player loading easier to implement in long run)
 
 -enemy hp and attack based partially off level (and only a little on 'danger level', danger level is mostly speedup)
 
 -make gamestates objects themselves? or is this too much work pointlessly?  not sure...
 
 -think about how to improve code if methods added to enums instead of using switch statements???
 
 -make death state/screen (simple: you died, currency earned, enemies killed, 
 click to continue, etc) and take care of stuff in run level loop under
 if (player.dead) there
 
 -basic/simple death animation (at least for enemies, probably also player)
 
 -refactoring: make getters/setters, private/public stuff,

 -some more enemy defs (at least more carrier types, maybe a smaller teleporter? any others?)
 -and then, after that, fix level definitions to reflect new enemies
 
 
 -fluff stuff (sfx, music, graphics tweaks, etc)
 
 FUTURE:
 --bonus modes? preset weapons and enemies with diff goals--
  -only freeze weapons, how long can you survive?
  -bomb shots?, how much damage can you take before you kill X enemies?
  -license to kill mode (basic shot but 1 hit kill, you also 1 hit kill...how long/how many kills?)
 
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