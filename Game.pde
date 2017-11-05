// define possible game states: title screen, weapon/level select, actual level, pause
enum GameState {
  TITLE, SELECT, LEVEL, PAUSE;
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
  ArrayList<Button> pauseButtons;
  
  ArrayList<Button> activeButtons;
  
  ArrayList<Selector> selectors;
  
  Game() {
    
    // initialize stuff
    state = GameState.TITLE;
    player = new Player(); 
    
    
    //TEMP for now hard coded level loading but will eventually have to set this in select screen
    currentLevel = Level.ONE; 
    
    
    // define/load possible buttons for each gamestate (bad way to do this or what -- maybe could use enum??)
    titleButtons = new ArrayList<Button>();
    titleButtons.add(new Button(ButtonID.PLAY, "PLAY", width/3, height * 2/3, BUTTON_SIZE));
    titleButtons.add(new Button(ButtonID.QUIT, "QUIT", width * 2/3, height * 2/3, BUTTON_SIZE));

    selectButtons = new ArrayList<Button>();
    selectButtons.add(new Button(ButtonID.START, "START", 
                                width * 3/4, height * 3/4, BUTTON_SIZE));
    selectButtons.add(new Button(ButtonID.TO_TITLE, "TITLE",
                                width * 3/4, height * 3/4 + BUTTON_SIZE, BUTTON_SIZE));
                                           
    levelButtons = new ArrayList<Button>();
    levelButtons.add(new Button(ButtonID.PAUSE, "PAUSE",
                                width - BUTTON_SIZE - 1, height - BUTTON_SIZE/2 - 1, BUTTON_SIZE));
                                
    pauseButtons = new ArrayList<Button>();
    pauseButtons.add(new Button(ButtonID.RESUME, "RESUME",
                                width/3, height/2, BUTTON_SIZE));
    pauseButtons.add(new Button(ButtonID.QUIT_LEVEL, "QUIT",
                                width * 2/3, height/2, BUTTON_SIZE));
        
    // by default title screen buttons are active
    activeButtons = titleButtons;
    
    // selector boxes for selection screen
    selectors = new ArrayList<Selector>();
    selectors.add(new Selector(SelectorID.LEVEL, width/4, height/4));
    
    selectors.add(new Selector(SelectorID.TURRET_ONE, width * 1/5, height/2));
    selectors.add(new Selector(SelectorID.TURRET_TWO, width * 2/5, height/2));
    selectors.add(new Selector(SelectorID.TURRET_THREE, width * 3/5, height/2));
    selectors.add(new Selector(SelectorID.TURRET_FOUR, width * 4/5, height/2));
    
  }
  
  // process mouse clicks (for title, select, pause, etc  )
  void processClick(int _mouseX, int _mouseY) {
    
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
      case PLAY:
      case QUIT_LEVEL:
        activeButtons = selectButtons;
        state = GameState.SELECT;
        break;
      case START: // intentionally no break statement - both go to level state with level buttons
        enemiesKilled = 0;
        levelProgression = 0;
        bullets = new Bullets();
        enemies = new Enemies();
      case RESUME:
        activeButtons = levelButtons;
        state = GameState.LEVEL;
        break;
      case PAUSE:
        activeButtons = pauseButtons;
        state = GameState.PAUSE;
        break;
      case TO_TITLE:
        activeButtons = titleButtons;
        state = GameState.TITLE;
        break;
      case QUIT:
        exit();     
    }
    
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
        
      }
    }
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
      case PAUSE:
        runPause();
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
    textSize(50);
    
    // need to set fonts and stuff, right now just default
    text("CIRCLE SHOOTER", width/2, height/3);
    
    
  }
  
  
  // run the level/upgrade selection screen
  void runSelect() {
    
  }
  
  
  // run the actual game level
  void runLevel() {
    
    player.update();
    player.display();
    
    if (player.dead) {
      game.state = GameState.SELECT;
      activeButtons = selectButtons;
      player.hp = player.maxHP;
      player.dead = false;
      return;
    } 
    
    bullets.run();
    
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
    textSize(20);
    fill(TEXT_COLOR);
    
    text("currency: " + player.currency, width/5, 25);
    text("hp: " + player.hp + "/" + player.maxHP, width * 2/5, 25);
    if (state == GameState.LEVEL || state == GameState.PAUSE) {
      text("enemies killed: " + enemiesKilled, width * 3/5, 25);
      text("danger level: " + levelProgression, width * 4/5, 25);
    }
    
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