/*
Christopher Chan, Stephanie Ino,
Anthony Le, Wilson Zhu
*/
import ddf.minim.*;
Minim minim;
AudioPlayer song;
AudioPlayer collision;
AudioPlayer gameOver;
//This is  for the music


int lives = 3; //This is our lives
int score = 0; //used to get our score
RoadLines [] roadLine;
MoveRocks [] moveRock;
MoveTrees [] moveTree;
Obstacle enemyCar1 = new Obstacle();
Obstacle enemyCar2 = new Obstacle();
Car Car = new Car(); //Our car that responds to movement

float speed = 25.0;


class Car
{
  float xPos, yPos, carSpeed;
  Car() {
  xPos = 500;
  yPos = 800; // Spawn our car at 500,800
  }//constructor

  void update()
  {
  noStroke();
  rectMode(CENTER);

  //ADD if condition here if we want to limit restrict how far our car can move

  if (keyPressed) {   //Did we press a key? If so, go to our switch statements
    switch(key) {
    case 'w':
      yPos = yPos - 15; //Go up at 5 units.
      break;
    case 'a':
      xPos = xPos - 15; //Go left at 15 units
      break;
    case 's':
      yPos = yPos + 15;  //Go down at 15 units
      break;
    case 'd':
      xPos = xPos + 15; //Go right at 15 units
      break;
    } //switch
  } //if key pressed

  // }  This bracket will be used if we want to restrict our movement
  fill(255,0,0); //color of our car
  rect(xPos, yPos, 80, 100); //the car itself. moves based on key inputs. 100 by 100 wide
  fill(0); /* color of our wheels */
  rect(xPos-45, yPos-40, 15, 25); /* front left wheel */
  rect(xPos+45, yPos-40, 15, 25); /* front right wheel */
  rect(xPos-45, yPos+40, 15, 25); /* back left wheel */
  rect(xPos+45, yPos+40, 15, 25); /* back right wheel */
  fill(255, 255, 0); /* headlight colors */
  ellipse(xPos-25, yPos-40, 10, 10); /* left headlight */
  ellipse(xPos+25, yPos-40, 10, 10); /* right headlight */
  }
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////

class RoadLines
{
  float xPos, yPos;
  RoadLines(float x, float y) {
  xPos = x;
  yPos = y;
  }// constructor

  void update() {
  noStroke();
  rectMode(CENTER);
  yPos += speed; // "speed" of car
  if (yPos-75 > height)
    yPos = -75;
  fill(255);
  rect(xPos, yPos, 15, 100);
  }//updates road line to create illusion of movement
}
/////////////////////////////////////////////////////////////////////////
class MoveRocks
{
  float xPos, yPos;
  MoveRocks(float x, float y)
  {
  xPos = x;
  yPos = y;
  } /* constructor */

  void update()
  {
  pushMatrix();
  strokeWeight(5);
  stroke(205,175,149);
  //yPos += 0.2*speed; /* "speed" of rocks */
  yPos += 25;
  if (yPos-75 > height)
  {
    yPos = -55;
  }
  fill(205,175,149); /* rocks' color */
  ellipse(xPos, yPos, 20, 20);
  popMatrix();
  } /* updates rocks to create illusion of movement */
}
////////////////////////////////////////////////////////////////

class MoveTrees
{
  float xPos, yPos;
  MoveTrees(float x, float y)
  {
  xPos = x;
  yPos = y;
  } /* constructor */

  void update()
  {
  noStroke(); /* no outline on the rectangles or ellipses */
  rectMode(CENTER);
  //yPos += 0.45*speed; /* "speed" of trees */
  yPos += 25;
  if (yPos-75 > height)
  {
    yPos = -75;
  }
  fill(200, 120, 0); /* tree trunk's colors */
  rect(xPos, yPos+40, 10, 40); /* tree trunk */
  fill(0, 255, 0); /* tree leaves' colors */
  /* ellipses to create the tree leaves */
  ellipse(xPos, yPos, 40, 40);
  ellipse(xPos, yPos-45, 40, 40);
  ellipse(xPos-15, yPos-25, 40, 40);
  ellipse(xPos+15, yPos-25, 40, 40);
  ellipse(xPos-15, yPos+15, 40, 40);
  ellipse(xPos+15, yPos+15, 40, 40);
  } /* updates road trees to create illusion of movement */
}
////////////////////////////////////////////////////////////////

class Obstacle
{
  float xPos, yPos, xPos2, yPos2, enemySpeed, r,g,b;
  Obstacle() {
  xPos = random(300, 700); //random x coordinate spawn
  xPos2 = random(300, 700);
  yPos = -75; //initial position of car, spawns out of screen
  yPos2 = -75;
  enemySpeed = random(0, 15); //speed difference between player and enemy
  r = random(0,255);
  g = random(0,255);
  b = random(0,255);

}//constructor

