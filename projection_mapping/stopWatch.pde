void drawStopWatch(int second, int len, int x, int y) {
  noStroke();
  fill(0, 30, 0);
  draw_nums(88, x-len*2, y, len*1.5);
  draw_nums(88, x+len*1.5, y+len*0.5, len);
  fill(0, 255, 0);
  draw_nums(second/60, x-len*2, y, len*1.5);
  draw_nums(second%60, x+len*1.5, y+len*0.5, len);
}


void draw_nums(int nums, float x, float y, float len) {
  if (nums == -1) {
    draw_num(-1, x, y, len);
    return;
  }
  draw_num(nums/10, x-len*0.65, y, len);
  draw_num(nums%10, x+len*0.65, y, len);
}

void draw_num(int num, float x, float y, float len) {
  float _len = len * 0.85;
  switch(num) {
  case -1:
    ellipse(x, y-len*0.4, len*0.15, len*0.15);
    ellipse(x, y+len*0.4, len*0.15, len*0.15);
    break;
  case 0:
    digital_row(x, y-len, _len);
    digital_row(x, y+len, _len);
    digital_line(x-len*0.5, y-len*0.5, _len);
    digital_line(x-len*0.5, y+len*0.5, _len);
    digital_line(x+len*0.5, y-len*0.5, _len);
    digital_line(x+len*0.5, y+len*0.5, _len);
    break;
  case 1:
    digital_line(x+len*0.5, y-len*0.5, _len);
    digital_line(x+len*0.5, y+len*0.5, _len);
    break;
  case 2:
    digital_row(x, y-len, _len);
    digital_row(x, y, _len);
    digital_row(x, y+len, _len);
    digital_line(x-len*0.5, y+len*0.5, _len);
    digital_line(x+len*0.5, y-len*0.5, _len);
    break;
  case 3:
    digital_row(x, y-len, _len);
    digital_row(x, y, _len);
    digital_row(x, y+len, _len);
    digital_line(x+len*0.5, y-len*0.5, _len);
    digital_line(x+len*0.5, y+len*0.5, _len);
    break;
  case 4:

    digital_row(x, y, _len);
    digital_line(x-len*0.5, y-len*0.5, _len);
    digital_line(x+len*0.5, y-len*0.5, _len);
    digital_line(x+len*0.5, y+len*0.5, _len);
    break;
  case 5:
    digital_row(x, y-len, _len);
    digital_row(x, y, _len);
    digital_row(x, y+len, _len);
    digital_line(x-len*0.5, y-len*0.5, _len);
    digital_line(x+len*0.5, y+len*0.5, _len);
    break;
  case 6:
    digital_row(x, y-len, _len);
    digital_row(x, y, _len);
    digital_row(x, y+len, _len);
    digital_line(x-len*0.5, y-len*0.5, _len);
    digital_line(x-len*0.5, y+len*0.5, _len);
    digital_line(x+len*0.5, y+len*0.5, _len);
    break;
  case 7:
    digital_row(x, y-len, _len);
    digital_line(x-len*0.5, y-len*0.5, _len);
    digital_line(x+len*0.5, y-len*0.5, _len);
    digital_line(x+len*0.5, y+len*0.5, _len);
    break;
  case 8:
    digital_row(x, y-len, _len);
    digital_row(x, y, _len);
    digital_row(x, y+len, _len);
    digital_line(x-len*0.5, y-len*0.5, _len);
    digital_line(x-len*0.5, y+len*0.5, _len);
    digital_line(x+len*0.5, y-len*0.5, _len);
    digital_line(x+len*0.5, y+len*0.5, _len);
    break;
  case 9:
    digital_row(x, y-len, _len);
    digital_row(x, y, _len);
    digital_row(x, y+len, _len);
    digital_line(x-len*0.5, y-len*0.5, _len);
    digital_line(x+len*0.5, y-len*0.5, _len);
    digital_line(x+len*0.5, y+len*0.5, _len);
    break;
  default:
    break;
  }
}

void digital_row(float x, float y, float len) {
  beginShape();
  vertex(x-len*0.55, y);
  vertex(x-len*0.5, y-len*0.03535534);
  vertex(x+len*0.5, y-len*0.03535534);
  vertex(x+len*0.55, y);
  vertex(x+len*0.5, y+len*0.03535534);
  vertex(x-len*0.5, y+len*0.03535534);
  endShape(CLOSE);
}

void digital_line(float x, float y, float len) {
  beginShape();
  vertex(x, y-len*0.55);
  vertex(x-len*0.03535534, y-len*0.5);
  vertex(x-len*0.03535534, y+len*0.5);
  vertex(x, y+len*0.55);
  vertex(x+len*0.03535534, y+len*0.5);
  vertex(x+len*0.03535534, y-len*0.5);
  endShape(CLOSE);
}