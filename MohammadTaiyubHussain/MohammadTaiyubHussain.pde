public enum gameMode {
  SPLASHSCREEN, PLAYING, FINISHED
};
gameMode currentgameMode = gameMode.SPLASHSCREEN;

PImage backGround; //global variables for background
int bgX = 0;
int score = 0;
Player player1;//declare instance for player
CountDown timer; //declare instance variable of CountDown
ArrayList <Coin> coinList = new ArrayList(); //new ArrayList for Coin class

Enemy enemy1;
Enemy enemy2;

Coin coinSplashscreen;
Enemy enemySplashscreen;
Player playerSplashscreen;

Woodenbox woodenbox1;
Metalbox metalbox1;
Woodenbox woodenbox2;

void setup() {
  size(900, 600);
  timer = new CountDown(60); //call CountDown constructor – 60 secs, for when the program begins
  backGround = loadImage("background.GIF");//load background
  backGround.resize(width, height);//make background same size as the screen
  player1 = new Player(10, height/2); //position for player1 using the Player class

  for (int i = 0; i<20; i++) {//array list size 20
    coinList.add(new Coin((int)random(width - 200) + 100, (int)random(height-100) + 10));//random x and y positions for the array list size
  }

  enemy1 = new Enemy(width - 20, height - 100);//position for enemy1 in the game
  enemy2 = new Enemy(width - 20, height/10);

  coinSplashscreen = new Coin(475, 20);//splashscreen
  playerSplashscreen = new Player(115, 50);
  enemySplashscreen = new Enemy(115, 100);

  woodenbox1 = new Woodenbox(width * 4/9, height * 2/3);
  metalbox1 = new Metalbox(width * 7/9, height*1/3);
  woodenbox2 = new Woodenbox(width * 2/9, height*1/7);
}

void draw() {
  switch(currentgameMode) {//compares to the enum gameMode
  case SPLASHSCREEN://in place of if statements
    splashscreen();//calls splashscreen void
    break;//needed so the SPLASHSCREEN gameMode shows before the PLAYING gameMode
  case PLAYING:
    drawbackground(); 
    player1.update();
    coinspawn();
    woodenbox1.render();
    metalbox1.render();
    woodenbox2.render();

    fill(0);//text colour
    textSize(15);
    text("SCORE:" + score, 20, 30);
    text("TIMER:" + timer.getRemainingTime(), 110, 30); //display seconds remaining top left

    firstenemyspawn();
    secondenemyspawn();
    woodenboxcollision();
    metalboxcollision();

  case FINISHED:
    if (score == 200) { //if all coins are collected
      background(0, 255, 0); //green background
      text("YOU WIN", width/2 - 50, height/2);
      text("YOU SCORED: "+ score, width/2 - 100, height/2 + 20);
    } else if (timer.getRemainingTime() == 0) {//else if the timer is at 0 seconds
      if (score >= 0 && score < 200) {
        background(255, 0, 0);
        text("TIMES UP, YOU LOST", width/2 - 100, height/2);
        text("YOU SCORED: "+ score, width/2 - 100, height/2 + 20);
      }
    } else if (enemy1.collision(player1)) { //if the enemy hits the player
      background(255, 0, 0);//red background
      text("You lost, you collided with the enemy", width/2 - 125, height/2);
      text("You scored: " + score, width/2 - 50, height/2+15);
    } else if (enemy2.collision(player1)) {//enemy2 collision
      background(255, 0, 0);
      text("You lost, you collided with the enemy", width/2 - 125, height/2);
      text("You scored: " + score, width/2 - 50, height/2+15);
    }
  }
}

void mousePressed() {
  while (currentgameMode == gameMode.SPLASHSCREEN) { //found an error when if you clicked the mouse when the actual game was running the timer would reset, this stops that
    timer.reset(); //when mouse is pressed 60 is put back into getRemainingTime, essentially restarting the timer
    currentgameMode = gameMode.PLAYING;//when mouse is pressed changed enum gameMode into PLAYING
  }
}
void keyPressed() {
  player1.keypressed(true); //if an arrow key is pressed move the character
  if (enemy1.collision(player1)) { //error when enemy collided with player, once collision happened if the arrow keys were pressed game would carry on
    player1.keypressed(false); //stops game once collision occurs and arrows are pressed
  }
  if (enemy2.collision(player1)) { 
    player1.keypressed(false);
  }
}

void keyReleased() {
  player1.keypressed(false); //else keep the idle image rendering
}

