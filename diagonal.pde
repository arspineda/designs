/* A program that generates line drawings
  connecting vertices of a grid, such that
  no connections happen between any two vertices
  that share a column or a row.
  In other words, the generator can only make
  diagonal lines.
*/

Grid base;
int NUM_ROWS = 8;
int NUM_COLS = 8;
boolean resetMode = false;

void setup(){
  size(400,400);
  base = new Grid(width,height,NUM_ROWS,NUM_COLS); 
  base.drawGrid();
  base.resetGrid();
  image(base.getBaseIm(),0,0);
  noLoop();
}
  
void draw(){
  int prevRow = int(random(0,base.rows));
  int prevCol = int(random(0,base.cols));
  base.vertices[prevRow][prevCol] = true;
  
  int currRow;
  int currCol;
  int tries = 30;
  
  if(resetMode == true){
    base.resetGrid();
    image(base.getBaseIm(),0,0);
    resetMode = false;
  }
  
  stroke(50, 125);
  strokeWeight(1);
  
  //we try to connect the prev and current points, if
  //the current point hasn't already been visited.
  //if it has, randomly pick a point again. try at most 30 (totally arbitrary)
  
  //note 1: the output of random will never be the second parameter, so there's
  //no risk of setting either row or coln to the previous value
  //note 2: It'd be good if I could eliminate the visited points beforehand,
  //and just pick randomly from the ones left. but representing the latter is weird
  
  while(tries > 0){
    currRow = (prevRow + (int) random(1,base.rows)) % base.rows;
    currCol = (prevCol + (int) random(1,base.cols)) % base.cols;
    
    if(base.vertices[currRow][currCol] == false){
      line((prevCol+1)*base.spacingCol,(prevRow+1)*base.spacingRow,
       (currCol+1)*base.spacingCol,(currRow+1)*base.spacingRow);
      base.vertices[currRow][currCol] = true;
      prevRow = currRow;
      prevCol = currCol;
      tries = 30;
    }
    else{
      tries--;
    }
  }
  
}

void mousePressed(){
  resetMode = true;
  redraw();
}
//note on spacing: my first way of calculating the spacing was just to divide
//1 by NUM_COLS+1, but for certain numbers of NUM_COLSthe spacing would be
//insufficient, leaving a gutter along the right and bottom. map corrects what
//I think was a rounding error.

//false means the vertex has not been visited; true otherwise //<>//