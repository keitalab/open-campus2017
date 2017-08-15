import java.util.LinkedList;
import java.util.regex.Pattern;
import java.util.regex.Matcher;

Timeline timeline;
Timer    timer;

void settings() {
  size(1280, 720);
  // fullScreen();
  smooth();
}

void setup() {
  timeline = new Timeline("草");
  timer    = new Timer("keitalab-oc.local");
  textAlign(CENTER, CENTER);
}

void draw() {
  background(0);
  timeline.draw();
  timer.draw(millis());
}

void exit() {
  timer.exit();
  super.exit();
}