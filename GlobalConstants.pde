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
final int BUTTON_CORNER = 20;

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

final int DANGER_LEVEL_TIME = 5; // in seconds

final int ENEMY_HP_SCALE = 2; // divide danger level by this value then add to base (ie every X levels, hp + 1)
final int ENEMY_SPEED_SCALE = 10; // multiply danger level by this, add to base speed (ie add X to speed per level)
final int ENEMY_POWER_SCALE = 5; // divide danger level by this value then add to base (ie every X levels, power + 1)

// possible time range in ms for 'random' enemies to time direction switch
final int RANDOM_TIMER_MIN = 300;
final int RANDOM_TIMER_MAX = 1000;

final int CHANCE_TARGET_PLAYER = 30; // the percent chance a random type will actually move toward the player

final int TELEPORT_TIMER_MIN = 1000;
final int TELEPORT_TIMER_MAX = 1600;
final int TELEPORTER_DMZ = 200; // number of 'safe zone' pixels around player where teleporter will not teleport to
final int TELEPORTER_SPEED_INCREASE = 10; // pps the speed increases after each teleport

// possible time range in ms for 'oscil' enemies to time rotation direction switch
final int OSCIL_TIMER_MIN = 400;
final int OSCIL_TIMER_MAX = 700;
final int ARC_LENGTH = 200; //how far it travels back and forth (maybe not mathematically accurate but it works well enough)


final color FROZEN_COLOR = color(0, 0, 255, 100);


final int MILLIS_PER_SECOND = 1000;
////////////////////