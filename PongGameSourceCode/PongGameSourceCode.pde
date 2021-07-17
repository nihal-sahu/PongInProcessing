//Create Performance Task Code
//AP Computer Science Principles
//1 Player Ping Pong game - Using Processing 3.5.4

//three boolean statements which evaluate what the current state of the game will be
boolean startScreen = true; //screen that presents user with the instructions
boolean game = false; //screen that starts the actual game that user can play
boolean gameOver = false; //screen that shows up if the user loses. Allows the user to play again if they want

ArrayList<Ball> balls = new ArrayList<Ball>();//list which holds all ping-pong balls included in the game

float paddleX = 500; //starting x-coordinate of the users movable paddle (middle of canvas)

void setup() { //procedure which only runs once at the beginning of the program (built in)
  size(1000, 1000); //ensures that the canvas size is 1000x1000px
}

void draw() { //procedure which runs continuously throughout the program (built in)
  textAlign(CENTER); //all text outputted throughout the entire code will be centered based on the x and y coordinates indicated in the parameters. 
  rectMode(CENTER); //all rectangles outputted throughout the entire code will be centered based on the x and y coordinates indicated in the parameters
  ellipseMode(CENTER); //all ellipses outputted throughout the entire code will be centered based on the x and y coordinates indicated in the parameters
  background(68, 85, 90); //sets background colour to light blue for the whole game
  
  if (startScreen) { //selection statement which runs to show the user the instructions of the game
    fill(255); //all shapes/text outputted from here out will be white
    
    //title elements
    textSize(55); //font size of title will be 55px
    text("Welcome to Ping Pong (1-Player)!", width / 2, height / 10); //text for title which is outputted near the center-top of the canvas
    
    //game description elements
    textSize(30); //the font size of the outputted instructions will be 30px
    text("Don't let any balls fall off the bottom of the screen\nClick the button displayed while in game to add more balls", width / 2, height / 6); //basic instructions of the game
    
    //instructions elements
    stroke(255); //all outlines of shapes will be white
    strokeWeight(5); //all outlines of shapes will be 5px thick
    textSize(45); //the font size of the instructions header will be 45px
    text("Instructions:", width / 2, height / 2 - 150);
    
    textSize(30); //font size of keystroke descriptions will be 30 px
    text("Move left", width / 2 - 100, height / 2 - 100); //keystroke header for moving left
    text("Move right", width / 2 + 100, height / 2 - 100); //keystroke header for moving right
    
    fill(68, 85, 90); //all shapes or text will now be turquoise
    //rectangles shaped to look like keyboard inputs
    rect(width / 2 - 100, height / 2, 150, 150, 10); 
    rect(width / 2 + 100, height / 2, 150, 150, 10);
    
    fill(255); //all text and shapes outputted from here will be white
    textSize(70); //the size of the text used for the displayed possible keystrokes will be 70px
    text("A", width / 2 - 100, height / 2 + 20); //A key is used to move to the left, as indicated by above header
    text("D", width / 2 + 100, height / 2 + 20); //D key is used to move to the right, as indicated by above header
    
    //start button elements
    fill(68, 85, 90); //all text and shapes outputted from here will be turquoise
    rect(width / 2, 4 * height / 5, 600, 100, 10); //outputs a 600x100px rectangle with rounded corners near the bottom-center of the canvas
    fill(255); //all text and shapes outputted from here will be white
    textSize(40); //button text will be 40px
    text("CLICK HERE TO START", width / 2, 4 * height / 5 + 15); //text outputted in center of the button which will start the game
  }
  else if (game) { //selection stsatement which runs if the user has clicked the start button on the start screen
    fill(255); //all text and shapes outputted from here will be white
    rect(paddleX, 985, 150, 30); //150x30px rectangle outputted at the bottom of the screen. the value of paddleX can be manipulated as indicated by the instructions on the start screen. 
    
    //button to add more balls
    fill(68, 85, 90); //all text and shapes outputted from here will be turquoise
    stroke(255); //outline of shapes will be white
    strokeWeight(5); //outline of shapes will be 5px thicl
    rect(width / 2, height / 6, 600, 100, 10); //button to show rectangle which is outputted near the center-top of the screen
    
    //button label text
    fill(255); //all text and shapes outputted from here will be white
    textSize(40); //the size of the outputted text for the button will be 40px
    text("CLICK HERE TO ADD 1 BALL", width / 2, height / 6 + 15); //text which falls in the center of the button
    
    for (int i = 0; i < balls.size(); i++) { //iterative loop which loops through the list containing all the ping pong balls
      balls.get(i).display(); //displays the current ball in the list
      balls.get(i).move(); //moves the current ball in the list
      
      if (balls.get(i).paddleCollision()) { //selection statement to check if the current ball in the loop will collide with the users paddle
        balls.get(i).switchYDirection(); //switches the y (vertical) direction of the ball
        balls.get(i).switchXDirection(); //switches the x (horizontal) direction of the ball
      }
      
      if (balls.get(i).isOffheight()) { //selection statement to check if the current ball in the loop is about to fall off the top of the screen
        balls.get(i).switchYDirection(); //switches the y (vertical) direction of the ball
      }
      
      if (balls.get(i).isOffwidth()) { //selection statement to check if the current ball in the loop is about to go out of the left or right of the screen
        balls.get(i).switchXDirection(); //switches the x (horizontal) direction of the ball
      }
      
      if (balls.get(i).gameOverCheck()) { //selection statement to check if the ball falls off the bottom of the screen
        game = false; //changing the value to false will end the game for the user
        gameOver = true; //changing the value to true will show the end game screen for the user
      }  
    }
  }
  else if (gameOver) { //selection statement which will run if the user loses the game
    textSize(60); //text size of the game over message will be 60px
    text("GAME OVER!\nYour score was\n" + balls.size() + " ping-pong ball(s)", width / 2, height / 2 - 200); //game over text which is outputted near the center of the screen
    
    //restart button elements
    fill(68, 85, 90); //all text and shapes outputed from here will be turquoise
    stroke(255); //the outline of all shapes outputted from here will be white
    strokeWeight(5); //the outline thickness of shapes outputted from here will be 5px
    rect(width / 2, 2 * height / 3, 600, 100, 10); //outputs rectangle to display a button
    
    fill(255); //all text and shapes outputted from here will be white
    textSize(40); //the size of the button text will be 40px
    text("CLICK HERE TO PLAY AGAIN", width / 2, 2 * height / 3 + 15); //button text which falls in the center of the above outputted rectangle
  }
}

