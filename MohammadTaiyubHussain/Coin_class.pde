class Coin {
  public int x, y;//members
  ArrayList<PImage>images; //store image files
  private int imageCounter = 0;

  //constructor
  Coin(int x, int y) {
    PImage  img;
    this.x = x;
    this.y = y;
    images = new ArrayList<PImage>();

    for (int count=1; count<=9; count++) { //9 images for coin animation
      img = loadImage("goldCoin" + count+".png");
      images.add(img);
    }
  }

  void render() {
    //choose next image to display 
    int imageNumber = imageCounter/10; //get position of image fromarraylist
    PImage currentImage = images.get(imageNumber);
    imageCounter ++;
    if (imageCounter==60)
    {
      imageCounter=0; //changes image counter back to 0 to give the effect the coin is moving
    }
    image(currentImage, this.x, this.y);
  }
}
