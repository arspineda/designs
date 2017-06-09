/* A program that generates line drawings
  connecting vertices of a grid, such that
  no connections happen between any two vertices
  that share a column or a row.
  In other words, the generator can only make
  diagonal lines.
*/
size(400,400);
background(200,150,200);
int NUM_ROWS = 8;
int NUM_COLS = 8;
boolean[][] vertices = new boolean[NUM_ROWS][NUM_COLS];
float spacingCol = map(1,0,NUM_COLS+1,0,width);
float spacingRow = map(1,0,NUM_ROWS+1,0,height);
//note on spacing: my first way of calculating the spacing was just to divide
//1 by NUM_COLS+1, but for certain numbers of NUM_COLSthe spacing would be
//insufficient, leaving a gutter along the right and bottom. map deals with what
//I think was a rounding error.

//false means the vertex has not been visited; true otherwise //<>//

//First, initialize matrix and draw points
stroke(0);
strokeWeight(3);
for(int i = 0; i < NUM_ROWS; i++){
  for(int j = 0; j < NUM_COLS; j++){
    vertices[i][j] = false;
    point((j+1)*spacingCol,(i+1)*spacingRow);
  }
}

//Next, we start at a point and visit vertices
int prevRow = (int) random(0,NUM_ROWS);
int prevCol = (int) random(0,NUM_COLS);
vertices[prevRow][prevCol] = true;
int currRow;
int currCol;
int tries = 30;

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
  currRow = (prevRow + (int) random(1,NUM_ROWS)) % NUM_ROWS;
  currCol = (prevCol + (int) random(1,NUM_COLS)) % NUM_COLS;
  
  if(vertices[currRow][currCol] == false){
    line((prevCol+1)*spacingCol,(prevRow+1)*spacingRow,
     (currCol+1)*spacingCol,(currRow+1)*spacingRow);
    vertices[currRow][currCol] = true;
    prevRow = currRow;
    prevCol = currCol;
    tries = 30;
  }
  else{
    tries--;
  }
}