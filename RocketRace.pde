Rocket rocket;
PVector end;

Population population = new Population(10);

void setup() {
  size(800, 600);
  end = new PVector(19*width/20,50);
}

void draw() {
  background(155);
  fill(0);
  ellipse(end.x,end.y,20,20);
  population.run();
}
