class Triangle extends Obstacle{
  int x1,y1,x2,y2,x3,y3;
  
  
  Triangle(int x1,int y1,int x2, int y2,int x3,int y3){
    this.x1 = x1;
    this.y1 = y1;
    this.x2 = x2;
    this.y2 = y2;
    this.x3 = x3;
    this.y3 = y3;
    
  }
  
  @Override void show(){
    fill(255);
    triangle(x1,y1,x2,y2,x3,y3);
  }
  
  
  @Override void checkCollision(Rocket[] rockets){
  
  }

}