void mousePressed() { //procedure which only runs if the user clicks with their mouse (built in)
  if (startScreen) { //selection statement which runs if the user is in the start screen
    if (mouseX > 200 && mouseX < 800 && mouseY > 750 && mouseY < 850) { //if the user clicks anywhere on the outputted start game button
      startScreen = false; //changing this to false allows the user to move to another game
      game = true; //changing this to true allows the user to start the game
      
      balls.clear(); //clears the balls list to ensure that there is no balls from the last time the user played
      balls.add(new Ball(width / 2, height / 2, random(1, 3), random(-2, 2))); //the first ball is added to the list and initialized so that it will first appear in the center of the canvas. it is given random x and y speeds
    }
  }
  else if (game) { //selection statement which runs if the user is playing the actual game
    if (mouseX > 200 && mouseX < 800 && mouseY > 116.67 && mouseY < 216.67) { //if the user clicks the outputted button
      balls.add(new Ball(random(10, 990), random(50, 500), random(1, 3), random(-2, 2))); //a new ball will be added and outputted at any random coordinates near the top half of the screen. it is given random x and y speeds
    }
  }
  else if (gameOver) { //selection statement which runs if the user loses the game 
    if (mouseX > 200 && mouseX < 800 && mouseY > 616.67 && mouseY < 717.67) { //if the users clicks anywhere on the outputted button
      startScreen = true; //changing this to true will allow the user to return to the instruction screen
      gameOver = false; //changing this to false allows the user to leave the game over screen
    }
  }
}

void keyPressed() { //procedure which only runs if the user presses a button on the keyboard (built in)
  if (game) { //selection statement to see if the user is playing the actual game
    if (key == 'a') { //selection statement to see if the user has pressed the 'a' key on their keyboard
      if (!(paddleX - 75 < 0)) { //selection statement to see if the left edge of the paddle has NOT reached the left side of the canvas
        paddleX -= 20; //moves the paddle left by 20px
      }
    }
    else if (key == 'd') { //selection statement to see if the user has pressed the 'd' key on their keyboard
      if (!(paddleX + 75 > width)) { //selection statement to see if the right edge of the paddle has NOT reached the right side of the canvas
        paddleX += 20; //moves the paddle right by 20px
      }
    }
  }
}

class Ball { //class which contains all procedures of the ball
  
  //x and y coordinates of the new ball
  float x;
  float y;
  //x and y speeds of the ball
  float ySpeed;
  float xSpeed;
  
  Ball(float tempX, float tempY, float tempYSpeed, float tempXSpeed){ //constructor of the ball class
    x = tempX; //initializes x coordinates of the ball
    y = tempY; //initializes y coordinates of the ball
    xSpeed = tempXSpeed;
    ySpeed = tempYSpeed;
  }
 
  void switchYDirection() { //procedure which switches the y direction of the ball
    ySpeed = ySpeed * -1; //multiplies the y speed by -1 so that the ball can move along the y axis in the opposite direction
  }
  
  void switchXDirection() {  //procedure which switches the x direction of the ball
    xSpeed = xSpeed * -1; //multiplies the x speed by -1 so that the ball can move along the x axis in the opposite direction
  }
  
  void move() { //procedure which moves each ball by its respective x and y speeds
    y += ySpeed; //increments y coordinate by its vertical speed
    x += xSpeed; //increments x coordinate by its horizontal speed
  }

  void display() {  //procedure which displays the balls
    noStroke(); //ensures the balls have no visible outline
    ellipse(x, y, 30, 30); //outputs a circle with a diameter of 30px
  }
  
  boolean isOffheight(){ //procedure which checks if the ball is about to go above the top boundary of the canvas 
    return y < 15; //procedure returns true if the center of the ball is above 15 on the y axis
  }
  
  boolean isOffwidth() {  //procedure which checks if the ball is about to go off the left and right of the boundary
    return x > width - 15|| x < 15; //procedure returns true if the center of the ball is about to go pass 15 off of the right or left bounds of the canvas
  }
  
  boolean paddleCollision() { //procedure which checks if the ball is about to collide with the user paddle on the next iteration
    return (y + 14) + ySpeed >= 970 && x > paddleX - 75 && x < paddleX + 75;  //procedure returns true if the ball is about to collide anywhere throughout the paddle
  }
  
  boolean gameOverCheck() { //procedure which checks if the game is over
    return y >= height; //procedure returns true if any one of the balls fall off the bottom of the canvas
  }
}
