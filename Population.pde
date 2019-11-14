class Population {
  Rocket[] rockets;
  int population;
  PVector end;
  ArrayList<Rocket> matingPool = new ArrayList();



  Population(Rocket[] rockets, int population, PVector end) {
    this.population = population;
    this.rockets = rockets;
    this.end = end;
  }

  Population(int population, PVector end) {
    this.population = population;
    this.end = end;
    this.rockets = new Rocket[population];
    for (int i = 0; i < population; i++) {
      rockets[i] = new Rocket(end);
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
      int index = floor(random(matingPool.size()));
      int index2 = floor(random(matingPool.size()));
      DNA parentA = matingPool.get(index).dna;
      DNA parentB = matingPool.get(index2).dna;

      DNA child = parentA.crossover(parentB);

      child.mutate();
      newRockets[i] = new Rocket(child, end);
    }
    return newRockets;
  }

  Rocket findFirst(Rocket[] rockets) {
    Rocket temp = new Rocket(end);
    float closestDist = 9999999;
    for (int i = 0; i < rockets.length; i++) {
      float d = dist(rockets[i].pos.x, rockets[i].pos.y, end.x, end.y);
      if (d < closestDist) {
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

  void evaluate() {
    float maxFit = 0;
    for (int i = 0; i < rockets.length; i++) {
      rockets[i].calcFitness();
      if (rockets[i].fitness > maxFit) {
        maxFit = rockets[i].fitness;
      }
    }
    //println("-----------------------------------");

    for (int i = 0; i < rockets.length; i++) {
      rockets[i].fitness = rockets[i].fitness / maxFit;
      //println(rockets[i].fitness);
    }
    //println(maxFit);
    //println("-----------------------------------");
    for (int i = 0; i < rockets.length; i++) {
      int n = floor(rockets[i].fitness * 100);
      for (int j = 0; j < n; j++) {
        matingPool.add(rockets[i]);
      }
    }
  }
}
