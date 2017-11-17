/*
  GAME CONSTANTS
*/

// COLORS AND OTHER DRAWING CONSTANTS
final color BG_COLOR = 10; // almost black
final color TEXT_COLOR = 200; // kind of white
final color BLACK = 0;
final color WHITE = 255;

// for player
final color PLAYER_COLOR = color(50, 100, 200);
final color PLAYER_STROKE = color(40, 50, 250);
final int PLAYER_STROKE_WEIGHT = 5;
  
// for bullets
final color BULLET_WHITE = 200;
final color GAS_GREEN = color(0, 100, 0, 50);
final color FREEZE_BLUE = color(100, 100, 250, 200);
final color DRAIN_YELLOW = color(50, 70, 0);

// for drones
final color DAMAGE_FILL = color(100, 10, 10);
final color FREEZE_FILL = color(150, 150, 220);
final color VAPORIZE_FILL = color(240, 230, 210);
final color DRONE_STROKE = 100;
final int DRONE_STROKE_WEIGHT = 2;

// for enemies
final color FROZEN_COLOR = color(0, 0, 255, 100); // transparent blue circle over enemy when frozen
final int ENEMY_ALPHA = 150; // how transparent are enemies?


// TEXT AND CONTROL OBJECT CONSTANTS
final int BUTTON_SIZE = 100;
final int BUTTON_TEXT_SIZE = 20;
final int BUTTON_TEXT_OFFSET = 7; // needed to move text down a bit so it looks centered
final color BUTTON_BG = color(200, 5);
final int BUTTON_CORNER = 20;

final int SELECTOR_SIZE = 150;
final int SELECTOR_TEXT_SIZE = 20;
final int SELECTOR_TEXT_OFFSET = BUTTON_TEXT_OFFSET;

final int TITLE_TEXT_SIZE = 120;

final int HUD_TEXT_SIZE = 20;
final int HUD_VERTICAL_POS = 25;


// TIMING CONSTANTS (all time *should* be in ms)
final int MILLIS_PER_SECOND = 1000;
final int FREEZE_DURATION = 2000;  
final int DANGER_LEVEL_TIME = 5000;

// possible time range in ms for random enemies to time direction switch
final int RANDOM_TIMER_MIN = 300;
final int RANDOM_TIMER_MAX = 1000;

// same but for teleport time on teleporting enemies
final int TELEPORT_TIMER_MIN = 1000;
final int TELEPORT_TIMER_MAX = 1600;

// same but for 'oscil' enemies to time rotation direction switch
final int OSCIL_TIMER_MIN = 400;
final int OSCIL_TIMER_MAX = 700;


// PLAYER/BULLET CONSTANTS
final int PLAYER_SIZE = 50;
final int GUN_LENGTH = 10;

final int STARTING_HP = 10;

final float SPREAD_ANGLE = .2;

final float GAS_ANGLE_RANDOMNESS = .5;
final float GAS_SIZE_RANDOMNESS = 5;

final int DRONE_DPS = 10; // damage rate for 'damage' type drones


// ENEMY CONSTANTS
final int ENEMY_HP_SCALE = 5; // divide danger level by this value then add to base (ie every X levels, hp + 1)
final int MAX_ENEMY_HPUP = 10;
final int ENEMY_SPEED_SCALE = 10; // multiply danger level by this, add to base speed (ie add X to speed per level)
final int MAX_ENEMY_SPEEDUP = 200;
//final int ENEMY_POWER_SCALE = 10; // divide danger level by this value then add to base (ie every X levels, power + 1)

final int CHANCE_TARGET_PLAYER = 30; // the percent chance a random type will actually move toward the player

final int TELEPORTER_DMZ = 200; // number of 'safe zone' pixels around player where teleporter will not teleport to
final int TELEPORTER_SPEED_INCREASE = 10; // pps the speed increases after each teleport

final int ARC_LENGTH = 200; //how far oscil travels back and forth (maybe not mathematically accurate but it works well enough)


// MISC
final int DANGER_LEVEL_UNLOCK = 10; // reach this 'danger level' in each level to unlock the next one (5 is temp for testing)