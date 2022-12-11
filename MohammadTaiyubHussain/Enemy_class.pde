class Enemy {
  public int x, y;//members
  ArrayList<PImage>images, images2, images3, images4; //store image files
  private int imageCounter = 0;
  //refactoring
  final int Speed = 1; //constant

  //constructor
  Enemy(int x, int y) {
    PImage  img;
    this.x = x;
    this.y = y;
    //four different arraylists for the four different sets of movement images
    //up,down,left,right
    images = new ArrayList<PImage>();
    images2 = new ArrayList<PImage>();
    images3 = new ArrayList<PImage>();
    images4 = new ArrayList<PImage>();

    for (int count=1; count<=3; count++) {
      img = loadImage("wolfman" + count+".png");
      images.add(img);
      //(make enemy smaller)
      img.resize(40,80); 
    }
    for (int count=4; count<=6; count++) {
      img = loadImage("wolfman" + count+".png");
      images2.add(img);
      img.resize(40,80);
    }
    for (int count=7; count<=9; count++) {
      img = loadImage("wolfman" + count+".png");
      images3.add(img);
      img.resize(40,80);
    }
    for (int count=10; count<=12; count++) {
      img = loadImage("wolfman" + count+".png");
      images4.add(img);
      img.resize(40,80);
    }
  }

  void left() {
    //choose next image to display
    int imageNumber = imageCounter/10; //get position of image fromarraylist
    PImage currentImage = images.get(imageNumber);
    imageCounter ++;
    if (imageCounter==30)
    {
      imageCounter=0;
    }
    image(currentImage, this.x, this.y);
  }

  void right() {
    //choose next image to display
    int imageNumber = imageCounter/10; //get position of image fromarraylist
    PImage currentImage = images2.get(imageNumber);
    imageCounter ++;
    if (imageCounter==30)
    {
      imageCounter=0;
    }
    image(currentImage, this.x, this.y);
  }

  void up() {
    //choose next image to display
    int imageNumber = imageCounter/10; //get position of image fromarraylist
    PImage currentImage = images3.get(imageNumber);
    imageCounter ++;
    if (imageCounter==30)
    {
      imageCounter=0;
    }
    image(currentImage, this.x, this.y);
  }
  void down() {
    //choose next image to display
    int imageNumber = imageCounter/10; //get position of image fromarraylist
    PImage currentImage = images4.get(imageNumber);
    imageCounter ++;
    if (imageCounter==30)
    {
      imageCounter=0;
    }
    image(currentImage, this.x, this.y);
  }

  //checks to see whether Player x minus coin x is smaller than 35 and does the same for y
  //takes into account size of enemy and size of player
  //returns true or false for the absolute value
  boolean collision(Player player) {
    return abs(player.x - this.x) < 35 && abs(player.y - this.y) < 35;
  }
}
