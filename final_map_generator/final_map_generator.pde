float increment = 0.02;

int valdetail = 9; // how detailed the terrain is

void setup() {
  size(640, 640);
}

void draw() {
  full_w_pixels();
}
 


void full_w_pixels(){
  
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