  void update()
  {
  noStroke();
  rectMode(CENTER);
  ellipseMode(CENTER);
  yPos += 0.75*speed - enemySpeed; //speed difference
  yPos2 += 20;
  if (yPos-75 > height+1000) //if the enemy is out of the screen
  {// new spawn
    xPos = random(300, 700);
    yPos = -75;
    enemySpeed = random(0, 15);
    r = random(0,255);
    g = random(0,255);
    b = random(0,255);
    
    
  }
  if (yPos2-75 > height+900)
  {
    xPos2 = random(250, 750);
    yPos2 = -75;

  }
  fill(r, g, b);
  rect(xPos, yPos, 80, 100);
  fill(0); /* color of our wheels */
  rect(xPos-45, yPos-40, 15, 25); /* front left wheel */
  rect(xPos+45, yPos-40, 15, 25); /* front right wheel */
  rect(xPos-45, yPos+40, 15, 25); /* back left wheel */
  rect(xPos+45, yPos+40, 15, 25); /* back right wheel */
  fill(255, 255, 0); /* headlight colors */
  ellipse(xPos-25, yPos-40, 10, 10); /* left headlight */
  ellipse(xPos+25, yPos-40, 10, 10); /* right headlight */

  fill(240,230,140);
  ellipse(xPos2, yPos2, 50, 50);
    
    
 
    
    
    
  }
}

////////////////////////////////////////////////////////////////
void setup()
{
  size(1000, 1000);
  background(255);
  
  
  /* Music stuff here*/
  minim = new Minim(this);
  song = minim.loadFile("Music.mp3");
  song.loop(); //play a song on loop
  collision = minim.loadFile("Collision.mp3");
  gameOver = minim.loadFile("GameOver.mp3");
  /*                     */
  
  
 
  roadLine = new RoadLines[12];
  moveTree = new MoveTrees[12];
  moveRock = new MoveRocks[12];
  for (int i = 0; i<6; i++) /* y coords */
  {
  for (int j =0; j<2; j++) /* x coords */
  {
    roadLine[i*2+j]= new RoadLines(400.0+j*200, 230.0*i -75);
    moveRock[i*2+j]= new MoveRocks(50.0+j*800, 230.0*i -75);
    moveTree[i*2+j]= new MoveTrees(100.0+j*800, 230.0*i -75);
  }
  }
}



////////////////////////////////////////////////////////////////

void draw()
{

  rectMode(CENTER);
  background(120, 60, 0);
  fill(115);
  strokeWeight(10);
  stroke(100);
  rect(500, 500, 600, 1000);
  for (int l =0; l<12; l++)
  {
  roadLine[l].update();
  moveTree[l].update();
  moveRock[l].update();
  }
  enemyCar1.update();
  enemyCar2.update();
  Car.update();




  //Pos is the square
  //Pos2 is the ellipse

 
  //This portion is for the score
  if(enemyCar1.yPos==-75 || enemyCar2.yPos2==-75 || enemyCar2.yPos==-75 || enemyCar2.yPos2==-75 ) {
    if (lives != 0) {      
    score++;
    }

   }//if

  




//Collision checking is here
  if( (Car.xPos+40 >= enemyCar1.xPos - 40 && Car.xPos -40 <= enemyCar1.xPos + 40) && ( Car.yPos -50 <= enemyCar1.yPos + 50 && Car.yPos+50 >= enemyCar1.yPos - 50)) 
  {  
    enemyCar1.yPos = height + 800;
    collision.play(0);  
    lives--;
  }
      
  if((Car.xPos + 40 >= enemyCar2.xPos - 40 && Car.xPos -40<= enemyCar2.xPos + 40) && ( Car.yPos -50 <= enemyCar2.yPos + 50 && Car.yPos +50>= enemyCar2.yPos - 50))
  { 
    enemyCar2.yPos = height + 800;
     collision.play(0);  
    lives--;
  }
 
     //Top is for the squares. After this line is for the circles
  if((Car.xPos +40 >= enemyCar1.xPos2 - 25 && Car.xPos <= enemyCar1.xPos2 + 25) && ( Car.yPos <= enemyCar1.yPos2 + 25 && Car.yPos >= enemyCar1.yPos2 - 25))
  {
    enemyCar1.yPos2 = height + 800;
     collision.play(0);  
    lives--;
  }
  
  if((Car.xPos + 40 >= enemyCar2.xPos2 - 25 && Car.xPos <= enemyCar2.xPos2 + 25) && ( Car.yPos <= enemyCar2.yPos2 + 25 && Car.yPos >= enemyCar2.yPos2 - 25)) 
  {
    enemyCar2.yPos2 = height + 800;
    collision.play(0);  
    lives--;
  }


  
  //Code to display lives and score
  textSize(32);
  text("Lives:",150,50);
  text(lives, 250,50);
  text("Score:",630,50);
  text(score,740,50);


//This is our game over portion
 if (lives<=0) {
    song.pause();

    gameOver.play(0);
    textSize(90);
    text("Game Over",260,400);
    textSize(30);
    text("Press spacebar to continue",305,475);
     Car.xPos = -500;

  
    if (keyPressed) {   //Did we press a key? If so, go to our switch statements. If spacebar pressed. We restart the game
      switch(key) {
      case ' ':
      lives = 3;
      score = 0;
      song.loop();
      Car.xPos = 500; Car.yPos = 800;
      enemyCar1.xPos = random(300,700); enemyCar1.yPos = -74; 
      enemyCar2.xPos = random(300,700); enemyCar2.yPos = -74; 
      enemyCar1.xPos2 = random(300,700); enemyCar1.yPos2 = -74; 
      enemyCar2.xPos2 = random(300,700); enemyCar2.yPos2 = -74;

      break;
    } //switch
  }



}






}


