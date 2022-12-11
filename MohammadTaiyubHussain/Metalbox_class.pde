class Metalbox extends Obstacles {
  PImage img1;

  Metalbox(int x, int y) {
    super(x, y);
    //delegating the construction of Metalbox object to the superclass (Obstacles) constructor
    img1 = loadImage("metalbox.PNG");
    img1.resize(50, 50);
  }

  @Override//use render from this class rather than the parent class
    void render() {
    image(img1, this.x, this.y);
  }
}
