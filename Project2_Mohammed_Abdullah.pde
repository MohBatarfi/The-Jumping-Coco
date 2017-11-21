// Mohammed Batarfi and Abdullah Bin Salamah
// Project 2 (Flappy Bird)
// Fall 2016

// Press SPACE to start playing and to jump
// When the player wins, press 'r' to restart the game after winning

PImage bird; // name images
PImage bg;
PImage wall;
PImage win;
int gamestate = 1; // game state, start screen
int score = 0; // score starts from 0
int highScore = 0; // high score
int y;
int vy = 1; // velocity of the y
int [] wx = new int [2]; 
int [] wy = new int [2]; 
int [] bhs = new int [5];

import processing.sound.*;
SoundFile file;
SoundFile jump;

void setup () 
{
  // Load a soundfile from the /data folder of the sketch and play it back
  file = new SoundFile(this, "music.mp3");
  file.play();

  // Load a soundfile from the /data folder of the sketch and play it back
  jump = new SoundFile(this, "g1.wav");

  size (700, 625);
  textSize(48);
  bird = loadImage("bird.png"); // load Coco and resize
  bird.resize(60, 60);
  bg = loadImage("bg.jpg");
  bg.resize(700, 625);
  wall = loadImage("wall.png");
  win = loadImage("win.jpg");
  win.resize(700, 625);
  frameRate(60);
  for(int i = 0; i < 5; i++){
    bhs[i]=0;
  }
}

void draw()
{

  gamestart(); // game start
  if (score == 20)
  {
    gameWon(); // if score reaches 20, load the game winner picture.
  }
}

void gamestart()
{
  if (gamestate == 0) // game state = 0 to start playing
  {
    imageMode(CORNER);
    image(bg, 0, 0); // load background
    vy = vy + 1; // velocity of y 
    y = y + vy; // to make it fall (gravity)

    for (int i = 0; i < 2; i++) // make the walls come again 
    {
      imageMode(CENTER);
      image(wall, wx[i], wy[i] - (wall.height/2 + 100)); // load top walls
      image(wall, wx[i], wy[i] + (wall.height/2 + 100)); // load bottom walls
      if (wx[i] < 0) // when wall is off the screen, make it start again
      {
        wy[i] = (int)random(200, height-200); 
        wx[i] = width;
      }
      if (wx[i] == 100) // when Coco goes through the wall 
      {
        score++; // score up
      }
      if (score >= 0 && score < 5) // level 1
      {
        frameRate(60);
        textSize(20);
        text("Level 1", width/2, 45);
      }
      if (score > 4 && score < 10) // level 2
      {
        frameRate(75);
        textSize(20);
        text("Level 2", width/2, 45);
      }
      if (score > 9 && score < 15) // level 3
      {
        frameRate(85);
        textSize(20);
        text("Level 3", width/2, 45);
      }
      if (score > 14 && score < 20) // level 4
      {
        frameRate(90);
        textSize(20);
        text("Level 4", width/2, 45);
      }

      if (y> height || y < 0 || (abs(100-wx[i]) < 38 && abs(y - wy[i]) > 88)) // if coco is located out of the screen or hits the top wall or bottom wall, it loses (boundries)
      {
        gameOver(); // lose and go back to the main screen.
      }

      wx[i] = wx[i] - 4; // wall speed
    }
    image(bird, 100, y); // Coco's location
    textSize (42);
    fill(255);
    text(" "+score, width/2-15, 550);
  } else {
    gameOver();
  }
}

void gameOver() // game over is the main screen, if you start playing, you will face the main screen. 
  // However, if you lose , it goes back to the main screen!.
{
  gamestate = 1;
  imageMode(CENTER);
  image(bg, width/2, height/2 );
  textSize(24); 
  for (int i = 0; i < 5; i++)
  {  
    int tmp = score;
    bhs [0] = tmp;    
  }

  highScore = max(score, highScore); // set high score
  text("Previous Score: "+ bhs[0],444, 230);
  fill(255);
  text("High Score: "+highScore, 500, width/2-150); // text 
  textSize(40);
  text(" The Jumping Coco", width/4, 100);
  textSize(24);
  text(" NOTE : Press SPACE to jump", 170, width/2+200); // text
  textSize(16);
  text(" By Mohammed and Abdullah ", 1, 620);
  textSize(24);
  text(" Press 'Space' to Start the Game!", width/4, width/2+50); // text
}

void gameWon() // if the score reaches 20, game win picture is going to be loaded.
{

  gamestate = 2;
  image(win, width/2, height/2);
  textSize(32);
  fill(0);
  text(" Press 'r' to go to main menu", width/4 - 40, 100); 
  restart(); // if the player presses 'r' it goes to the main screen.
}


void keyPressed()
{

  if (key==32) // space ' which makes coco jumps. 
  { 
    jump.play(); // anytime the player presses 'SPACE' it plays the jump sound.
    if (gamestate == 1)

    {              // start the game
      wx[0] = 600;
      wy[0] = height/2;
      wx[1] = 900;
      wy[1] = 400;
      y = height/2;
      gamestate = 0;
      score = 0;
      frameRate(60);
    }
    vy = -14; // Coco's jump
  }
}

void restart()
{
  if (key==114) // restart the game if only the player reaches the gameWin picture.
  {
    gameOver();
  }
}