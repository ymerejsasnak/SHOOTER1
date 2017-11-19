// define possible game states
enum GameState {
  TITLE, SELECT, LEVEL, SHOP;
}

/*
  CLASS TO RUN GAME (HANDLE EVENTS AND SWITCH BETWEEN GAME STATES)
*/
class Game {
  GameState state;
  Level currentLevelDefinition;
  int currentLevel;
  Buttons buttons;
  Selectors selectors;

  
  int levelProgression = 0; //used to scale up difficulty as level goes on
  Timer progressionTimer = new Timer(DANGER_LEVEL_TIME);
  
  int enemiesKilled;
    
  Game() {
    
    // initialize stuff
    state = GameState.TITLE; 
    player = new Player(); 
    buttons = new Buttons();
    selectors = new Selectors();
    
    currentLevel = 1;
    currentLevelDefinition = Level.ONE;     
  }
  
  
  // process mouse clicks (buttons and selectors)
  void processClick(int _mouseX, int _mouseY) {
    
    SelectorID clickedSelector = SelectorID.NONE;
    if (state == GameState.SELECT) {
      clickedSelector = selectors.checkSelectors(_mouseX, _mouseY);
      selectors.cycle(clickedSelector);
    }
    
    Button pressedButton = buttons.checkButtons(_mouseX, _mouseY);
    if (pressedButton == null) {
      return;
    }
      
    // button press actions
    switch (pressedButton.id) {
      case NONE:
        break;
      case LOAD:     
        player.setStatus();
        selectors.update();
        state = GameState.SELECT; 
        break;
      case NEW:
      //cleardata/make new file?
      case RETURN_TO_SELECT:
        selectors.update();
        state = GameState.SELECT;
        break;
      case START: 
        drone.resetAngles();
        progressionTimer.restart();
        player.restartTurretTimers();
        enemiesKilled = 0;
        //levelProgression = 0;
        bullets = new Bullets();
        enemies = new Enemies();
        state = GameState.LEVEL;
        break;
      case SHOP:
        state = GameState.SHOP;
        
        break;
      case QUIT:
        exit();  
      default:
        // if none of above, it's a shop button:
        processShop(pressedButton);
        buttons.updateShop();
    }
    
    // set appropriate buttons to 'active'
    buttons.setActive(state);
  }
  
  
  // main 'run' method to choose which state to run
  void run() {
    
    switch (state) {
      case TITLE:
        runTitle();
        break;
      case SELECT:
        runSelect();
        break;
      case LEVEL:
        runLevel();
        break;
      case SHOP:
        runShop();
        break;
    }
  
    //then display hud, but not on title screen
    if (state != GameState.TITLE) {
      displayHUD();
    }
    
    // and display buttons, and selectors if on select screen
    buttons.displayButtons();
    if (state == GameState.SELECT) {
      selectors.displaySelectors();
    }   
  }
    
    
  // run the title screen (very basic for now, can pretty it up later)
  void runTitle() {
    
    fill(TEXT_COLOR);
    textSize(TITLE_TEXT_SIZE);
    
    // need to set fonts and stuff, right now just default
    text("CIRCLE SHOOTER", width / 2, height / 3);   
  }
  
  
  // run the level/upgrade selection screen
  void runSelect() {
    file.saveData();
    player.hp = player.maxHP; // just make sure player's hp is refilled if quit or died
    //see if next level is unlocked
    if (levelProgression >= DANGER_LEVEL_UNLOCK &&
          player.highestLevelUnlocked < Level.values().length) {
        player.highestLevelUnlocked = max(currentLevel + 1, player.highestLevelUnlocked);
        selectors.update();
      
    }
    levelProgression = 0;
  }
  
  
  void runShop() {
    buttons.updateShop();
  }
  
  
  void processShop(Button pressedButton) {
    if (player.currency >= pressedButton.cost && !pressedButton.purchased && pressedButton.affordable) {
      player.currency -= pressedButton.cost;
      pressedButton.purchased = true;
      switch(pressedButton.id) {
        case POWER:
          player.unlockedBullets.add(BulletDefinition.values()[1]);
          break;
        case SPRAY:
          player.unlockedBullets.add(BulletDefinition.values()[2]);
          break;
        case PEA:
          player.unlockedBullets.add(BulletDefinition.values()[3]);
          break;
        case BOMB:
          player.unlockedBullets.add(BulletDefinition.values()[4]);
          break;
        case BUBBLE:
          player.unlockedBullets.add(BulletDefinition.values()[5]);
          break;
        case FREEZE:
          player.unlockedBullets.add(BulletDefinition.values()[6]);
          break;
        case DRAIN:
          player.unlockedBullets.add(BulletDefinition.values()[7]);
          break;
        case SPREAD:
          player.unlockedBullets.add(BulletDefinition.values()[8]);
          break;
        case LEFT_TURRET:
          player.turret2 = true;
          player.selectedBulletType[1] = BulletDefinition.BASIC;
          player.turretTimers.add(new Timer(player.selectedBulletType[1].rate));
          break;
        case RIGHT_TURRET:
          player.turret3 = true;
          player.selectedBulletType[2] = BulletDefinition.BASIC;
          player.turretTimers.add(new Timer(player.selectedBulletType[2].rate));
          break;
        
        case ATTACKER:
          player.unlockedDrones.add(DroneDefinition.ATTACKER);
          break;
        case DEFENDER:
          player.unlockedDrones.add(DroneDefinition.DEFENDER);
          break;
        case FREEZER:
          player.unlockedDrones.add(DroneDefinition.FREEZER);
          break;
        case MOON:
          player.unlockedDrones.add(DroneDefinition.MOON);
          break;
        case VAPORIZER:
          player.unlockedDrones.add(DroneDefinition.VAPORIZER);
          break;
        
        case MAX_HP:
          player.maxHP *= 2;
          break;
        case BULLET_POWER:
          player.bulletPowerMultiplier = 2;
          break;
        case BULLET_SIZE:
          player.bulletSizeMultiplier = 2;
          break;
        case DRONE_SIZE:
          player.droneSizeMultiplier = 2;
          break;
        case FREEZE_TIME:
          player.freezeTimeMultiplier = 2;
          break;
   
      }
    }
  }
  
 
  
  // run the actual game level
  void runLevel() {
    
    player.highScores[currentLevel - 1] = max(enemiesKilled, player.highScores[currentLevel - 1]);
    
    // take care of things if player dies and exit method (better to put this in player class?)
    if (player.dead) {
      
      game.state = GameState.SELECT;
      buttons.setActive(state);
      player.dead = false;
      return;
    } 
    
    // update and display player
    player.update();
    player.display();
        
    // run drones then bullets
    drone.update();
    drone.display();
    bullets.run();
    
    // progress to next danger level if necessary, then run enemies
    if (progressionTimer.check()) {
      levelProgression += 1;
      
    }
    enemies.run(levelProgression);
    
    // finally generate new bullets
    player.shoot(); 
    
  }
  
   
  // basic info on top bar
  void displayHUD() {
    
    textSize(HUD_TEXT_SIZE);
    fill(TEXT_COLOR);
    
    text("currency: " + player.currency, width * 1/5, HUD_VERTICAL_POS);
    text("hp: " + player.hp + "/" + player.maxHP, width * 2/5, HUD_VERTICAL_POS);
    text("enemies killed: " + enemiesKilled, width * 3/5, HUD_VERTICAL_POS);
    text("danger level: " + levelProgression, width * 4/5, HUD_VERTICAL_POS);
  } 
}