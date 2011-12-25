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
  boolean doFill;
  color outlinecolour;
  boolean moving;
  boolean scaling;
  Circle(float x, float y, float r, color co){
    posX=x;
    posY=y;
    radius=r;
    scaling=false;
    outlinecolour=co;
    moving=false;
    doFill=false;
  }
  void setFill(boolean df){
    doFill=df;
  }
  float centreX(){return originX+(posX*5);}
  float centreY(){return originY-(posY*5);}
  void draw(){
    float cX=centreX();
    float cY=centreY();
    stroke(outlinecolour);
  
    if(doFill){
 
      fill(outlinecolour,50);
    }
    else{
      noFill();
    }
    ellipse(cX, cY,radius*10,radius*10);
    line(cX,cY-5,cX,cY+5);
    line(cX-5,cY,cX+5,cY);
  }
  void setPos(float x,float y){
    posX=x;
    posY=y;
  }
  void setRadius(float r){
    radius=r;
  }
  boolean onEdge(int x,int y){
    float cX=centreX();
    float cY=centreY();
    float dist=sqrt((x-cX)*(x-cX)+(y-cY)*(y-cY));
    boolean rc=false;
    if(dist > (radius*5)-5 && dist < (radius*5)+5){
      rc=true;
    }
    return rc;
     
  }
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
int canvasWidth=900;
int canvasHeight=500;
float originX=canvasWidth/2;
float originY=canvasHeight/2;
Circle blueCircle=new Circle(30,30,20,#0000FF);
Circle redCircle=new Circle(60,10,10,#FF0000);
Circle greenCircle=new Circle(redCircle.posX-blueCircle.posX,redCircle.posY-blueCircle.posY,30,#00FF00);
Vector crcb=new Vector(blueCircle.centreX(),blueCircle.centreY(),redCircle.centreX(),redCircle.centreY(),#00FF00,true);
Vector cb=new Vector(originX,originY,blueCircle.centreX(),blueCircle.centreY(),#0000FF,true);
Vector cr=new Vector(originX,originY,redCircle.centreX(),redCircle.centreY(),#FF0000,true);
Vector cg=new Vector(originX,originY,greenCircle.centreX(),greenCircle.centreY(),#00FF00,true);

GridBackGround bg=new GridBackGround();

void setup(){
  size(canvasWidth,canvasHeight);
}
void draw(){
  crcb.setFrom(blueCircle.centreX(),blueCircle.centreY());
  crcb.setTo(redCircle.centreX(),redCircle.centreY());
  cr.setTo(redCircle.centreX(),redCircle.centreY());
  cb.setTo(blueCircle.centreX(),blueCircle.centreY());
  cg.setTo(greenCircle.centreX(),greenCircle.centreY());
  greenCircle.setPos(redCircle.posX-blueCircle.posX,redCircle.posY-blueCircle.posY);
  greenCircle.setRadius(blueCircle.radius+redCircle.radius);
 
  if(sqrt(greenCircle.posX*greenCircle.posX+greenCircle.posY*greenCircle.posY)<redCircle.radius+blueCircle.radius){
    greenCircle.setFill(true);
  }
  else{
    greenCircle.setFill(false);
  }
  bg.draw();
  blueCircle.draw();
  redCircle.draw();
  greenCircle.draw();
  crcb.draw();
  cr.draw();
  cb.draw();
  cg.draw();
 /* greenCircle.draw(); */
}
void mousePressed(){
   if(blueCircle.onCentre(mouseX,mouseY)){
      blueCircle.moving=true;
   }
   else if(redCircle.onCentre(mouseX,mouseY)){
     redCircle.moving=true;
   }
   else if(blueCircle.onEdge(mouseX,mouseY)){
     blueCircle.scaling=true;
   }
   else if(redCircle.onEdge(mouseX,mouseY)){
     redCircle.scaling=true;
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
  if(blueCircle.scaling){
    float x=(mouseX-blueCircle.centreX());
    float y=(mouseY-blueCircle.centreY());
    blueCircle.radius=(sqrt(x*x+y*y)/5);
  }
  if(redCircle.scaling){
    float x=(mouseX-redCircle.centreX());
    float y=(mouseY-redCircle.centreY());
    redCircle.radius=(sqrt(x*x+y*y)/5);
  }
}
void mouseReleased(){
  blueCircle.moving=false;
  redCircle.moving=false;
  blueCircle.scaling=false;
  redCircle.scaling=false;
}
