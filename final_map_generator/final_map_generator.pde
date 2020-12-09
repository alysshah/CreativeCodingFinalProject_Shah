float increment = 0.02;

int valdetail = 9; // how detailed the terrain is
int scl = 20; //scale of the hexagons

void setup() {
  size(640, 640);
}

void draw() {
  
  noStroke();
  fill(225, 255, 255, 10);
  rect(10, 520, 110, 20);
  rect(10, 550, 110, 20);
  rect(10, 580, 110, 20); //not yet coded
  rect(10, 610, 110, 20);  //not yet coded
  
  fill(0);
  text("full (pix)", 30, 535);
  text("full (hex)", 30, 565);
  text("...", 30, 595); 
  text("...", 30, 625);  
  
}
 


void full_w_pixels(){ //terrain covers the entire map - biomes are created on a pixel level
  
  //first few lines are inspired by Daniel Shiffman's "Noise2D" script (https://processing.org/examples/noise2d.html)
  
  loadPixels();
  float xoff = 0.0; // Start xoff at 0
  float detail = map(500, 0, width, 0.1, 0.6);
  noiseDetail(valdetail, detail);
  
  for (int x = 0; x < width; x++) {
    xoff += increment;    
    float yoff = 0.0;   
    for (int y = 0; y < height; y++) {
      yoff += increment; 
      //print(noise(xoff,yoff));
      
      //perlin noise is generated between 0 and 1 and is found through "noise(xoff, yoff)"
      //this decimal between 0 and 1 will be equivalent to the elevation of the terrain
      //separate different values of this noise into different biomes (relating to elevation)
      if (0 < noise(xoff, yoff) && noise(xoff, yoff) < 0.375){
        //biome 1: water
        pixels[x+y*width] = color(45, 66, 161);
      } else if (0.375 < noise(xoff, yoff) && noise(xoff, yoff) < 0.43){
        //biome 2: sand
        pixels[x+y*width] = color(204, 197, 122);
      } else if (0.43 < noise(xoff, yoff) && noise(xoff, yoff) < 0.55){
        //biome 3: grassland
        pixels[x+y*width] = color(155, 199, 117);
      } else if (0.55 < noise(xoff, yoff) && noise(xoff, yoff) < 0.675){
        //biome 4: hills
        pixels[x+y*width] = color(96, 163, 73);
      } else if (0.675 < noise(xoff, yoff) && noise(xoff, yoff) < 0.8){
        //biome 5: mountains
        pixels[x+y*width] = color(52, 125, 45);
      } else if (0.8 < noise(xoff, yoff) && noise(xoff, yoff) < 1){
        //biome 6: snow caps
        pixels[x+y*width] = color(211, 216, 219);
      }
    }
  }
  updatePixels(); // update with the colors 
}





