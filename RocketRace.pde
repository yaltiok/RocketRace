Rocket rocket;
PVector end;
Rocket[] rockets;
int rocketCount = 25;
int cycle = 300;
int count = 0;
int generationCount = 0;

Population population;

void setup() {
  size(800, 600);

  end = new PVector(19*width/20, 50);
  population = new Population(rocketCount, end);
  this.rockets = population.getRockets();
}

void draw() {
  background(155);
  //frameRate(1);
  fill(0);
  ellipse(end.x, end.y, 20, 20);
  push();
  strokeWeight(32);
  text("Generation : " + generationCount,50,50);
  text("Lifespan : " + (cycle - count),50,65);
  pop();
  population.run();
  population.findFirst(this.rockets).first = true;
  
  count++;
  if(count == cycle){
    population.evaluate();
    this.rockets = population.selection();
    population = new Population(rockets, rocketCount, end);
    generationCount++;
    count = 0;
  }
}
