class Rocket {
  DNA dna;

  PVector pos = new PVector();
  PVector vel = new PVector();
  PVector acc = new PVector();
  PVector start = new PVector(50, 540);
  PVector end;

  ArrayList<PVector> trail = new ArrayList();
  
  int offset = 5;
  int cycle = 300;
  int count = 0;
  int finishCount = 1;

  boolean finished = false;
  boolean first = false;
  
  float fitness;
  float[][] genes;
  float d;
  float maxVel = 4;

  Rocket(PVector end) {
    pos = start;
    this.end = end;
    this.dna = new DNA(genes);
  }

  Rocket(DNA dna, PVector end) {
    pos = start;
    this.dna = dna;
    this.end = end;
  }


  void applyForce(float forceX, float forceY_1, float forceY_2) {
    float netForceY = forceY_1 - forceY_2;
    acc.add(forceX, netForceY, 0);
  }


  void show() {
    push();
    fill(75, 0, 130, 100);
    translate(pos.x, pos.y);
    rotate(vel.heading());
    rectMode(CENTER);
    if (first) {
      fill(255);
    }
    noStroke();
    triangle(-1 * (2*offset), -1 * offset, (2*offset), 0, -1 * (2*offset), offset);
    pop();
  }

  void update() {

    applyForce(dna.genes[count][0], dna.genes[count][1], dna.genes[count][2]);
    count++;
    if (count == cycle) {
      pos = start;
      count = 0;
    }
    if (!finished) {
      vel.add(acc);
      pos.add(vel);
      acc.mult(0);
      vel.limit(maxVel);
      trail.add(new PVector(pos.x, pos.y));
      drawTrail(trail.size());
      if (trail.size() > 100) {
        trail.remove(0);
      }
      float d = dist(pos.x, pos.y, end.x, end.y);
      if (d < 5) {
        this.pos = end.copy();
        d = 1;
        finishCount = count;
        finished = true;
      }
    }
  }

  void calcFitness() {
    this.d = dist(pos.x, pos.y, end.x, end.y);
    if (!finished) {
      this.fitness = 1/this.d;
    } else {
      this.fitness = float(finishCount) + 1.0 / this.d;
    }
  }

  void drawTrail(int size) {
    noFill();
    stroke(0, 100);
    beginShape();
    for (int i = 0; i < size; i++) {
      PVector v = trail.get(i);
      curveVertex(v.x, v.y);
    }
    endShape();
  }
}