void full_w_hex(){ //terrain covers the entire map - biomes are created on a grid of hexagons
  
  
  //start with same code as full_w_pix() but we go over this generated terrain and for each hexagon in the grid, the color of the pixel at the center of the hexagon is attributed to the whole hexagon
  
  loadPixels();
  float xoff = 0.0; // Start xoff at 0
  float detail = map(500, 0, width, 0.1, 0.6);
  noiseDetail(valdetail, detail);
  
  for (int x = 0; x < width; x++) {
    xoff += increment;    
    float yoff = 0.0;   
    for (int y = 0; y < height; y++) {
      yoff += increment; 
      //print(noise(xoff,yoff));
      if (0 < noise(xoff, yoff) && noise(xoff, yoff) < 0.375){
        //biome 1: water
        pixels[x+y*width] = color(45, 66, 161);
      } else if (0.375  < noise(xoff, yoff) && noise(xoff, yoff) < 0.43){
        //biome 2: sand
        pixels[x+y*width] = color(204, 197, 122);
      } else if (0.43 < noise(xoff, yoff) && noise(xoff, yoff) < 0.55){
        //biome 3: grassland
        pixels[x+y*width] = color(155, 199, 117);
      } else if (0.55 < noise(xoff, yoff) && noise(xoff, yoff) < 0.675){
        //biome 4: hills
        pixels[x+y*width] = color(96, 163, 73);
      } else if (0.675 < noise(xoff, yoff) && noise(xoff, yoff) < 0.8){
        //biome 5: mountains
        pixels[x+y*width] = color(52, 125, 45);
      } else if (0.8 < noise(xoff, yoff) && noise(xoff, yoff) < 1){
        //biome 6: snow caps
        pixels[x+y*width] = color(211, 216, 219);
      }
    }
  }
  updatePixels();
  
  //this part creates the grid of hexagons:
  
  for(float j = 0; j < height; j += 0.75*scl){  //we multiply the scale by 0.75 because hexagons in a grid aren't placed directly below each other: the following row started 0.25*scale higher than the lowest point of the previous row
    for(int i = 0; i < width; i += scl){  //the width/x different remains normal
      
      int rj = round(j); //the get() function below only works with intergers, so we round j to the nearest one
      color c = get(i, rj); //get() allows us to find the color of the pixel at these coordinates and attribute it to c
      fill(c);
      noStroke();
      
      //an if statement is necessary here because for each row of hexagons, the hexagons on the following row aren't placed directly below at the same interval of x values
      //every other row is shifted by 0.5*scl (so instead of being placed at (i, j), hexagons would be pllaced at (i + 0.5*scl, j))
      //every other row is divisable by 0.75*2*scale, so we can use the modulo to determine when "every other row" is happening
      
      if (j%(0.75*2*scl) == 0){
         
        //shape of a hexagon (with the coordinates i and j marking its center)
        beginShape();
          vertex(i + 0.5*scl, j - 0.25*scl);
          vertex(i + 0.5*scl, j + 0.25*scl);
          vertex(i + 0.5*scl, j + 0.25*scl);
          vertex(i + 0, j + 0.5*scl);
          vertex(i + 0, j + 0.5*scl);
          vertex(i - 0.5*scl, j + 0.25*scl);
          vertex(i - 0.5*scl, j + 0.25*scl);
          vertex(i - 0.5*scl, j - 0.25*scl);    
          vertex(i - 0.5*scl, j - 0.25*scl);
          vertex(i + 0, j - 0.5*scl);    
          vertex(i + 0, j - 0.5*scl);
          vertex(i + 0.5*scl, j - 0.25*scl);
        endShape();
      
      } else {  //if not divisable (so signifies the following row)
        
        beginShape();
          vertex(i + 0.5*scl + 0.5*scl, j - 0.25*scl);
          vertex(i + 0.5*scl + 0.5*scl, j + 0.25*scl);
          vertex(i + 0.5*scl + 0.5*scl, j + 0.25*scl);
          vertex(i + 0.5*scl + 0, j + 0.5*scl);
          vertex(i + 0.5*scl + 0, j + 0.5*scl);
          vertex(i + 0.5*scl - 0.5*scl, j + 0.25*scl);
          vertex(i + 0.5*scl - 0.5*scl, j + 0.25*scl);
          vertex(i + 0.5*scl - 0.5*scl, j - 0.25*scl);    
          vertex(i + 0.5*scl - 0.5*scl, j - 0.25*scl);
          vertex(i + 0.5*scl + 0, j - 0.5*scl);    
          vertex(i + 0.5*scl + 0, j - 0.5*scl);
          vertex(i + 0.5*scl + 0.5*scl, j - 0.25*scl);
        endShape();        
      }      
    }
  }
}



void mousePressed(){
  if (mouseX > 10 && mouseX < 120){
    if (mouseY > 530 && mouseY < 540){
      full_w_pixels();
    } else if (mouseY > 550 && mouseY < 570){
      full_w_hex();
    }
  }
}
