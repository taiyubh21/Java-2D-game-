class Player { //<>//
  public int x, y;
  final int Speed = 3;//constant
  ArrayList<PImage>images, images2, images3, images4, images5; //store image files
  boolean left, right, up, down;
  private int imageCounter, rightCounter, leftCounter, upCounter, downCounter;

  Player(int x, int y) {
    PImage img;
    this.x = x;
    this.y = y;
    images = new ArrayList<PImage>(); //arraylist for each set of images
    images2 = new ArrayList<PImage>();
    images3 = new ArrayList<PImage>();
    images4 = new ArrayList<PImage>();
    images5 = new ArrayList<PImage>();
    for (int count=1; count<=2; count++) { //for the certain set of images
      img = loadImage("character" + count+".png");
      images.add(img);
    }
    for (int count=3; count<=6; count++) {
      img = loadImage("character" + count+".png");
      images2.add(img);
    }
    for (int count=7; count<=10; count++) {
      img = loadImage("character" + count+".png");
      images3.add(img);
    }
    for (int count=11; count<=12; count++) {
      img = loadImage("character" + count+".png");
      images4.add(img);
    }
    for (int count=13; count<=14; count++) {
      img = loadImage("character" + count+".png");
      images5.add(img);
    }
  }

  void render() {//idle image
    //choose next image to display 
    int imageNumber = imageCounter/15; //get position of image fromarraylist
    PImage currentImage = images.get(imageNumber);
    imageCounter ++;
    if (imageCounter==30)
      imageCounter=0;
    image(currentImage, this.x, this.y);
  }

  void right() {//images when player is moving right
    //choose next image to display 
    int imageNumber = rightCounter/10; //get position of image fromarraylist
    PImage currentImage = images2.get(imageNumber);
    rightCounter ++;
    if (rightCounter==30)
      rightCounter=0;
    image(currentImage, this.x, this.y);
  }

  void left() {
    //choose next image to display 
    int imageNumber = leftCounter/10; //get position of image fromarraylist
    PImage currentImage = images3.get(imageNumber);
    leftCounter ++;
    if (leftCounter==30)
      leftCounter=0;
    image(currentImage, this.x, this.y);
  } 

  void up() {
    //choose next image to display 
    int imageNumber = upCounter/15; //get position of image fromarraylist
    PImage currentImage = images4.get(imageNumber);
    upCounter ++;
    if (upCounter==30)
      upCounter=0;
    image(currentImage, this.x, this.y);
  } 

  void down() {
    //choose next image to display
    int imageNumber = downCounter/15; //get position of image fromarraylist
    PImage currentImage = images5.get(imageNumber);
    downCounter ++;
    if (downCounter==30)
      downCounter=0;
    image(currentImage, this.x, this.y);
  } 

  void move() {
    //convert boolean values to integers ( 1 for true and 0 for false)
    //if right is false(0) and left is true(1), x becomes -1(0 subtract 1) to move it left along with the left axis  (vice versa if right is true and left is false)
    this.x = this.x + this.Speed*(int(right)-int(left)); 
    //same for up and down
    this.y = this.y + this.Speed*(int(down)-int(up));
  }

  void update() {
    //if boolean is true then go to that procedure otherwise render idle image
    if (right == true && this.x < width - 30) { //stops at screen edge
      up = false; //two keys cannot be pressed at the same time
      down = false;//without this if a horizontal and vertical key were both pressed simultaneously then the player would move diagonally
      right();//calls procedure for right direction
      move();
    } else if (left == true && this.x > 10) {
      left();
      up = false;
      down = false;
      move();
    } else if (up == true && this.y > 10) {
      right = false;
      left = false;
      up();
      move();
    } else if (down == true && this.y < height - 50) {
      right = false;
      left = false;
      down();
      move();
    } else {
      render(); //keep idle
    }
  }

  boolean keypressed(boolean keyboard) {
    if (key == CODED) {
      if (keyCode == RIGHT) {//if right is true then the image will move right along the x axis
        return right = keyboard; //passes through keypressed in main as a key has been pressed - true
      } else if (keyCode == LEFT) {
        return left = keyboard;
      } else if (keyCode == UP) {
        return up = keyboard;
      } else if (keyCode == DOWN) {
        return down = keyboard;
      }
    }
    return keyboard= false; //when key isn't pressed return keyboard through keyreleased which is false
  }

  //checks to see whether Player x minus coin x is smaller than 25 and does the same for y for 35
  //takes into account size of player and size of coin
  //returns true or false for the absolute value
  boolean collect(Coin coin) {
    return abs(this.x-coin.x) < 25 && abs(this.y - coin.y) < 30;
  }
}
