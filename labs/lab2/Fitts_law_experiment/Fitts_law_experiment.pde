import java.io.Writer;
import java.util.Arrays;

Timer timer = new Timer();
Rectangle r1 = new Rectangle(400,50,15,600);
Rectangle r2 = new Rectangle(650,50,15,600);
Rectangle current;
ArrayList al = new ArrayList();
ArrayList dist = new ArrayList<Integer>(Arrays.asList(250,250,250,500,500,500,1000,1000,1000));
ArrayList wid = new ArrayList<Integer>(Arrays.asList(15,30,45,15,30,45,15,30,45));
int[][] times = new int[9][7];

int counter = 0;
int counter2 = 0;
void setup(){
  size(1900, 800);
  r1.setColor(0,0,255);
  r2.setColor(0,0,0);
  current = r1;
}

void draw(){
  background(218,222,229);
  r1.render();
  r2.render();
  
}

void update() {
  if (counter2 >= 8) {
    for (int x=0;x<9;x++) {
     for (int y=1;y<7;y++) {
      print(times[x][y] + ",");
     }
     println();
    }
      
  } else {
  setup();
  r1.w = (int)wid.get(counter2+1);
  r2.w = (int)wid.get(counter2+1);
  r2.x = (int)dist.get(counter2+1)+400; 
  counter2 += 1;
  }
}

void mouseClicked(){
  // This method is called whenever a mouse click occurs.
  // Use the global variables mouseX and mouseY to get current mouse coordinates.
  if (counter >= 6){
   times[counter2][counter] = timer.getTime();
   update();
   counter = 0;
  }else if (current.isInside(mouseX,mouseY)) {
    current.setColor(0,0,0);
    if (current == r1) {
      current = r2;
      times[counter2][counter] = (timer.getTime());
      
    } else {
      current = r1;
      times[counter2][counter] = (timer.getTime());
      
    }
    current.setColor(0,0,255);
    counter += 1;

  }
  timer.start();

}

/*
Simple class to record elapsed time.
Usage:
Timer timer = new Timer();
timer.start();   // start counting time from 0
timer.pause();   // pause
timer.start();   // continue counting from when it was paused
timer.pause();   // pause again
timer.getTime(); // get accumulated time in miliseconds
timer.reset();   // make it ready for a new run
*/
class Timer{
  
  int accTime   = 0,
      lastStart = 0;
      
  boolean paused = true;
  
  public void start(){
    this.lastStart = millis();
    this.paused    = false;
  }
  
  public void pause(){
    this.accTime += millis() - lastStart;
    paused = true;
  }
  
  public int getTime(){
    return paused ? accTime : accTime + (millis() - lastStart);
  }
  
  public void reset(){
    this.accTime   = 0;
    this.lastStart = 0;
    this.paused    = true;
  }
  
  public boolean isPaused(){return this.paused;};
}


class Rectangle{
  int x, y, w, h;
  int r = 0, g = 0, b = 0; // default color is black
  
  // constructor
  public Rectangle(int x, int y, int w, int h){
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
  };
  
  public void setColor(int r, int g, int b){
    this.r = r;
    this.g = g;
    this.b = b;
  };
  
  /* Draws the rectangle */
  public void render(){
    fill(this.r, this.g, this.b);
    rect(x, y, w, h);
  }

  /* Check if a given point lies within this rectangle */
  public boolean isInside(int x, int y){
    x = x - this.x;
    y = y - this.y;
    return x >= 0 && x <= this.w && y >= 0 && y <= this.h;
  }
  
}