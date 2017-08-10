import java.util.LinkedList;

Timeline timeline;

void settings() {
  size(1280, 720);
  // fullScreen();
  smooth();
}

void setup() {
  timeline = new Timeline("hoge");

  timeline.add(
    "M A N O", 
    "@fms_eraser", 
    "hoge", 
    "https://pbs.twimg.com/profile_images/740372411632082944/WkElPWj1_400x400.jpg"
    );

  textAlign(LEFT, TOP);
}

void draw() {
  background(0);
  //if (tweet_list.size() <= 0) return;
  timeline.draw();
}