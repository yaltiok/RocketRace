class Population {
  Rocket[] rockets;
  int population;


  Population(int population) {
    this.population = population;
    rockets = createGen(rockets, population);
  }

  void run() {
    for (int i = 0; i < rockets.length; i++) {
      rockets[i].show();
      rockets[i].update();
    }
  }


  Rocket[] createGen(Rocket[] rockets, int population) {
    if (rockets != null) {
    } else {
      rockets = new Rocket[population];
      for (int i = 0; i < population; i++) {
        rockets[i] = new Rocket();
      }
    }
    return rockets;
  }
}
