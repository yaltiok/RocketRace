class Rocket {
  PVector pos;
  PVector vel = PVector.random2D().mult(10);
  PVector acc = new PVector();
  PVector start = new PVector(50,540);
  int offset = 5;
  float maxVel = 4;
  DNA dna;


  Rocket() {
    pos = start;
    this.dna = new DNA();
  }


  void applyForce(float forceX, float forceY) {
    acc.add(forceX, forceY, 0);
  }

  void update() {
    vel.add(acc);
    pos.add(vel);
    acc.mult(0);
    vel.limit(maxVel);
  }

  void show() {
    push();
    fill(75, 0, 130, 100);
    translate(pos.x,pos.y);
    rotate(vel.heading());
    rectMode(CENTER);
    noStroke();
    triangle(-1 * (2*offset),-1 * offset,(2*offset), 0,-1 * (2*offset),offset);
    pop();
  }
}
