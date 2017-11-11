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
  boolean turret4 = false;
  
  int[] bullets = new int[BulletDefinition.values().length - 1];  // -1 because don't need to store basic, always unlocked
  
  int[] drones1 = new int[DroneDefinition.values().length];
  int[] drones2 = new int[DroneDefinition.values().length];
  
  float bulletPowerMultiplier;
  float bulletSizeMultiplier;
  float droneSizeMultiplier;
  float freezeTimeMultiplier;
  
  int[] highScores = new int[Level.values().length];
  
  
  
  FileIO() {
    
  }
  
  void loadData() {
    String data[] = loadStrings("endplayer"); 
    
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
    if (int(turretData[2]) == 1) {
      turret4 = true;
    }
    
    String[] bulletData = data[2].split(",");
    for (int i = 0; i < bulletData.length; i++) {
      bullets[i] = int(bulletData[i]);      
    }
     
    String[] drone1Data = data[3].split(",");
    for (int i = 0; i < drone1Data.length; i++) {
      drones1[i] = int(drone1Data[i]);      
    }
    
    String[] drone2Data = data[4].split(",");
    for (int i = 0; i < drone2Data.length; i++) {
      drones2[i] = int(drone2Data[i]);     
    }
    
    String[] multipliers = data[5].split(",");
    bulletPowerMultiplier = float(multipliers[0]);
    bulletSizeMultiplier = float(multipliers[1]);
    droneSizeMultiplier = float(multipliers[2]);
    freezeTimeMultiplier = float(multipliers[3]);
    
    String[] highScoreData = data[6].split(",");
    for (int i = 0; i < highScoreData.length - 1; i++) {
      highScores[i] = int(highScoreData[i]);      
    }
  }
  
  void saveData() {
    
  }
  
  void clearData() {
    
  }
  
}

/* 
NOTE:
list of csv values stored:
 currency, maxHP, highest level unlocked
 extra turrets unlocked (as 0 or 1, must list all 3) (1st is ALWAYS unlocked) 
 bullettypes unlocked (0 or 1 for each beyond basic, indexes in enum order)
 drone1 types unlocked (0 or 1 for each again)
 drone2 types unlocked
 power mult, bSize mult, droneSize mult, freeze time mult, (default is 1 for each)
 high score each level (default is 0 of course)
 */