import java.text.*;
import controlP5.*;
import java.io.*;
import java.util.ArrayList;
import java.util.Random;

// Reads the "box ideas" from this file (1 per line).
// NOTE: Need at least 24 ideas in the file or it will crash.
String fileName = "/Users/zfleischman/ideas.txt";

String fontName = "Osaka";

ControlP5 cp5;

int displayWidth = 620;
int displayHeight = 700;

int boardStartX = 20;
int boardStartY = 100;
int rectSize = 100;
int rectSpacing = 120;

int vertOffset = 20;

ArrayList<String> ideas = new ArrayList<String>();

PFont f;

Textarea[][] boxes = new Textarea[5][5]; 

void setup() {
  loadIdeasFromFile();
  
  size(displayWidth, displayHeight);  
    
  cp5 = new ControlP5(this);
    
  background(75, 0, 130);
  for (int i=0; i<5; ++i) {
    for (int j=0; j<5; ++j) {
      int x = boardStartX+(i*rectSpacing);
      int y = boardStartY+(j*rectSpacing);
      fill(i==2 && j==2 ? color(20,170,0) : color(255));
      rect(x-1,y,rectSize+1,rectSize);
      String boxText = getBoxText();
      if (i==2 && j==2) {
        boxText = "Free Square!";
      }
        
      boxes[i][j] = cp5.addTextarea("" + i + ", " + j)
          .setPosition(x,y+vertOffset)
          .setSize(rectSize, rectSize-vertOffset)
          .setLineHeight(14)
          .setFont(createFont(fontName,13))
          .setColor(color(0))
          .setColorBackground(i==2 && j==2 ? color(20,170,0) : color(255))
          .setColorForeground(color(255,100))
          .setText(boxText);
      }
    }
    
    textFont(createFont("LucidaFax", 70));
    fill(255);
    text("Bingo!", 200, 70);
    
    noLoop();
}

void draw() { 
}

void keyPressed() {
  if (key == 'q'){
     System.exit(0);
  }
}

String getBoxText() {
  return ideas.remove(new Random().nextInt(ideas.size()));
}

void loadIdeasFromFile() {
  try {
    FileInputStream fstream = new FileInputStream(fileName);
    BufferedReader br = new BufferedReader(new InputStreamReader(fstream));
    String strLine;
    while ((strLine = br.readLine()) != null) {
      ideas.add(strLine);
    }
    br.close(); 
  } catch (Exception ex) {}
}