void splashscreen() {
  background(0, 191, 255 );
  coinSplashscreen.render();//coin for the splashscreen
  playerSplashscreen.render();//player for splashscreen
  enemySplashscreen.left();//enemy for splashscreen
  fill(0);
  textSize(15);
  text("You need to collect 20 coins in 60 seconds to win 200 points - ", 20, 40);
  textSize(15);
  text("The player - ", 20, 80);
  textSize(15);
  text("The Enemy - ", 20, 140);
  textSize(20);
  text("Use the arrow keys to move the player", width/2 - 200, height - 300); 
  text("Watch out for obstacles - (enemies can also get stuck behind them)", width/2 - 300, height - 350);
  textSize(25);
  text("Click the mouse anywhere on the screen to start the game", width/2-350, height - 40);
  fill(255, 0, 0);
  textSize(20);
  text("IF YOU COLLIDE WITH" + "\n" + "A WOLF THEN IT IS" + "\n" + "AN INSTANT GAME OVER", width/2 - 300, height - 200);
  textSize(20);
  text("IF THE TIME IS OVER" + "\n" + "AND YOU HAVEN'T COLLECTED" +"\n" + "ALL THE COINS THEN" + "\n" + "YOU HAVE LOST", width/2-25, height - 215);
  stroke(255, 0, 0);
  strokeWeight(3);
  line(width/2 - 40, height - 240, width/2 - 40, height - 115);
  fill(255);
  stroke(0);
  rect(width - 250, height/15, 200, 50);
  fill(0);
  textSize(12);
  text("Mohammad Taiyub Hussain", width - 230, height/10);
}

void coinspawn() {
  for (int count = 0; count<coinList.size(); count++) {//for loop determining how many coins will be on the screen
    Coin currentCoin = coinList.get(count);//variable called currentCoin which will get the element from the list
    currentCoin.render();//draw the coins on screen using the Coin class
    //uses boolean from Player_class 
    if (player1.collect(currentCoin)) {//if player collects coin then
      coinList.remove(count);//then it is removed from the array and from the screen
      score = score + 10;//score increases by 10
    }
    if (woodenbox1.collision(currentCoin)) { //if a coin is underneath the obstacle
      if (woodenbox1.x > 20) { //so the obstacle doesnt go off the screen
        woodenbox1.x = woodenbox1.x - 5; //minus 5 from the obstacle moving it left
      } else if (woodenbox1.x < width - 40) {
        woodenbox1.x = woodenbox1.x + 5;
      }
    }
    if (metalbox1.collision(currentCoin)) { //if a coin is underneath the obstacle
      if (metalbox1.x > 20) { //so the obstacle doesnt go off the screen
        metalbox1.x = metalbox1.x - 5; //minus 5 from the obstacle moving it left
      } else if (metalbox1.x < width - 40) {
        metalbox1.x = metalbox1.x + 5;
      }
    }
    if (woodenbox2.collision(currentCoin)) { //if a coin is underneath the obstacle
      if (woodenbox2.x > 20) { //so the obstacle doesnt go off the screen
        woodenbox2.x = woodenbox2.x - 5; //minus 5 from the obstacle moving it left
      } else if (woodenbox2.x < width - 40) {
        woodenbox2.x = woodenbox2.x + 5;
      }
    }
  }
}

void firstenemyspawn() {
  if (player1.x  < enemy1.x) { //if the x of the player is less than the x of the enemy
    enemy1.left(); //calls enemy left which is the specific set of images
    enemy1.x = enemy1.x - enemy1.Speed; //enemy will subtract the speed so it will be moving left
  } else if (player1.x  > enemy1.x) {
    enemy1.right();
    enemy1.x = enemy1.x +  enemy1.Speed;
  } else if (player1.y < enemy1.y) {
    enemy1.up();
    enemy1.y = enemy1.y -  enemy1.Speed;
  } else if (player1.y > enemy1.y) {
    enemy1.down();
    enemy1.y = enemy1.y +  enemy1.Speed;
  }
}

void secondenemyspawn() {
  if (player1.x  < enemy2.x) { //if the x of the player is less than the x of the enemy
    enemy2.left(); //calls enemy left which is the specific set of images
    enemy2.x = enemy2.x - enemy2.Speed; //enemy will subtract the speed so it will be moving left
  } else if (player1.x  > enemy2.x) {
    enemy2.right();
    enemy2.x = enemy2.x +  enemy2.Speed;
  } else if (player1.y < enemy2.y) {
    enemy2.up();
    enemy2.y = enemy2.y -  enemy2.Speed;
  } else if (player1.y > enemy2.y) {
    enemy2.down();
    enemy2.y = enemy2.y +  enemy2.Speed;
  }
}

