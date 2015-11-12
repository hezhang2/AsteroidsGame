//your variable declarations here
SpaceShip fish = new SpaceShip();
public void setup() {
  noStroke();
  size(600,600);
}
public void draw() {
  background(#5378AA);

  fish.show();
  fish.move();
  fish.keyPressed();
  System.out.println(fish.iA);
  fish.fadeA();
  fish.fadeB();
}
public void keyReleased(){
  if(key==' '){
    fish.fadeA(true);
    fish.hyperSpace(true);
    fish.fadeB(true);
  }
}

class SpaceShip extends Floater  {
  private boolean canHy, isFading, hyperSpaceMode;
  private int myT,iA; 
  SpaceShip(){
    myCenterX=300;
    myCenterY=300;
    myDirectionX=0;
    myDirectionY=0;
    myPointDirection=0;

    myT=0;
    iA = 0;
    myColor=color(40,65,99);

    corners=12;
    xCorners = new int[12];
    yCorners = new int[12];
    xCorners[0]=0+25;
    yCorners[0]=0;
    xCorners[1]=-10+25;
    yCorners[1]=8;
    xCorners[2]=-30+25;
    yCorners[2]=10;
    xCorners[3]=-40+25;
    yCorners[3]=0;
    xCorners[4]=-50+25;
    yCorners[4]=10;
    xCorners[5]=-48+25;
    yCorners[5]=3;
    xCorners[6]=-40+25;
    yCorners[6]=0;
    xCorners[7]=-48+25;
    yCorners[7]=-3;
    xCorners[8]=-50+25;
    yCorners[8]=-10;
    xCorners[9]=-40+25;
    yCorners[9]=0;
    xCorners[10]=-30+25;
    yCorners[10]=-10;
    xCorners[11]=-10+25;
    yCorners[11]=-8;

    canHy=true;
    isFading=false;
    iA=0;
  }

  public void keyPressed(){
    if(key=='w'&&keyPressed==true){accelerate(.05);}
    if(key=='a'&&keyPressed==true){
      rotate(-1);
    }else if(key=='d'&&keyPressed==true){
      rotate(1);
    }else{
      rotate(0);
    }
    if(key=='s'&&keyPressed==true){accelerate(-.05);}
  }
  public void fadeA(boolean mode){
    if(iA<127){
      myT=(int)(255*sin(iA*50));
      iA++;
    }
  }
  }public void fadeB(boolean mode){
    if(iA<255){
      myT=(int)(255*sin(iA*50));
      iA++;
    }
  }
  public void hyperSpace(boolean mode){
    hyperSpaceMode=mode;

    if(hyperSpaceMode==true){
      myCenterX=(int)(Math.random()*width);
      myCenterY=(int)(Math.random()*height);
      myDirectionX=0;
      myDirectionY=0;
      myPointDirection=(int)(Math.random()*360);
    }
    hyperSpaceMode=false;
  }
  public void setX(int x){myCenterX=x;}  
  public int getX(){return (int)myCenterX;}   
  public void setY(int y){myCenterY=y;}   
  public int getY(){return (int)myCenterY;}   
  public void setDirectionX(double x){myDirectionX=x;}   
  public double getDirectionX(){return myDirectionX;}
  public void setDirectionY(double y){myDirectionY=y;}  
  public double getDirectionY(){return myDirectionY;}
  public void setPointDirection(int degrees){myPointDirection=degrees;}
  public double getPointDirection(){return myPointDirection;} 
}
abstract class Floater //Do NOT modify the Floater class! Make changes in the SpaceShip class 
{   
  protected int corners;  //the number of corners, a triangular floater has 3   
  protected int[] xCorners;   
  protected int[] yCorners;   
  protected int myColor;   
  protected double myCenterX, myCenterY; //holds center coordinates   
  protected double myDirectionX, myDirectionY; //holds x and y coordinates of the vector for direction of travel   
  protected double myPointDirection; //holds current direction the ship is pointing in degrees    
  abstract public void setX(int x);  
  abstract public int getX();   
  abstract public void setY(int y);   
  abstract public int getY();   
  abstract public void setDirectionX(double x);   
  abstract public double getDirectionX();   
  abstract public void setDirectionY(double y);   
  abstract public double getDirectionY();   
  abstract public void setPointDirection(int degrees);   
  abstract public double getPointDirection(); 

  //Accelerates the floater in the direction it is pointing (myPointDirection)   
  public void accelerate (double dAmount)   
  {          
    //convert the current direction the floater is pointing to radians    
    double dRadians =myPointDirection*(Math.PI/180);     
    //change coordinates of direction of travel    
    myDirectionX += ((dAmount) * Math.cos(dRadians));    
    myDirectionY += ((dAmount) * Math.sin(dRadians));       
  }   
  public void rotate (int nDegreesOfRotation)   
  {     
    //rotates the floater by a given number of degrees    
    myPointDirection+=nDegreesOfRotation;   
  }   
  public void move ()   //move the floater in the current direction of travel
  {      
    //change the x and y coordinates by myDirectionX and myDirectionY       
    myCenterX += myDirectionX;    
    myCenterY += myDirectionY;     

    //wrap around screen    
    if(myCenterX >width)
    {     
      myCenterX = 0;    
    }    
    else if (myCenterX<0)
    {     
      myCenterX = width;    
    }    
    if(myCenterY >height)
    {    
      myCenterY = 0;    
    }   
    else if (myCenterY < 0)
    {     
      myCenterY = height;    
    }   
  }   
  public void show ()  //Draws the floater at the current position  
  {             
    fill(myColor);   
    stroke(myColor);    
    //convert degrees to radians for sin and cos         
    double dRadians = myPointDirection*(Math.PI/180);                 
    int xRotatedTranslated, yRotatedTranslated;    
    beginShape();         
    for(int nI = 0; nI < corners; nI++)    
    {     
      //rotate and translate the coordinates of the floater using current direction 
      xRotatedTranslated = (int)((xCorners[nI]* Math.cos(dRadians)) - (yCorners[nI] * Math.sin(dRadians))+myCenterX);     
      yRotatedTranslated = (int)((xCorners[nI]* Math.sin(dRadians)) + (yCorners[nI] * Math.cos(dRadians))+myCenterY);      
      vertex(xRotatedTranslated,yRotatedTranslated);    
    }   
    endShape(CLOSE);  
  }   
} 

