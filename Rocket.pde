class Rocket {
  DNA dna;

  PVector pos = new PVector();
  PVector vel = new PVector();
  PVector acc = new PVector();
  PVector start = new PVector(50, 540);
  PVector end;

  ArrayList<PVector> trail = new ArrayList();

  int offset = 5;
  int cycle = 400;
  int count = 0;
  int finishCount = 1;
  int crashPenaltyFactor = 10;

  boolean finished = false;
  boolean first = false;
  boolean crashed = false;

  float fitness;
  float[][] genes;
  float d;
  float maxVel = 4;

  Rocket(PVector end, float mutationRate) {
    pos = start;
    this.end = end;
    this.dna = new DNA(genes, mutationRate);
  }

  Rocket(DNA dna, PVector end) {
    pos = start;
    this.dna = dna;
    this.end = end;
  }


  void applyForce(float forceX, float forceY_1, float forceY_2) {
    float netForceY = forceY_1 - forceY_2;
    acc.add(forceX, netForceY, 0);
    acc.limit(0.4);
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
      count = 0;
    }
    if (!finished && !crashed) {
      vel.add(acc);
      pos.add(vel);
      acc.mult(0);
      vel.limit(maxVel);
      trail.add(new PVector(pos.x, pos.y));
      if (this.first) {
        drawTrail(trail.size());
      }
      float d = dist(pos.x, pos.y, end.x, end.y);
      if (d < 20) {
        finishCount = count;
        finished = true;
      }
      if (this.pos.x < 0 || this.pos.y < 0 ||
        this.pos.x > width || this.pos.y > height) 
      {
        this.crashed = true;
      }
    }
  }

  void calcFitness() {
    this.d = dist(pos.x, pos.y, end.x, end.y);
    if (!finished) {
      if (crashed) {
        this.fitness = 1/(this.d * this.crashPenaltyFactor);
      } else {
        this.fitness = 1/this.d;
      }
    } else {
      if (finishCount == 0) {
        finishCount = cycle - 1;
      }
      this.fitness = pow(float(cycle - finishCount), 3) / this.d;
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
