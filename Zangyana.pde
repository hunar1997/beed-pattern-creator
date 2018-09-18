import java.util.Scanner;
Scanner in = new Scanner(System.in);


// Amana dastkari bka
int W = 15;  // pani
int H = 100;  // drezhi
String fileName = "Spring-Flowers-1.jpg";  // nawi faili wena ka lahaman foldar danrawa
int drawType = 1;  // 0=bazna  1=chwargosha
boolean chwarChewa = true;  // true=chwarchewa bkesha    false=chwarchewa makesha
// lera badwawa dastkari maka
int dia;

color colors[] = {
 color(0,0,0),  // spi
 color(255,255,255),  // rash
 color(238,38,41),  //sur
 color(228,85,139),  // pamaii tokh
 color(237,120,165),  //pamaii kal
 color(235,152,32),  // prtaqali
 color(225,238,46),  // zard
 color(135,223,77),  // sawz
 color(10,179,80),  // sawzi tokh
 color(163,198,238),  // shini kal
 color(30,154,192),  // shini tokh
 color(43,32,154),  // mori tpkh
 color(172,129,218)  // mori kal
};
String colorNames[] = {
  "سپی",
  "ڕەش",
  "سوور",
  "پەمەیی تۆخ",
  "پەمەیی کاڵ",
  "پرتەقاڵی",
  "زەرد",
  "سەوزی کاڵ",
  "سەوزی تۆخ",
  "شینی کاڵ",
  "شینی تۆخ",
  "مۆری کاڵ",
  "مۆری تۆخ"
};

int imageData[][] = new int[W][H];

PImage img;

void setup(){
  background(200);
  
  size(1200,700);
  noStroke();
  img = loadImage(fileName);
  dia = (W>H)? width/W:height/H;
  for (int i=0; i<W; i++){
    for (int j=0; j<H; j++){
      int x = i*dia+dia/2;
      int y = j*dia+dia/2;
      color c = img.get(floor(img.width*(i+0.5)/W), floor(img.height*(j+0.5)/H));
      int chosenIndex = 0;
      float distance = 10000;
      for (int l=0; l<colors.length; l++){
        color c1 = colors[l];
        float d = sqrt( pow(red(c1)-red(c),2) + pow(green(c1)-green(c),2) + pow(blue(c1)-blue(c),2) );
        if (d<distance){
          chosenIndex = l;
          distance = d;
        }
      }
      imageData[x/dia][y/dia] = chosenIndex;
      fill(colors[chosenIndex]);
      if (drawType==0){
        ellipse(x,y,dia,dia);
      }else{
        if (chwarChewa) stroke(0);
        rect(x-dia/2,y-dia/2,dia,dia);
      }
    }
  }
  stroke(0);
  fill(0);
  PFont f = createFont("Arial",16,true);
  textFont(f,20);
  for (int i= 5*dia; i<height-dia; i+=dia*5){
    if (i%10==0){
      line(W*dia,i,W*dia+20,i);
      text(i/dia,W*dia+25,i+8);
    }
    line(W*dia,i,W*dia+10,i);
  }
  
  
  
  
  PrintWriter output = createWriter("shtaka.txt");
  output.println("----ڕەنگەکان----");
  for (int j=0; j<H; j++){
    output.println("---ڕیزی "+(j+1)+"---");
    for (int i=0; i<W; i++){
      output.println(i+1+":  "+colorNames[imageData[i][j]]);
    }
  }
  output.flush();
  output.close();
}

void draw(){
  frameRate(20);
  int size=50;
  if (mouseX<=W*dia-1 && mouseX>0 && mouseY<=H*dia-1 && mouseY>0){
    int locX=W*dia+150;
    int locY=height/4;
    
    int i=mouseX/dia, j=mouseY/dia;
    noStroke();fill(200);
    rect(W*dia+60,0,width,height);
    
    fill(colors[imageData[i][j]]);
    if (drawType==0){
      ellipse(locX, height/2, size,size);
    }else{
      if (chwarChewa) stroke(0);
      rect(locX-size/2, height/2-size/2, size,size);
    }
    
    fill(0);
    PFont f = createFont("Arial",16,true);
    textFont(f,20);
    text("ڕیزی "+(i+1)+" ستوونی "+(j+1),locX+size,height/2+8);
    
    int gridSize = 2;
    int cellSize = 30;
    
    for (int x=i-gridSize; x<=i+gridSize; x++){
      for (int y=j-gridSize; y<=j+gridSize; y++){
        if (x<0 || x>W-1 || y<0 || y>H-1) noFill();
        else fill(colors[imageData[x][y]]);
        if (drawType==0){
          ellipse(locX-(i-x)*cellSize, locY-(j-y)*cellSize,cellSize,cellSize);
        }else{
          rect(locX-(i-x)*cellSize-cellSize/2, locY-(j-y)*cellSize-cellSize/2, cellSize, cellSize);
        }        
      }
    }
    strokeWeight(2);
    stroke(0,255,0);
    line(locX-gridSize*cellSize-cellSize/2,locY, locX+gridSize*cellSize+cellSize/2,locY);
    line(locX,locY-gridSize*cellSize-cellSize/2, locX, locY+gridSize*cellSize+cellSize/2);
    fill(0);
    text(j+1,locX+gridSize*cellSize+cellSize/2,locY+8);
    text(i+1,locX-8, locY-gridSize*cellSize-cellSize/2);
  }else{
    noStroke();fill(200);
    rect(W*dia+60,0,width,height);
  }
}
