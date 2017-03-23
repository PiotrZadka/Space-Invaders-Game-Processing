PImage background;
PImage shipImage;
PImage alienImage;

boolean shoot = false;

int count = 0;  // reload counter - keep track on how many bullets there is on the screen at a time 
int col = 6;  // number of columns for alienArray
int row = 4;

ArrayList<missile> missileList = new ArrayList<missile>();
alien [][] alienArray = new alien [row][col];

playerShip player1;


void keyPressed(){
  float moveLength = 20;
  if(keyCode == LEFT){
    player1.moveShip(-moveLength);  // move object left
  }
  if(keyCode == RIGHT){
    player1.moveShip(moveLength);   // move object right
  } 
  if(key == ' '){
   if(count < 3){
       missileList.add(new missile(player1.shipX+32,player1.shipY-10));
       count = count + 1;
     }
   }
  }

void setup(){
  size (600,700);
  background = loadImage("cosmosBg.jpg");
  shipImage = loadImage("playerShip.png");
  alienImage = loadImage("alien.png");
  background.resize(width,height);
  shipImage.resize(70,70);
  alienImage.resize(70,40);
  player1 = new playerShip(265,630);
  
    // 2d Array of Aliens spawn
    int xPosAlien = 25;
    int yPosAlien = 100;
    
    for(int k = 0; k < row; k++){
      for(int j = 0; j < col; j++){
        float leftLimit = xPosAlien - 25;
        float rightLimit = xPosAlien + 25;
        
        alienArray[k][j] = new alien(xPosAlien,yPosAlien,0.5,leftLimit,rightLimit);
        xPosAlien = xPosAlien + 96;
      }
      xPosAlien = 25;
      yPosAlien = yPosAlien + 50;
    }
  }


void draw(){
  image(background,0,0);
  player1.drawShip();

  // alienArray behaviours (visibility + move)
  for(int k = 0; k < row; k++){
      for(int j = 0; j < col; j++){
        alienArray[k][j].updateAlien();
        //change every second row to move other way
      }
  }
  
  //check if missiles reached top
  for(int i = 0; i < missileList.size(); i++){
         missileList.get(i).updateMissile(); 
         if(missileList.get(i).reachedTop()){  
           missileList.remove(i);
            count = count -1 ;
         }
     }
     
   //test array size for missileList
     println(count);
     println("Size: "+missileList.size());
       
  // test 2d array hit (remove off the screen if hit) // temporary fix for removing aliens
    for(int j = 0; j < row; j++){
      for(int k = 0; k < col; k++){
        for(int i = 0; i < missileList.size(); i++){
        if(alienArray[j][k].isHit(missileList.get(i))){
          alienArray[j][k] = new alien(-50,-50,0,0,0); // No clue how to remove array element without changing it size so just move if off the screen lol
          missileList.remove(i);
          count = count -1;
          break;
        }
      }
    }
  }
}