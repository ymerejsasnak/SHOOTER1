/*
  CLASS TO CREATE AND MANAGE ALL INDIVIDUAL BUTTON OBJECTS
*/

class Buttons {
  
  ArrayList<Button> titleButtons;
  ArrayList<Button> selectButtons;
  ArrayList<Button> levelButtons;
  ArrayList<ShopButton> shopButtons;
  ArrayList<Button> shopScreenButtons;
  ArrayList<Button> activeButtons;
  
  Button shopExitButton;
  
    
  Buttons() {
           
    // define/load possible buttons for each gamestate
    titleButtons = new ArrayList<Button>();
    titleButtons.add(new Button(ButtonID.QUIT, "QUIT", width * 1/2, height * 4/5));
    titleButtons.add(new Button(ButtonID.NEW, "NEW", width * 1/4, height * 3/5));
    titleButtons.add(new Button(ButtonID.LOAD, "LOAD", width * 3/4, height * 3/5));
    
    selectButtons = new ArrayList<Button>();
    selectButtons.add(new Button(ButtonID.START, "START", width * 1/4, height * 7/8));
    selectButtons.add(new Button(ButtonID.SHOP, "SHOP", width * 2/4, height * 7/8));
    selectButtons.add(new Button(ButtonID.QUIT, "QUIT", width * 3/4, height * 7/8));
                                           
    levelButtons = new ArrayList<Button>();
    levelButtons.add(new Button(ButtonID.RETURN_TO_SELECT, "QUIT", width - BUTTON_SIZE, height - BUTTON_SIZE));
        
                                
    shopButtons = new ArrayList<ShopButton>();           //cost is defined here in last parameter - bad spot, at least do constants!
    shopButtons.add(new ShopButton(ButtonID.POWER, "POWER", width * 1/9, height * 1/6, 300));
    shopButtons.add(new ShopButton(ButtonID.SPRAY, "SPRAY", width * 2/9, height * 1/6, 600));
    shopButtons.add(new ShopButton(ButtonID.PEA, "PEA", width * 3/9, height * 1/6, 700));
    shopButtons.add(new ShopButton(ButtonID.BOMB, "BOMB", width * 4/9, height * 1/6, 900));
    shopButtons.add(new ShopButton(ButtonID.BUBBLE, "BUBBLE", width * 5/9, height * 1/6, 1100));
    shopButtons.add(new ShopButton(ButtonID.FREEZE, "FREEZE", width * 6/9, height * 1/6, 1300));
    shopButtons.add(new ShopButton(ButtonID.DRAIN, "DRAIN", width * 7/9, height * 1/6, 1500));
    shopButtons.add(new ShopButton(ButtonID.SPREAD, "SPREAD", width * 8/9, height * 1/6, 2000));
    
    
    shopButtons.add(new ShopButton(ButtonID.LEFT_TURRET, "LEFT", width * 1/9, height * 2/6, 1000));
    shopButtons.add(new ShopButton(ButtonID.RIGHT_TURRET, "RIGHT", width * 2/9, height * 2/6, 4000));
    
    shopButtons.add(new ShopButton(ButtonID.ATTACKER, "ATTACKER", width * 1/9, height * 3/6, 2000));
    shopButtons.add(new ShopButton(ButtonID.DEFENDER, "DEFENDER", width * 2/9, height * 3/6, 3000));
    shopButtons.add(new ShopButton(ButtonID.FREEZER, "FREEZER", width * 3/9, height * 3/6, 3000));
    shopButtons.add(new ShopButton(ButtonID.MOON, "MOON", width * 4/9, height * 3/6, 3000));
    shopButtons.add(new ShopButton(ButtonID.VAPORIZER, "VAPORIZER", width * 5/9, height * 3/6, 6000));
    
    
    shopButtons.add(new ShopButton(ButtonID.MAX_HP, "MAX HP x2", width * 1/9, height * 5/6, 15000));
    shopButtons.add(new ShopButton(ButtonID.BULLET_POWER, "POWER x2", width * 2/9, height * 5/6, 15000));
    shopButtons.add(new ShopButton(ButtonID.BULLET_SIZE, "BULLET SIZE x2", width * 3/9, height * 5/6, 5000));
    shopButtons.add(new ShopButton(ButtonID.BULLET_RATE, "FIRE RATE x2", width * 4/9, height * 5/6, 10000));
    shopButtons.add(new ShopButton(ButtonID.DRONE_SIZE, "DRONE SIZE x2", width * 5/9, height * 5/6, 10000));
    shopButtons.add(new ShopButton(ButtonID.FREEZE_TIME, "FREEZE TIME x2", width * 6/9, height * 5/6, 10000));
    
    shopExitButton = new Button(ButtonID.RETURN_TO_SELECT, "BACK", width * 8/9, height * 8/9);
    
    shopScreenButtons = new ArrayList<Button>(shopButtons);
    shopScreenButtons.add(shopExitButton);
    
    // by default title screen buttons are active
    activeButtons = titleButtons;
  }
  
  
  // method called from Game to check which(if any) button was pressed
  // returns Button object to use in switch statement in Game class to change gamestate/run shop
  Button checkButtons(int _mouseX, int _mouseY) {
   
    Button pressedButton = null;
    for (Button b: activeButtons) {
      if (b.clickCheck(_mouseX, _mouseY)) {
        pressedButton = b;
      };
    }
    return pressedButton;
  }
  
  
  void buttonAction(int _mouseX, int _mouseY) {
    Button pressedButton = checkButtons(_mouseX, _mouseY);
    if (pressedButton == null) {
      return;
    }
      
    // button press actions
    switch (pressedButton.id) {
      case NONE:
        break;
      case LOAD:     
        player.setStatus();
        game.selectors.update();
        game.state = GameState.SELECT; 
        break;
      case NEW:
      //cleardata/make new file?
      case RETURN_TO_SELECT:
        game.selectors.update();
        game.state = GameState.SELECT;
        break;
      case START: 
        //drone.resetAngles();
        game.progressionTimer.restart();
        player.restartTurretTimers();
        game.enemiesKilled = 0;
        //levelProgression = 0;
        bullets = new Bullets();
        enemies = new Enemies();
        game.state = GameState.LEVEL;
        break;
      case SHOP:
        game.state = GameState.SHOP;
        
        break;
      case QUIT:
        exit(); // note: not an immediate exit, sketch will exit after draw() function finishes this loop  
        break;
      default:
        // if none of above, it's a shop button:
        
        ShopButton pressedShopButton = (ShopButton) pressedButton;
        processShop(pressedShopButton);
        updateShop();
        
    }
    
    // set appropriate buttons to 'active'
    setActive(game.state);
  }
  
  
  // set proper buttons to 'active' based on current gamestate
  void setActive(GameState state) {
    if (state == GameState.SELECT) {
      activeButtons = selectButtons;
    } else if (state == GameState.SHOP) {
      activeButtons = shopScreenButtons;
    } else if (state == GameState.LEVEL) {
      activeButtons = levelButtons; 
    }
  }
  
  
  
   void updateShop() {
    for (ShopButton item: shopButtons) {
      if (player.currency >= item.cost) {
        item.affordable = true;
      } else {
        item.affordable = false;
      }
    }
  }
    
    
  void processShop(ShopButton pressedButton) {
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
          player.turretTimers[1] = new Timer(player.selectedBulletType[1].rate);
          break;
        case RIGHT_TURRET:
          player.turret3 = true;
          player.selectedBulletType[2] = BulletDefinition.BASIC;
          player.turretTimers[2] = new Timer(player.selectedBulletType[2].rate);
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
          player.unlockedDrones.add(DroneDefinition.BIG_FREEZER);
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
        case BULLET_RATE:
          player.bulletRateMultiplier = 2;
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
  
  
  // show active buttons
  void displayButtons() {
    for (Button b: activeButtons) {
      b.display();
    }
  }  
}