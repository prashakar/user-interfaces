/**
 * This code gets a list of numbers from a Google Spreadsheet
 * and plots its frequency distribution.
 *
 * Based on http://blog.blprnt.com/blog/blprnt/your-random-numbers-getting-started-with-processing-and-data-visualization 
 **/

// Spreadsheet URL
String sUrl = "https://docs.google.com/spreadsheets/d/1D_qCjmHVJUGKn5BkmeEeIHAGO-t6OO7zxxTht3OYtig/export?format=csv&id=1D_qCjmHVJUGKn5BkmeEeIHAGO-t6OO7zxxTht3OYtig&gid=1";
  
int MAX_NUMBER = 100;

// the list of bars to be drawn
List<Bar> bars = new ArrayList<Bar>();
int[] counts = new int[MAX_NUMBER];

Dataset data;

void setup() {
 // This code happens once, right when our sketch is launched
 size(800,600);
 background(0);
 smooth();

 // Dataset fetches and stores the data.
 data = new Dataset(sUrl);

 // --- UNCOMMENT THE FOLLOWING LINES FOR TESTING ---
 
 //println(data.getNumbers()); // output the numbers (test)
 //println(data.getNames()); // output names (test)
 //println(data.groupNumbersByName()); // ouput numbers grouped by name (test)
 //println(data.groupNamesByNumber()); // ouput names grouped by number (test)
 //println(data.getMax()); // ouput max number (test)

 //Ask for the list of numbers
 List<Integer> numbers = data.getNumbers();

 // Draw the graph
 buildBarChart(numbers, 580);
}

/**
 *@nums list of numbers
 *@y y coordinate of the chart's baseline
 **/
void buildBarChart(List<Integer> nums, int y) {
 // Make a list of number counts
 
 // Fill it with zeros
 for (int i = 1; i < MAX_NUMBER; i++) {
   counts[i] = 0;
 }
 
 // Tally the counts
 for (int i = 0; i < nums.size(); i++) {
   counts[nums.get(i)]++;
 }
 
 // Create one instance of Bar for each number
 // and store it in the variable bars
 for (int i = 0; i < counts.length; i++) {
   Bar b = new Bar(i * 8, y, 8, -counts[i] * 10, counts[i]);
   b.setColor(counts[i] * 30, 255, 255);
   bars.add(b);
 }
}


void draw() {
  for (Bar bar : bars){
    bar.render();

  }
}

// This function listens to mouse clicks
void mouseClicked(){
  int bar_val = 0;
  for (Bar bar : bars) {
    if (bar.isInside(mouseX,mouseY)) {
      System.out.println("bar clicked");
      if (get(mouseX,mouseY) == -1) {
        System.out.println("going to reverse");
                            background(0);

        for (int i = 0; i < counts.length; i++) {
          bar.setColor(counts[bar_val] * 30, 255, 255);
        }
      } else {

        System.out.println("going to change");
        bar.setColor(0,0,255);
        data = new Dataset(sUrl);
        Map nameByNum = data.groupNamesByNumber();
        List names = (List)nameByNum.get(bar_val);
        String[] n = new String[names.size()];
        names.toArray(n);
        for (int x = 0; x < n.length; x++){
          fill(x*30, 255, 255);
          text(n[x], 0, x*30+40, 700, 300);
          System.out.println(n[x]);
        }
      }

  }
  bar_val +=1;
  }
  
}

// This function listens to mouse movement
void mouseMoved(){
  background(0);
  for (Bar bar: bars) {
    bar.render();
    if (bar.isInside(mouseX,mouseY)) {
         textSize(32);
         text("Tooltip: " + bar.value,10,30);
    }
  }
}