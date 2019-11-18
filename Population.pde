class Population {
  Rocket[] rockets;
  int population;
  PVector end;
  ArrayList<Rocket> matingPool = new ArrayList();
  float totalAvgFit = 0;



  Population(Rocket[] rockets, int population, PVector end) {
    this.population = population;
    this.rockets = rockets;
    this.end = end;
  }

  Population(int population, PVector end, float mutationRate) {
    this.population = population;
    this.end = end;
    this.rockets = new Rocket[population];
    for (int i = 0; i < population; i++) {
      rockets[i] = new Rocket(end, mutationRate);
    }
  }

  void run() {
    for (int i = 0; i < rockets.length; i++) {
      rockets[i].update();
      rockets[i].show();
    }
  }

  Rocket[] selection() {
    Rocket[] newRockets = new Rocket[population];
    for (int i = 0; i < population; i++) {
      int index = floor(random(this.matingPool.size()));
      int index2 = floor(random(this.matingPool.size()));

      DNA parentA = this.matingPool.get(index).dna;
      DNA parentB = this.matingPool.get(index2).dna;

      DNA child = parentA.crossover(parentB);

      child.mutate();
      newRockets[i] = new Rocket(child, end);
    }
    return newRockets;
  }

  int findFinishers(Rocket[] rockets) {
    int sum = 0;
    for (int i = 0; i < rockets.length; i++) {
      if (rockets[i].finished) {
        sum++;
      }
    }
    return sum;
  }

  Rocket findFirst(Rocket[] rockets) {
    Rocket temp = new Rocket(end, mutationRate);
    float closestDist = 9999999;
    for (int i = 0; i < rockets.length; i++) {
      float d = dist(rockets[i].pos.x, rockets[i].pos.y, end.x, end.y);
      if (d < closestDist && !rockets[i].crashed) {
        closestDist = d;
        temp = rockets[i];
      }
    }
    for (int j = 0; j < rockets.length; j++) {
      if (rockets[j] != temp) {
        rockets[j].first = false;
      }
    }
    return temp;
  }

  Rocket[] getRockets() {
    return this.rockets;
  }

  DNA pickOne() {
    while (true) {
      float r = random(totalAvgFit);
      int index = floor(random(this.rockets.length));
      float probability = this.rockets[index].fitness;
      if (r < probability) {
        return this.rockets[index].dna;
      }
    }
  }

  void evaluate() {
    float maxFit = 0;
    for (int i = 0; i < rockets.length; i++) {
      rockets[i].calcFitness();
      if (rockets[i].fitness > maxFit) {
        maxFit = rockets[i].fitness;
      }
    }

    for (int i = 0; i < rockets.length; i++) {
      rockets[i].fitness /= maxFit;
      this.totalAvgFit += rockets[i].fitness;
    }

    for (int i = 0; i < rockets.length; i++) {
      int n = floor(rockets[i].fitness * 100);
      for (int j = 0; j < n; j++) {
        matingPool.add(this.rockets[i]);
      }
    }
  }

  boolean dead() {
    int count = 0;
    for (Rocket r : this.rockets) {
      if (r.crashed || r.finished) {
        count++;
      }
    }
    return count == this.rockets.length;
  }
}
