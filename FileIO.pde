/* 
   CLASS FOR LOADING AND SAVING PLAYER DATA
*/
class FileIO {
  Table data;
  
  int currency;
  int maxHP;
  int highestLevel;
  
  boolean turret2 = false;
  boolean turret3 = false;
  
  int[] bullets = new int[BulletDefinition.values().length - 1];  // -1 because don't need to store basic, always unlocked
  
  int[] drones = new int[DroneDefinition.values().length];
  
  float bulletPowerMultiplier;
  float bulletSizeMultiplier;
  float bulletRateMultiplier;
  float droneSizeMultiplier;
  float freezeTimeMultiplier;
  
  int[] highScores = new int[Level.values().length];
  
  void loadData() {
    String data[] = loadStrings("testplayer"); 
    // will have to change this to default file when game is done - 2 files right now: endplayer and testplayer
    
    currency = int(data[0].split(",")[0]);  
    maxHP = int(data[0].split(",")[1]);
    highestLevel = int(data[0].split(",")[2]);
        
    String[] turretData = data[1].split(",");
    if (int(turretData[0]) == 1) {
      turret2 = true;
    }
    if (int(turretData[1]) == 1) {
      turret3 = true;
    }
    
    String[] bulletData = data[2].split(",");
    for (int i = 0; i < bulletData.length; i++) {
      bullets[i] = int(bulletData[i]);      
    }
     
    String[] droneData = data[3].split(",");
    for (int i = 0; i < droneData.length; i++) {
      drones[i] = int(droneData[i]);      
    }
    
    String[] multipliers = data[4].split(",");
    bulletPowerMultiplier = float(multipliers[0]);
    bulletSizeMultiplier = float(multipliers[1]);
    bulletRateMultiplier = float(multipliers[2]);
    droneSizeMultiplier = float(multipliers[3]);
    freezeTimeMultiplier = float(multipliers[4]);
    
    String[] highScoreData = data[5].split(",");
    for (int i = 0; i < highScoreData.length - 1; i++) {
      highScores[i] = int(highScoreData[i]);      
    }
  }
  
   // run after using shop or playing level
   // outputs all necessary variables to proper places in the data file
  void saveData() {
    String general, turrets, bullets, drones, multipliers, highScores;
    bullets = "";
    drones = "";
    highScores = "";
    
    general = player.currency + "," + player.maxHP + "," + player.highestLevelUnlocked;
    
    String turret2 = player.turret2 ? "1" : "0";
    String turret3 = player.turret3 ? "1" : "0";
    turrets = turret2 + "," + turret3;
    
    for (int i = 1; i < BulletDefinition.values().length; i++) {
      if (player.unlockedBullets.contains(BulletDefinition.values()[i])) {
        bullets += "1,"; 
      } else {
        bullets += "0,";
      }
    }
    bullets = bullets.substring(0, bullets.length() - 1);
    
    for (int i = 0; i < DroneDefinition.values().length; i++) {
      if (player.unlockedDrones.contains(DroneDefinition.values()[i])) {
        drones += "1,"; 
      } else {
        drones += "0,";
      }
    }
    drones = drones.substring(0, drones.length() - 1);
    
    multipliers = player.bulletPowerMultiplier + "," + player.bulletSizeMultiplier + "," +
                  player.bulletRateMultiplier + "," + player.droneSizeMultiplier + "," + player.freezeTimeMultiplier;

    for (int i = 0; i < Level.values().length; i++) {
      highScores += player.highScores[i] + ",";
    }
    highScores = highScores.substring(0, highScores.length() - 1); 
    
    String[] dataString = new String[] {general, turrets, bullets, drones, multipliers, highScores};
    
    saveStrings(dataPath("savetest"), dataString);    
    
  }
  
  void clearData() {
    // overwrites saved player with default values to start new game?
  }
  
}

/* 
NOTE:
legend for how values are stored:
 currency, maxHP, highest level unlocked
 extra turrets unlocked (as 0 or 1, must list both) (main is ALWAYS unlocked) 
 bullettypes unlocked (0 or 1 for each beyond basic, indexes in enum order)
 drone types unlocked (0 or 1 for each again)
 power mult, bSize mult, bulletSpeed mult, droneSize mult, freeze time mult, (default is 1.00 for each up to max of 2.00)
 high score each level (default is 0 of course)
 */