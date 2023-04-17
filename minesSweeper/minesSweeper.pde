int grid_w = 10;
int grid_h = 10;
float proportion = .20;
int nbBombs = floor(proportion * grid_w * grid_h);
int x_test, y_test;
boolean setup = false;
boolean lose = false;
Tile[] grid = new Tile[grid_w * grid_h];
int rand;
void setup() {
  size(800, 800);
  for (int i = 0; i < grid_w * grid_h; i++) {
    grid[i] = new Tile(i % grid_w, i / grid_w, width / grid_w, height / grid_h);
  }
}

void draw() {
  background(200);
  for (Tile t : grid) {
    if (t.revealed) {
      t.show();
    }
  }
  for (Tile t : grid) {
    if (!t.revealed) {
      t.show();
    }
  }
  if (lose) {
    noLoop();
  }
}

void mousePressed() {
  if (!setup) {
    setupGrid(floor(map(mouseX, 0, width, 0, grid_w)), floor(map(mouseY, 0, height, 0, grid_h)));
  }
  for (Tile t : grid) {
    if (mouseX > t.x * t.thick_w && mouseX < t.x * t.thick_w + t.thick_w && mouseY > t.y * t.thick_h && mouseY < t.y * t.thick_h + t.thick_h) {
      if (mouseButton == RIGHT) {
        t.flagged = !t.flagged;
      } else {
        if (!t.revealed) {
          t.revealed = true;
          break;
        } else{
          t.revealNeighbors();
        }
      }
    }
  }
}


void setupGrid(int x, int y) {
  boolean shit = true;
  int mc = y * grid_w + x;
  println(13);
  while (shit) {
    shit = false;
    for (int i = 0; i < grid_w * grid_h; i++) {
      grid[i] = new Tile(i % grid_w, i / grid_w, width / grid_w, height / grid_h);
    }
    for (int i = 0; i < nbBombs; i++) {
      rand = floor(random(grid_w * grid_h));
      while (rand == mc) {
        rand = floor(random(grid_w * grid_h));
      }
      grid[rand].value = -1;
    }
    grid[mc].getValue();
    if (grid[mc].value != 0) {
      shit = true;
    } else {
      for (Tile t : grid) {
        if (t.value != -1) {
          t.getValue();
        }
      }
    }
  }
  println(12);
  setup = true;
  println(x, y);
}
