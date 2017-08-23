// on macOS Sierra with Processing 3.3.4
import java.util.LinkedList;
import java.util.regex.Pattern;
import java.util.regex.Matcher;

Timeline timeline;
Timer    timer;

void settings() {
  //size(1280, 720);
  fullScreen();
  smooth();
}

void setup() {
  String [] searchStr = {"#IoTオルゴール", "#LoTオルゴール"}; 
  timeline = new Timeline(searchStr);
  timer    = new Timer("keitalab-orgel.local");
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