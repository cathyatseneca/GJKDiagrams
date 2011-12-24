class GridBackGround{
  void draw(){
    background(#FFFFFF);
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
  boolean moving;
  Circle(float x, float y, float r, color co){
    posX=x;
    posY=y;
    radius=r;
    outlinecolour=co;
    moving=false;
  }
  void draw(){
    float centreX=originX+(posX*5);
    float centreY=originY-(posY*5);
    stroke(outlinecolour);
    ellipse(centreX, centreY,radius*5,radius*5);
    line(centreX,centreY-5,centreX,centreY+5);
    line(centreX-5,centreY,centreX+5,centreY);
  }
  boolean onEdge(int x,int y){return true;}
  boolean onCentre(int x,int y){
    float centreX=originX+(posX*5);
    float centreY=originY-(posY*5);
    boolean rc=false;
    if(((x-centreX)*(x-centreX) + (y-centreY)*(y-centreY))<25){
      rc=true;
    }
    return rc;
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
Circle blueCircle=new Circle(5,5,10,#0000FF);
Circle redCircle=new Circle(10,10,20,#FF0000);
Circle greenCircle;
GridBackGround bg=new GridBackGround();
int canvasWidth=900;
int canvasHeight=500;
float originX=canvasWidth/2;
float originY=canvasHeight/2;
void setup(){
  size(canvasWidth,canvasHeight);
  noFill();
}
void draw(){
  bg.draw();
  blueCircle.draw();
  redCircle.draw();
 /* greenCircle.draw(); */
}
void mousePressed(){
   if(blueCircle.onCentre(mouseX,mouseY)){
      blueCircle.moving=true;
   }
   if(redCircle.onCentre(mouseX,mouseY)){
     redCircle.moving=true;
   }
}
void mouseDragged(){
  if(blueCircle.moving){
    blueCircle.posX=(mouseX-originX)/5;
    blueCircle.posY=(originY-mouseY)/5;
  }
  if(redCircle.moving){
    redCircle.posX=(mouseX-originX)/5;
    redCircle.posY=(originY-mouseY)/5;
  }
}
void mouseReleased(){
  blueCircle.moving=false;
  redCircle.moving=false;
}
