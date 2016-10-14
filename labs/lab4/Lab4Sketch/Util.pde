public class Bar {
  
  int x, y, w, h;
  int hue = 0, s = 0, b = 0; // default color is black
  int value;
  
  // constructor
  public Bar(int x, int y, int w, int h, int value){
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.value = value;
  };
  
  public void setColor(int h, int s, int b){
    this.hue = h;
    this.s = s;
    this.b = b;
  };
  
  /* Draws the rectangle */
  public void render(){
    colorMode(HSB);
    fill(this.hue, this.s, this.b);
    rect(x, y, w, h);
    if (isInside(mouseX,mouseY)) {
       textSize(32);
       text(this.value,10,30);
    }
  }

  /* Check if a given point lies within this rectangle */
  public boolean isInside(int x, int y){
    return x >= this.x && x <= (this.x + this.w) 
        && y <= this.y && y >= (this.y + this.h);
  }
 
}