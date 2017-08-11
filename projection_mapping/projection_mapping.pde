import java.util.LinkedList;

Timeline timeline;
PGraphics buffer;

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
  
  background(0);
  //if (tweet_list.size() <= 0) return;
  timeline.draw();
  get(0, 0, timeline.timelineWidth, timeline.timelineHeight).save("output.png");
}

//void draw() {
//}