/*
NEXT TO DO:
 -shop screen (button on select screen) to buy upgrades:  (not seperate state, more like pop-up window)
 bullet types, extra turrets, drones, hp upgrade, power multiplier, bullet size multiplier?, drone size multiplier, freeze time multiplier
 (easiest to make all seperate buttons?)
 
 -start with only level 1, others unlocked upon meeting danger level req in prev level
 
 -player status/upgrades and load/save of 3 separate player files
 list of csv values stored:
 name, currency, maxHP, highest level unlocked
 turrets unlocked 
 bullettypes unlocked (enum index of unlocked types) 
 drone1 types unlocked (-1 means none)
 drone2 types unlocked
 power mult, bSize mult, droneSize mult, freeze time mult,
 high score1, 2, 3, 4, 5, 6, 7, 8
 
 
 plan costs of everything in shop:
 order of weapons (cost-wise)? -- spray + power, bubble + pea + bomb, freeze + spread
 order of drones (cost-wise)? --  attacker, defender + moon, freeze, vaporize+++
 upgrades that start cheaper (but will grow) - hp, power, first turret
 upgrades that start more expensive (and have less upgrades total) - last 2 turrets, bullet size, drone size, freeze time
 
 
 EVENTUALLY:
 -organize constants (and put in seperate file???)
 
 -hunt magic numbers! remaining: game button/selector positions (but inevitable?), some stuff in player class? (pos, size)
 
 -overload enum constructors for extra variables for certain enemy/bullet types (ie osciltimer, rotation speed, teleport/random time, etc.)
 
 -change select boxes so they show representative picture with labelling beneath it?
 
 -endless refactoring/code cleanup and game balance and bug hunting
 
 ---refactor selector class - selector is parent class, with level/turret/drone as subclasses for cleaner/better code?
 ----?better way to manage/load buttons?  and fix various issues/ugliness w/ buttons/selectors
 (also these are probably important to make shop/upgrades/player loading easier to implement in long run)
 
 
 
 -make death state/screen (simple: you died, currency earned, enemies killed, 
 click to continue, etc) and take care of stuff in run level loop under
 if (player.dead) there
 
 -refactoring: make getters/setters, private/public stuff,

 -some more enemy defs (at least more carrier types, maybe a smaller teleporter? any others?)
 -and then, after that, fix level definitions to reflect new enemies
 
 
 -fluff stuff (sfx, music, graphics tweaks, etc)
 
 FUTURE:
 -bonus modes? preset weapons and enemies with diff goals
 -all freeze weapons, how long can you survive?
 -bomb shots?, how much damage can you take before you kill X enemies?
 -license to kill mode (basic shot but 1 hit kill, you also 1 hit kill...how long/how many kills?)
 
 */





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