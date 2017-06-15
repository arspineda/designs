class Grid {
  
  PGraphics baseImage;
  boolean[][] vertices;
  int rows;
  int cols;
  int spacingCol;
  int spacingRow;
  
  Grid(int __wd, int __ht, int __rows, int __cols){
    this.baseImage = createGraphics(__wd,__ht);
    this.rows = __rows;
    this.cols = __cols;
    this.vertices = new boolean[__rows][__cols];
    this.spacingCol = int(map(1,0,__cols+1,0,__wd));
    this.spacingRow = int(map(1,0,__rows+1,0,__ht));
  }
  
  PGraphics getBaseIm(){  
    return baseImage; 
  }
  
  void resetGrid(){
    for(int i = 0; i < rows; i++){
      for(int j = 0; j < cols; j++){
        vertices[i][j] = false;
      }
    } 
  }
  
  void drawGrid(){
    baseImage.beginDraw();
    baseImage.background(200,150,200);
    baseImage.stroke(0);
    baseImage.strokeWeight(3);
    for(int i = 0; i < rows; i++){
      for(int j = 0; j < cols; j++){
        baseImage.point((j+1)*spacingCol,(i+1)*spacingRow);
      }
    }
    baseImage.endDraw();
  }
  
}