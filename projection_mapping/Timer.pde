class Timer {
  int beforeMilliSeconds;
  int remainMilliSeconds;

  Webmo webmo;

  private int webmoDegree;

  Timer(String addr) {
    this.webmo = new Webmo(addr);
    this.remainMilliSeconds = FIRST_MILLISECONDS;
    if (this.remainMilliSeconds != 0) {
      webmo.rotate(SPEED);
      println("ON");
      this.beforeMilliSeconds = millis();
    }
  }

  void add(int textLength, int currentMilliSeconds) {
    if (this.remainMilliSeconds == 0) {
      webmo.rotate(SPEED);
      println("ON");
      this.beforeMilliSeconds = currentMilliSeconds;
    }
    this.remainMilliSeconds += additionalTime(textLength);
  }

  void consume(int currentMilliSeconds) {
    if (this.remainMilliSeconds == 0) {
      if (frameCount % 500 == 0 && webmoDegree - webmo.rotation() < 5) webmo.stop(false);
    } else if (this.remainMilliSeconds < 0) {
      webmo.stop(false);
      println("OFF");
      this.remainMilliSeconds = 0;
    } else {
      this.remainMilliSeconds -= currentMilliSeconds - this.beforeMilliSeconds;
      this.beforeMilliSeconds = currentMilliSeconds;
    }
  }

  void draw(int currentMilliSeconds) {
    drawStopWatch(this.remainMilliSeconds/1000, int(width*0.1-height*0.05625), int(width*0.5+height*0.28125), height/2);
    this.consume(currentMilliSeconds);
    if (frameCount % 500 == 0) webmoDegree = webmo.rotation();
  }

  void exit() {
    webmo.stop(false);
    println("OFF");
  }
}