void woodenboxcollision() {
  //woodenbox1 and woodenbox2 collision with player
  if (woodenbox1.collision(player1) && player1.up == true || woodenbox2.collision(player1) && player1.up == true) { //if a collision happens and the up key is pressed
    player1.y = player1.y + 5; //then the player1 y has 5 added to it which essentially stops the player moving any further up
  }
  if (woodenbox1.collision(player1) && player1.down == true || woodenbox2.collision(player1) && player1.down == true ) {
    player1.y = player1.y - 5;
  }
  if (woodenbox1.collision(player1) && player1.right == true || woodenbox2.collision(player1) && player1.right == true) {
    player1.x = player1.x - 5;
  }

  if (woodenbox1.collision(player1) && player1.left == true || woodenbox2.collision(player1) && player1.left == true) {
    player1.x = player1.x + 5;
  }
  //enemy1 and enemy2 collision with woodenbox1 and woodenbox2
  if (woodenbox1.collision(enemy1)) {
    if (woodenbox1.x < enemy1.x ) {//woodbox x position is greater than enemy x position so enemy is going left
      enemy1.x = enemy1.x + 5; //as the enemy moves left 5 will be added to the x position each time therefore keeping it in the same place
    } else if (woodenbox1.x > enemy1.x) {
      enemy1.x = enemy1.x - 5;
    } else if (woodenbox1.y < enemy1.y) {
      enemy1.y = enemy1.y + 5;
    } else if (woodenbox1.y > enemy1.y) {
      enemy1.y = enemy1.y - 5;
    }
  } else if (woodenbox1.collision(enemy2)) {
    if (woodenbox1.x < enemy2.x) {//enemy going left
      enemy2.x = enemy2.x + 5;
    } else if (woodenbox1.x > enemy2.x) {
      enemy2.x = enemy2.x - 5;
    } else if (woodenbox1.y < enemy2.y) {
      enemy2.y = enemy2.y + 5;
    } else if (woodenbox1.y > enemy2.y) {
      enemy2.y = enemy2.y - 5;
    }
  }

  if (woodenbox2.collision(enemy1)) {
    if (woodenbox2.x < enemy1.x ) {//woodbox x position is greater than enemy x position so enemy is going left
      enemy1.x = enemy1.x + 5; //as the enemy moves left 5 will be added to the x position each time therefore keeping it in the same place
    } else if (woodenbox2.x > enemy1.x) {
      enemy1.x = enemy1.x - 5;
    } else if (woodenbox2.y < enemy1.y) {
      enemy1.y = enemy1.y + 5;
    } else if (woodenbox2.y > enemy1.y) {
      enemy1.y = enemy1.y - 5;
    }
  } else if (woodenbox2.collision(enemy2)) {
    if (woodenbox2.x < enemy2.x) {//if enemy is going left
      enemy2.x = enemy2.x + 5;
    } else if (woodenbox2.x > enemy2.x) {
      enemy2.x = enemy2.x - 5;
    } else if (woodenbox2.y < enemy2.y) {
      enemy2.y = enemy2.y + 5;
    } else if (woodenbox2.y > enemy2.y) {
      enemy2.y = enemy2.y - 5;
    }
  }
}

void metalboxcollision() {
  //metalbox1 collision with player
  if (metalbox1.collision(player1) && player1.up == true) { //if a collision happens and the up key is pressed
    player1.y = player1.y + 5; //then the player1 y has 5 added to it which essentially stops the player moving any further up
  }
  if (metalbox1.collision(player1) && player1.down == true) {
    player1.y = player1.y - 5;
  }
  if (metalbox1.collision(player1) && player1.right == true) {
    player1.x = player1.x - 5;
  }

  if (metalbox1.collision(player1) && player1.left == true) {
    player1.x = player1.x + 5;
  }
  //enemy1 and enemy2 collision with metalbox1
  if (metalbox1.collision(enemy1)) {
    if (metalbox1.x < enemy1.x) {//enemy going left
      enemy1.x = enemy1.x + 5; //as the enemy moves left 5 will be added to the x position each time therefore keeping it in the same place
    } else if (metalbox1.x > enemy1.x) {
      enemy1.x = enemy1.x - 5;
    } else if (metalbox1.y < enemy1.y) {
      enemy1.y = enemy1.y + 5;
    } else if (metalbox1.y > enemy1.y) {
      enemy1.y = enemy1.y - 5;
    }
  } else if (metalbox1.collision(enemy2)) {
    if (metalbox1.x < enemy2.x) {//if enemy is going left
      enemy2.x = enemy2.x + 5;
    } else if (metalbox1.x > enemy2.x) {
      enemy2.x = enemy2.x - 5;
    } else if (metalbox1.y < enemy2.y) {
      enemy2.y = enemy2.y + 5;
    } else if (metalbox1.y > enemy2.y) {
      enemy2.y = enemy2.y - 5;
    }
  }
}

void drawbackground() {
  image(backGround, bgX, 0); //draw background
}
