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

  //timeline.add(
  //  "M A N O", 
  //  "@fms_eraser", 
  //  "hoge #hoge fuga @fms_eraser piyo http://keita-lab.jp", 
  //  "https://pbs.twimg.com/profile_images/740372411632082944/WkElPWj1_400x400.jpg"
  //  );
  textAlign(CENTER, CENTER);
}

void draw() {
  background(0);
  timeline.draw();
  //get(0, 0, timeline.timelineWidth, timeline.timelineHeight).save("output.png");
  //exit();
}