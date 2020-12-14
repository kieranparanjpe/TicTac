
import processing.net.*;

int[][] grid = new int[3][3];

boolean myTurn = true;

Server myServer;

void setup()
{
  size(800, 800);
  
  rectMode(CENTER);
  
  myServer = new Server(this, 5204); 
 
}

void draw()
{
  if(myTurn)
    background(30, 200, 0);
  else
      background(255, 150, 0);
  
  stroke(0);
  line(width / 3, 0, width / 3, height);
  line((width / 3) * 2, 0, (width / 3) * 2, height);
  
  line(0, height / 3, width, height / 3);
  line(0, (height / 3) * 2, width, (height / 3) * 2);


  for(int x = 0; x < grid.length; x++)
  {
   for(int y = 0; y < grid[x].length; y++)
   {
     DrawXO(x, y);
   }
  }
  
  Client client = myServer.available();
  
  if(client != null)
  {
    String in = client.readString();
    
    int x = parseInt(String.valueOf(in.charAt(0)));
    int y = parseInt(String.valueOf(in.charAt(1)));

    grid[x][y] = 2;
    myTurn = true;
  }
}

void DrawXO(int row, int col)
{
  int state = grid[row][col];
  
  if(state == 0)
    return;
    
  if(state == 1)
  {
    pushMatrix();
    
    float yPos = row * (width / 3) + (width / 6);
    float xPos = col * (height / 3) + (height / 6);
    
    translate(xPos, yPos);
    
    float x = (width / 6) - 15;
    float y = (height / 6) - 15;;
    
    line(x, y, -x, -y);
    line(-x, y, x, -y);

    popMatrix();
    return;
  }
  
  if(state == 2)
  {
    pushMatrix();
    
    float yPos = row * (width / 3) + (width / 6);
    float xPos = col * (height / 3) + (height / 6);
    
    translate(xPos, yPos);
    
    circle(0, 0, (width / 3) - 15);

    popMatrix();
  }
}

void mousePressed()
{
  int y = mouseX / (width / 3);
  int x = mouseY / (height / 3);

  if(myTurn && grid[x][y] == 0)
  {
    myServer.write(x + "" + y);     
    grid[x][y] = 1;
    myTurn = false;
  }
}
