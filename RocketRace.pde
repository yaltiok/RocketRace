Rocket rocket;
PVector end;
Rocket[] rockets;
int rocketCount = 25;
int cycle = 400;
int count = 0;
int generationCount = 0;
int finisherCount = 0;
int lastFinisherCount = 0;
float mutationRate = 0.04;

ArrayList<Obstacle> obstacleList;

Population population;

void setup() {
  size(800, 600);

  end = new PVector(19*width/20, 50);
  population = new Population(rocketCount, end, mutationRate);
  obstacleList = new ArrayList();
  setupMap();
}

void draw() {
  background(155);
  //frameRate(7);
  this.rockets = population.getRockets();
  updateMap(obstacleList);
  fill(0);
  ellipse(end.x, end.y, 40, 40);
  push();
  strokeWeight(32);
  
  text("Mutation Rate : " + "0.04%",50,35);
  text("Generation : " + generationCount, 50, 50);
  text("Lifespan : " + (cycle - count), 50, 65);
  text("Finishers : " + finisherCount, 50, 80);
  text("Finishers Last Round : " + lastFinisherCount, 50, 95);

  pop();
  population.run();
  population.findFirst(this.rockets).first = true;
  finisherCount = population.findFinishers(this.rockets);
  count++;
  if (count == cycle || population.dead()) {
    lastFinisherCount = 0;
    population.evaluate();
    this.rockets = population.selection();
    population = new Population(rockets, rocketCount, end);
    generationCount++;
    lastFinisherCount = finisherCount;
    count = 0;
  }
}

void updateMap(ArrayList<Obstacle> obstacles) {
  for (Obstacle o : obstacles) {
    o.show();
    o.checkCollision(rockets);
  }
}
void setupMap() {
  for(int i = 0; i < 10;i++){
    obstacleList.add(new Ball(floor(random(10,width)),
    floor(random(10,height)),
    floor(random(15,45))));
  }
}
