class Tile {
  int x, y;
  int value = 0;
  float thick_w, thick_h;
  boolean revealed = false;
  boolean flagged = false;
  Tile(int x_, int y_, float thick_w_, float thick_h_) {
    x = x_;
    y = y_;
    thick_w = thick_w_;
    thick_h = thick_h_;
  }

  void show() {
    if (flagged) {
      fill(200);
      stroke(150);
      strokeWeight(3);
      rect(x * thick_w, y * thick_h, thick_w, thick_h);
      stroke(0);
      if (lose && value != -1) {
        stroke(255, 0, 0);
      }
      strokeWeight(5);
      line(x * thick_w, y * thick_h, x * thick_w + thick_w, y * thick_h + thick_h);
      line(x * thick_w, y * thick_h + thick_h, x * thick_w + thick_w, y * thick_h);
    } else {
      if (!revealed) {
        stroke(0);
        strokeWeight(3);
        fill(180);
        rect(x * thick_w, y * thick_h, thick_w, thick_h);
      } else {
        fill(200);
        stroke(150);
        strokeWeight(3);
        rect(x * thick_w, y * thick_h, thick_w, thick_h);
        if (value == -1) {
          fill(255, 0, 0);
          if (flagged) {
            fill(0);
          }
          ellipse(x * thick_w + thick_w / 2, y * thick_h + thick_h / 2, thick_w / 4, thick_h / 4);
          if (!lose) {
            lose = true;
            for (Tile t : grid) {
              if (t.value == -1) {
                t.revealed = true;
                t.show();
              }
              if (t.flagged && t. value != -1) {
                t.show();
              }
            }
          }
        } else if (value != 0) {
          textSize(30);
          fill(0);
          text( value, x * thick_w + thick_w / 2.5, y * thick_h + thick_h / 1.8);
        } else {
          revealNeighbors();
        }
      }
    }
  }

  void getValue() {
    if (x != 0) {
      if (y != 0) {
        if (grid[(y-1) * grid_w + x - 1].value == -1) {
          value ++;
        }
      }
      if (y != grid_h - 1) {
        if (grid[(y+1) * grid_w + x - 1].value == -1) {
          value ++;
        }
      }
      if (grid[y * grid_w + x - 1].value == -1) {
        value ++;
      }
    }
    if (x != grid_w - 1) {
      if (y != 0) {
        if (grid[(y-1) * grid_w + x + 1].value == -1) {
          value ++;
        }
      }
      if (y != grid_h - 1) {
        if (grid[(y+1) * grid_w + x + 1].value == -1) {
          value ++;
        }
      }
      if (grid[y * grid_w + x + 1].value == -1) {
        value ++;
      }
    }
    if (y != 0) {
      if (grid[(y-1) * grid_w + x].value == -1) {
        value ++;
      }
    }
    if (y != grid_h - 1) {
      if (grid[(y+1) * grid_w + x].value == -1) {
        value ++;
      }
    }
  }

  void revealNeighbors() {
    if (!(x % grid_w == 0)) {
      if (y != 0) {
        grid[(y-1) * grid_w + x - 1].revealed = true;
      }
      if (y != grid_h - 1) {
        grid[(y+1) * grid_w + x - 1].revealed = true;
      }
      grid[y * grid_w + x - 1].revealed = true;
    }
    if (!(x % grid_w == grid_w - 1)) {
      if (y != 0) {
        grid[(y-1) * grid_w + x + 1].revealed = true;
      }
      if (y != grid_h - 1) {
        grid[(y+1) * grid_w + x + 1].revealed = true;
      }
      grid[y * grid_w + x + 1].revealed = true;
    }
    if (y != 0) {
      grid[(y-1) * grid_w + x].revealed = true;
    }
    if (y != grid_h - 1) {
      grid[(y+1) * grid_w + x].revealed = true;
    }
  }
}
