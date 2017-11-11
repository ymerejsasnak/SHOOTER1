// define possible game states: title screen, weapon/level select, actual level, 
enum GameState {
  TITLE, SELECT, LEVEL;
}

/*
  CLASS TO RUN GAME (HANDLE EVENTS AND SWITCH BETWEEN GAME STATES)
*/
class Game {
  GameState state;
  Level currentLevel;
  int levelProgression = 0; //used to scale up difficulty as level goes on
  Timer progressionTimer = new Timer(10000);  // increase every 10 seconds
  
  int enemiesKilled;
  
  ArrayList<Button> titleButtons;
  ArrayList<Button> selectButtons;
  ArrayList<Button> levelButtons;
   
  ArrayList<Button> activeButtons;
  
  ArrayList<Selector> selectors;
  
  Game() {
    
    // initialize stuff
    state = GameState.TITLE;
    drones = new Drones(); 
    player = new Player(); 
    
    
    //TEMP for now hard coded level loading but will eventually have to set this in select screen
    currentLevel = Level.ONE; 
    
    
    // define/load possible buttons for each gamestate (bad way to do this or what -- maybe could use enum??)
    titleButtons = new ArrayList<Button>();
    titleButtons.add(new Button(ButtonID.QUIT, "QUIT", width * 1/2, height * 4/5, BUTTON_SIZE));
    titleButtons.add(new Button(ButtonID.NEW, "NEW", width * 1/4, height * 3/5, BUTTON_SIZE));
    titleButtons.add(new Button(ButtonID.LOAD, "LOAD", width * 3/4, height * 3/5, BUTTON_SIZE));
    
    
    selectButtons = new ArrayList<Button>();
    selectButtons.add(new Button(ButtonID.START, "START", 
                                width * 1/4, height * 7/8, BUTTON_SIZE));
    selectButtons.add(new Button(ButtonID.SHOP, "SHOP",
                                width * 2/4, height * 7/8, BUTTON_SIZE));
    selectButtons.add(new Button(ButtonID.QUIT, "QUIT",
                                width * 3/4, height * 7/8, BUTTON_SIZE));
                                           
    levelButtons = new ArrayList<Button>();
    levelButtons.add(new Button(ButtonID.QUIT_LEVEL, "QUIT",
                                width - BUTTON_SIZE, height - BUTTON_SIZE, BUTTON_SIZE));
                                
   
        
    // by default title screen buttons are active
    activeButtons = titleButtons;
    
    // selector boxes for selection screen
    selectors = new ArrayList<Selector>();
    selectors.add(new Selector(SelectorID.LEVEL, SELECTOR_SIZE * 3/2, height - SELECTOR_SIZE * 2));
       
    selectors.add(new Selector(SelectorID.TURRET_ONE, width * 1/2, SELECTOR_SIZE));
    selectors.add(new Selector(SelectorID.TURRET_TWO, width * 1/2, SELECTOR_SIZE * 2));
    selectors.add(new Selector(SelectorID.TURRET_THREE, width * 1/2 - SELECTOR_SIZE, SELECTOR_SIZE * 3/2));
    selectors.add(new Selector(SelectorID.TURRET_FOUR, width * 1/2 + SELECTOR_SIZE, SELECTOR_SIZE * 3/2));
    
    selectors.add(new Selector(SelectorID.DRONE_ONE, width * 1/2 - SELECTOR_SIZE * 5/2, SELECTOR_SIZE * 3/2));
    selectors.add(new Selector(SelectorID.DRONE_TWO, width * 1/2 + SELECTOR_SIZE * 5/2, SELECTOR_SIZE * 3/2));
    
  }
  
  // process mouse clicks (for title, select, pause, etc  )
  void processClick(int _mouseX, int _mouseY) {
    
    if (state == GameState.SELECT) {
      SelectorID clickedSelector = SelectorID.NONE;
      for (Selector s: selectors) {
        if (s.clickCheck(_mouseX, _mouseY)) {
          clickedSelector = s.id; // store selector ID to switch on below
        };
      }
      
      switch (clickedSelector) {
        case NONE:
          break;
        case LEVEL:
          selectors.get(0).cycle();
          break;
        case TURRET_ONE:
          selectors.get(1).cycle();
          break;
        case TURRET_TWO:
          selectors.get(2).cycle();
          break;
        case TURRET_THREE:
          selectors.get(3).cycle();
          break;
        case TURRET_FOUR:
          selectors.get(4).cycle();
          break;
        case DRONE_ONE:
          selectors.get(5).cycle();
          break;
        case DRONE_TWO:
          selectors.get(6).cycle();
          break;        
      }
      clickedSelector = SelectorID.NONE;
    }
    
    ButtonID pressedButton = ButtonID.NONE;
    for (Button b: activeButtons) {
      if (b.clickCheck(_mouseX, _mouseY)) {
        pressedButton = b.id; // store button ID to switch on below
      };
    }
    
    // button press actions
    switch (pressedButton) {
      case NONE:
        break;
        
      case LOAD:     
        player.setStatus();
        for (Selector s: selectors) {
          s.update(); 
        }
        activeButtons = selectButtons;
        state = GameState.SELECT; 
        break;
      
      case NEW:
      case QUIT_LEVEL:
        for (Selector s: selectors) {
          s.update(); 
        }
        activeButtons = selectButtons;
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
        activeButtons = levelButtons;
        state = GameState.LEVEL;
        break;
      case SHOP:
      
        break;
      case QUIT:
        exit();     
        
    }
    
    pressedButton = ButtonID.NONE;
    
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
    }
  
    if (state != GameState.TITLE) {
      displayHUD();
    }
    displayButtons();
    if (state == GameState.SELECT) {
      displaySelectors();
    }
    
    
      
  }
    
    
  // run the title screen
  void runTitle() {
    
    fill(TEXT_COLOR);
    textSize(TITLE_TEXT_SIZE);
    
    // need to set fonts and stuff, right now just default
    text("CIRCLE SHOOTER", width / 2, height / 3);
    
    
  }
  
  
  // run the level/upgrade selection screen
  void runSelect() {
    player.hp = player.maxHP; // just make sure player's hp is full if quit or died
  }
  
  
  // run the actual game level
  void runLevel() {
    
    player.update();
    player.display();
    
    if (player.dead) {
      game.state = GameState.SELECT;
      activeButtons = selectButtons;
      player.dead = false;
      return;
    } 
    
    bullets.run();
    drones.run();
    
    if (progressionTimer.check()) {
      levelProgression += 1;
    }
    enemies.run(levelProgression);
    
    player.shoot();
    
    
  }
  
  
  // pause screen
  void runPause() {  
        
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
  
  void displayButtons() {
    for (Button b: activeButtons) {
      b.display();
    }
  }
  
  void displaySelectors() {
    for (Selector s: selectors) {
      s.display();
    }
  }
  
}