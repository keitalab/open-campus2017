import java.util.LinkedList;
import java.util.regex.Pattern;
import java.util.regex.Matcher;

Timeline timeline;

void settings() {
  size(1280, 720);
  // fullScreen();
  smooth();
}

void setup() {
  timeline = new Timeline("草");
  textAlign(CENTER, CENTER);
}

void draw() {
  background(0);
  timeline.draw();
}