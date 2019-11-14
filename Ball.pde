class Ball extends Obstacle {
  int x, y, w, h, r;
  PVector pos;



  Ball(int x, int y, int r) {
    this.x = x;
    this.y = y;
    this.w = r*2;
    this.h = r*2;
    this.r = r;
    pos = new PVector(x, y);
  }

  @Override void show() {
    fill(255);
    ellipse(x, y, w, h);
  }


  @Override void checkCollision(Rocket[] rockets) {
    for (Rocket rocket : rockets) {
      PVector distanceVect = PVector.sub(rocket.pos, this.pos);
      //println(distanceVect);
      float distanceVectMag = distanceVect.mag();

      float minDistance = this.r;
      if (distanceVectMag < minDistance && !rocket.crashed) {
        rocket.crashed = true;
      }
    }
  }
}
