//your variable declarations here
SpaceShip fish = new SpaceShip();
Star leaves [] = new Star[20];

ArrayList <Asteroid> lilypads = new ArrayList<Asteroid>();
ArrayList <Bullet> bubbles = new ArrayList<Bullet>();

public void setup() {
  noStroke();
  size(800, 600);

  for(int i=0;i<leaves.length;i++)
    leaves[i]=new Star();

  for(int i=0;i<10;i++)
    lilypads.add(new Asteroid());
}
public void draw() {
  background(#5378AA);

  for(Bullet tempBubbles: bubbles){
    tempBubbles.show();
    tempBubbles.move();
  }
  for(int nI=0;nI<bubbles.size();nI++){
    if(bubbles.get(nI).getX()<-4||bubbles.get(nI).getX()>800-4||
       bubbles.get(nI).getY()<-4||bubbles.get(nI).getY()>600-4){
      bubbles.remove(nI);
      nI--;
    }
  }

  fish.show();
  fish.move();
  fish.motion();

  for(Asteroid tempLilypads: lilypads){
    tempLilypads.show();
    tempLilypads.move();
    tempLilypads.rotate(1);
  }

  for(int nI=0;nI<lilypads.size();nI++){
    for(int i=0;i<bubbles.size();i++){
      if(Math.abs(lilypads.get(nI).getX()-bubbles.get(i).getX())<7.5&&
         Math.abs(lilypads.get(nI).getY()-bubbles.get(i).getY())<7.5){
        lilypads.remove(nI);
        bubbles.remove(i);
      }
    }
  }
  for(int nI=0;nI<lilypads.size();nI++){
    if(Math.abs(lilypads.get(nI).getX()-fish.getX())<16&&
       Math.abs(lilypads.get(nI).getY()-fish.getY())<16){
      lilypads.remove(nI);
      nI--;
    }
  }

  for(int i=0;i<leaves.length;i++){
    leaves[i].show();
    leaves[i].move();
    leaves[i].wrap();
  }
}
public void keyPressed(){
  if(key=='w')
    fish.setAccelerating(1);
  
  if(key=='s')
    fish.setAccelerating(-1);
  
  if(key=='a')
    fish.setRotating(-1);
  
  if(key=='d')
    fish.setRotating(1);
}
public void keyReleased() {
  if(key=='w'||key=='s')
    fish.setAccelerating(0);
  
  if(key=='a'||key=='d')
    fish.setRotating(0);
  
  if(key=='e')
    fish.hyperSpace(true);
  
  if(key==' ')
    bubbles.add(new Bullet(fish));
}

class Star{
  private float myX,myY,mySize,myOpacity,xSpeed;
  Star(){
    myX=(float)(Math.random()*800);
    myY=(float)(Math.random()*600);
    mySize=(float)(Math.random()*20+100);
    myOpacity=(float)(Math.random()*50+70);
    xSpeed=(float)(Math.random()*.3+.05);
  }
  public void show(){
    noStroke();
    fill(40, 65, 99, myOpacity);
    ellipse(myX,myY,mySize,mySize);
  }
  public void move(){
    myX+=xSpeed;
    myY-=.05;
  }
  public void wrap(){
    if(myX+mySize/2<0){myX=800+mySize/2;}
    if(myX-mySize/2>800){myX=0-mySize/2;}
    if(myY+mySize/2<0){myY=600+mySize/2;}
    if(myY-mySize/2>600){myY=0-mySize/2;}
  }
}

class SpaceShip extends Floater {
  private boolean canHy, hyperSpaceMode;
  private int accMode, rotMode;
  SpaceShip() {
    myCenterX=400;
    myCenterY=300;
    myDirectionX=0;
    myDirectionY=0;
    myPointDirection=0;

    myColor=color(40, 65, 99);

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

    rotMode=0;
    accMode=0;
  }

  public void motion(){
    if(accMode==1){
      accelerate(.035);
    }else if(accMode==0){
      accelerate(0);
    }else{
      accelerate(-.035);
    }
    if(rotMode==1){
      rotate(2);
    }else if(rotMode==0){
      rotate(0);
    }else{
      rotate(-2);
    }
  }

  public void setAccelerating(int mode){
    if(mode==1){
      accMode=1;
    }else if(mode==0){
      accMode=0;
    }else{
      accMode=-1;
    }
  }
  public void setRotating(int mode){
    if(mode==1){
      rotMode=1;
    }else if(mode==0){
      rotMode=0;
    }else{
      rotMode=-1;
    }
  }

  public void hyperSpace(boolean mode) {
    hyperSpaceMode=mode;

    if (hyperSpaceMode==true) {
      myCenterX=(int)(Math.random()*width);
      myCenterY=(int)(Math.random()*height);
      myDirectionX=0;
      myDirectionY=0;
      myPointDirection=(int)(Math.random()*360);
    }
    hyperSpaceMode=false;
  }
  public void setX(int x) {myCenterX=x;}  
  public int getX() {return (int)myCenterX;}   
  public void setY(int y) {myCenterY=y;}   
  public int getY() {return (int)myCenterY;}   
  public void setDirectionX(double x) {myDirectionX=x;}   
  public double getDirectionX() {return myDirectionX;}
  public void setDirectionY(double y) {myDirectionY=y;}  
  public double getDirectionY() {return myDirectionY;}
  public void setPointDirection(int degrees) {myPointDirection=degrees;}
  public double getPointDirection() {return myPointDirection;} 
}

class Bullet extends Floater{
  Bullet(SpaceShip theShip){
    myCenterX=theShip.getX();
    myCenterY=theShip.getY();
    myPointDirection=theShip.getPointDirection();
    double dRadians =myPointDirection*(Math.PI/180);
    myDirectionX=3*Math.cos(dRadians)+theShip.getDirectionX();
    myDirectionY=3*Math.sin(dRadians)+theShip.getDirectionY();
  }
  public void show(){
    fill(200,200,200,70);
    ellipse((float)myCenterX,(float)myCenterY,8,8);
  }
  public void setX(int x) {myCenterX=x;}  
  public int getX() {return (int)myCenterX;}   
  public void setY(int y) {myCenterY=y;}   
  public int getY() {return (int)myCenterY;}   
  public void setDirectionX(double x) {myDirectionX=x;}   
  public double getDirectionX() {return myDirectionX;}
  public void setDirectionY(double y) {myDirectionY=y;}  
  public double getDirectionY() {return myDirectionY;}
  public void setPointDirection(int degrees) {myPointDirection=degrees;}
  public double getPointDirection() {return myPointDirection;} 
}

class Asteroid extends Floater {
  Asteroid(){
    myCenterX=(int)(Math.random()*800);
    myCenterY=(int)(Math.random()*600);
    myPointDirection=(Math.random()*360);
    myDirectionX=Math.random()*.2+.2;
    myDirectionY=-1*(Math.random()*.2+.1);

    myColor=color(40, 65, 99);

    corners=6;
    xCorners = new int[6];
    yCorners = new int[6];
    xCorners[0]=0;
    yCorners[0]=0;
    xCorners[1]=10;
    yCorners[1]=-2;
    xCorners[2]=0;
    yCorners[2]=-10;
    xCorners[3]=-10;
    yCorners[3]=0;
    xCorners[4]=0;
    yCorners[4]=10;
    xCorners[5]=10;
    yCorners[5]=2;

  }
  public void move ()   //move the floater in the current direction of travel
  {
    //change the x and y coordinates by myDirectionX and myDirectionY   
    myCenterX += myDirectionX;
    myCenterY += myDirectionY;

    //wrap around screen    
    if (myCenterX-7.5 >width)
    {
      myCenterX = 0-7.5;
    } else if (myCenterX+7.5<0)
    {
      myCenterX = width+7.5;
    }
    if (myCenterY-7.5 >height)
    {
      myCenterY = 0-7.5;
    } else if (myCenterY+7.5 < 0)
    {
      myCenterY = height+7.5;
    }
  }   
  public void setX(int x) {myCenterX=x;}  
  public int getX() {return (int)myCenterX;}   
  public void setY(int y) {myCenterY=y;}   
  public int getY() {return (int)myCenterY;}   
  public void setDirectionX(double x) {myDirectionX=x;}   
  public double getDirectionX() {return myDirectionX;}
  public void setDirectionY(double y) {myDirectionY=y;}  
  public double getDirectionY() {return myDirectionY;}
  public void setPointDirection(int degrees) {myPointDirection=degrees;}
  public double getPointDirection() {return myPointDirection;}
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
    if (myCenterX >width)
    {     
      myCenterX = 0;
    } else if (myCenterX<0)
    {     
      myCenterX = width;
    }    
    if (myCenterY >height)
    {    
      myCenterY = 0;
    } else if (myCenterY < 0)
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
    for (int nI = 0; nI < corners; nI++)    
    {     
      //rotate and translate the coordinates of the floater using current direction 
      xRotatedTranslated = (int)((xCorners[nI]* Math.cos(dRadians)) - (yCorners[nI] * Math.sin(dRadians))+myCenterX);     
      yRotatedTranslated = (int)((xCorners[nI]* Math.sin(dRadians)) + (yCorners[nI] * Math.cos(dRadians))+myCenterY);      
      vertex(xRotatedTranslated, yRotatedTranslated);
    }   
    endShape(CLOSE);
  }
} 
