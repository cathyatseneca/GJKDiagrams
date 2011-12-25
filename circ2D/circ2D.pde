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
  float centreX(){return originX+(posX*5);}
  float centreY(){return originY-(posY*5);}
  void draw(){
    float cX=centreX();
    float cY=centreY();
    stroke(outlinecolour);
    ellipse(cX, cY,radius*5,radius*5);
    line(cX,cY-5,cX,cY+5);
    line(cX-5,cY,cX+5,cY);
  }
  boolean onEdge(int x,int y){return true;}
  boolean onCentre(int x,int y){
    float cX=centreX();
    float cY=centreY();
    boolean rc=false;
    if(((x-cX)*(x-cX) + (y-cY)*(y-cY))<25){
      rc=true;
    }
    return rc;
  }
}

class Vector{
  float fromX;
  float toX;
  float fromY;
  float toY;
  color vectorColour;
  boolean pointed;
  Vector(float fx,float fy,float tx,float ty,color co,boolean p){
    fromX=fx;
    fromY=fy;
    toX=tx;
    toY=ty;
    vectorColour=co;
    pointed=p;
  }
  void setFrom(float fx,float fy){
    fromX=fx;
    fromY=fy;
  }
  void setTo(float tx,float ty){
    toX=tx;
    toY=ty;
  }
  void draw(){
      stroke(vectorColour);
      line(fromX,fromY,toX,toY);
      float len=sqrt((fromX-toX)*(fromX-toX)+(fromY-toY)*(fromY-toY));
      pushMatrix();
      translate(toX,toY);
      rotate((3*PI)/4);
      line(((toX-fromX)/len)*10,((toY-fromY)/len)*10,0,0);
      rotate((-6*PI)/4);
      line(((toX-fromX)/len)*10,((toY-fromY)/len)*10,0,0);
      popMatrix();      
    }
}
Circle blueCircle=new Circle(5,5,10,#0000FF);
Circle redCircle=new Circle(10,10,20,#FF0000);
Vector crcb=new Vector(blueCircle.centreX(),blueCircle.centreY(),redCircle.centreX(),redCircle.centreY(),#000000,true);
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
  crcb.setFrom(blueCircle.centreX(),blueCircle.centreY());
  crcb.setTo(redCircle.centreX(),redCircle.centreY());
  bg.draw();
  blueCircle.draw();
  redCircle.draw();
  crcb.draw();
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
