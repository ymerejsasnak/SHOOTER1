// define possible game states
enum GameState {
  TITLE, SELECT, LEVEL, SHOP;
}

/*
  CLASS TO RUN GAME (HANDLE EVENTS AND SWITCH BETWEEN GAME STATES)
*/
class Game {
  GameState state;
  Level currentLevel;
  Buttons buttons;
  Selectors selectors;
  
  int levelProgression = 0; //used to scale up difficulty as level goes on
  Timer progressionTimer = new Timer(DANGER_LEVEL_TIME);
  
  int enemiesKilled;
    
  Game() {
    
    // initialize stuff
    state = GameState.TITLE;
    drones = new Drones(); 
    player = new Player(); 
    buttons = new Buttons();
    selectors = new Selectors();
    
    currentLevel = Level.ONE;     
  }
  
  
  // process mouse clicks (buttons and selectors)
  void processClick(int _mouseX, int _mouseY) {
    
    SelectorID clickedSelector = SelectorID.NONE;
    if (state == GameState.SELECT) {
      clickedSelector = selectors.checkSelectors(_mouseX, _mouseY);
      selectors.cycle(clickedSelector);
    }
    
    ButtonID pressedButton = buttons.checkButtons(_mouseX, _mouseY);
    // button press actions
    switch (pressedButton) {
      case NONE:
        break;
      case LOAD:     
        player.setStatus();
        selectors.update();
        state = GameState.SELECT; 
        break;
      case NEW:
      //cleardata/make new file?
      case QUIT_LEVEL:
        selectors.update();
        state = GameState.SELECT;
        break;
      case START: 
        drones.resetAngles();
        progressionTimer.restart();
        player.restartTurretTimers();
        enemiesKilled = 0;
        levelProgression = 0;
        bullets = new Bullets();
        enemies = new Enemies();
        state = GameState.LEVEL;
        break;
      case SHOP:
        
        //state = GameState.SHOP;      
        break;
      case QUIT:
        exit();  
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
        //runshop
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
    player.hp = player.maxHP; // just make sure player's hp is refilled if quit or died
  }
  
  
  // run the actual game level
  void runLevel() {
    
    // take care of things if player dies and exit method (better to put this in player class?)
    if (player.dead) {
      if (levelProgression >= DANGER_LEVEL_UNLOCK &&
          player.highestLevelUnlocked < Level.values().length + 1) {
        player.highestLevelUnlocked += 1;
        selectors.update();
      }
      game.state = GameState.SELECT;
      buttons.setActive(state);
      player.dead = false;
      return;
    } 
    
    // update and display player
    player.update();
    player.display();
        
    // run drones then bullets
    drones.run();
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