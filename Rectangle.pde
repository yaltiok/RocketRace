class Rectangle extends Obstacle{
  int x,y,w,h;
  
  
  Rectangle(int x,int y,int w, int h){
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    
  }
  
  @Override void show(){
    fill(255);
    rect(x,y,w,h);
  }
  
  
  @Override void checkCollision(Rocket[] rockets){
  
  }

}
