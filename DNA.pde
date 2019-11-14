class DNA {


  float[][] genes;
  int cycle = 300;
  float mutationRate;


  DNA(float[][] genes,float mutationRate) {
    this.mutationRate = mutationRate;
    if (genes != null) {
      this.genes = genes;
    } else {
      this.genes = new float[cycle][3];
      for (int i = 0; i < cycle; i++) {
        for (int j = 0; j < 3; j++) {
          this.genes[i][j] = random(-1, 1);
        }
      }
    }
  }

  void mutate() {

    for (int i = 0; i < this.genes.length; i++) {
      if (random(1) < this.mutationRate) {
        for (int j = 0; j < 3; j++) {
          this.genes[i][j] = random(-1, 1);
        }
      }
    }
  }

  DNA crossover(DNA parentB) {
    float[][] newGenes = new float[cycle][3];
    for (int j = 0; j < 3; j++) {
      //int mid = floor(random(genes.length));
      boolean turn = random(1) < 0.5;
      for (int i = 0; i < genes.length; i++) {
        if (turn) {
          newGenes[i][j] = this.genes[i][j];
        } else {
          newGenes[i][j] = parentB.genes[i][j];
        }
        turn = !turn;
      }
    }
    return new DNA(newGenes,this.mutationRate);
  }
}
