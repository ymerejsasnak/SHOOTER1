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
 
 -ANOTHER BULLET - DRAIN type (+ player hp per damage to enemy)
 
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
final color BG_COLOR = 10; // almost black
final color TEXT_COLOR = 200; // kind of white
final color WHITE = 255;
final color BULLET_WHITE = 200;
final color GAS_GREEN = color(0, 100, 0, 50);
final color FREEZE_BLUE = color(100, 100, 250, 200);
final color DRAIN_YELLOW = color(50, 50, 0);

final int ENEMY_ALPHA = 150; // how transparent are enemies?


final int BUTTON_SIZE = 70;
final int BUTTON_TEXT_SIZE = 20;
final int BUTTON_TEXT_OFFSET = 7; // needed to move text down a bit so it looks centered
final color BUTTON_BG = color(200, 5);
final int BUTTON_CURVE = 20;

final int SELECTOR_SIZE = 150;
final int SELECTOR_TEXT_SIZE = 20;
final int SELECTOR_TEXT_OFFSET = BUTTON_TEXT_OFFSET;


final int TITLE_TEXT_SIZE = 120;

final int HUD_TEXT_SIZE = 20;
final int HUD_VERTICAL_POS = 25;


final int GUN_LENGTH = 10;
final int FREEZE_DURATION = 2000;  //ms

final float SPREAD_ANGLE = .2;
final float GAS_ANGLE_RANDOMNESS = .5;
final float GAS_SIZE_RANDOMNESS = 5;


final int DRONE_DPS = 10; // damage rate for 'damage' type drones
final int DRONE_WEIGHT = 2;
final color DRONE_STROKE = 100;
final color BLACK = 0;
final color DAMAGE_FILL = color(100, 10, 10);
final color FREEZE_FILL = color(150, 150, 220);
final color VAPORIZE_FILL = color(240, 230, 210);


final int ENEMY_SPEED_SCALE = 5; // multiply danger level by this value then add to base
final int ENEMY_POWER_SCALE = 5; // divide danger level by this value then add to base

// possible time range in ms for 'random' enemies to time direction switch
final int RANDOM_TIMER_MIN = 300;
final int RANDOM_TIMER_MAX = 1000;

// possible time range in ms for 'oscil' enemies to time rotation direction switch
final int OSCIL_TIMER_MIN = 400;
final int OSCIL_TIMER_MAX = 700;
final int ARC_LENGTH = 200; //how far it travels back and forth (maybe not mathematically accurate but it works well enough)

final int CHANCE_TARGET_PLAYER = 30; // the percent chance a random type will actually move toward the player

final color FREEZE_COLOR = color(0, 0, 255, 100);


final int MILLIS_PER_SECOND = 1000;
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