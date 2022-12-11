//inheritance for Metalbox and Woodenbox
class Obstacles {
  public int x, y;

  Obstacles(int x, int y) {
    this.x = x;
    this.y = y;
  }

  void render() {
    //what is the image for the obstacle
  }

  //(refactoring)
  //collisions for both classes are the same as the two different obstacles are the same size so best to add it here
  boolean collision(Player player) {
    return abs(player.x - this.x) < 40 && abs(player.y - this.y) < 50; //collision to stop player going through the obstacle
  }

  boolean collision(Enemy enemy) {
    return abs(enemy.x - this.x) < 40 && abs(enemy.y - this.y) < 40; //collision to stop enemy going through the obstacle
  }

  boolean collision(Coin coin) {
    return abs(coin.x - this.x) < 70 && abs(coin.y - this.y) < 70; //collision for coins underneath the obstacle
  }
}
