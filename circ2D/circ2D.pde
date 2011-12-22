class GridBackGround{
  void draw(){
    stroke(#00FFFF);
    int numAcross=canvasHeight/50;
    int numDown=canvasWidth/50;
    for(int i=0;i<numDown;i++){
      if(i==(numDown/2)-1){
        strokeWeight(3);               
        line((i*50)+50,0,(i*50)+50,canvasHeight);
        strokeWeight(1);
      }
      else{
        line((i*50)+50,0,(i*50)+50,canvasHeight);
      }
    }   
    for(int i=0;i<numAcross;i++){
      if(i==(numAcross/2)-1){
        strokeWeight(3);               
        line(0,(i*50)+50,canvasWidth,(i*50)+50);
        strokeWeight(1);
      }
      else{
        line(0,(i*50)+50,canvasWidth,(i*50)+50);
      }
    }   
     
  }
}

class Circle{
  float posX;  //in grid coordinate
  float posY;  //in grid coordinate;
  float radius;
  color outlinecolour;
  boolean selected;
  Circle(float x, float y, float r, color co){
    posX=x;
    posY=y;
    radius=r;
    outlinecolour=co;
    selected=false;
  }
  void draw(){
    stroke(outlinecolour);
    ellipse(originX+(posX*5), originY-(posY*5),radius*5,radius*5);
  }
}
class Vector{
  Circle from;
  Circle to;
  color vectorcolour;
  boolean pointed;
  void draw(){
    
  }
}
Circle blueCircle=new Circle(5,5,50,#0000FF);
Circle redCircle;
Circle greenCircle;
GridBackGround bg=new GridBackGround();
int canvasWidth=900;
int canvasHeight=500;
int originX=canvasWidth/2;
int originY=canvasHeight/2;
void setup(){
  size(canvasWidth,canvasHeight);
  noFill();
}
void draw(){
  bg.draw();
  blueCircle.draw();
 /*
  redCircle.draw();
  greenCircle.draw(); */
}
mousePressed(){
  if(value==0){
    if(blueCircle.onEdge(mouseX,mouseY))
      blueCircle.selected=true;
  }
}
mouseReleased(){
}
