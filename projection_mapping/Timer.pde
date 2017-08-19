class Timer {
  final int SPEED = 800;

  int beforeMilliSeconds;
  int remainMilliSeconds;
  String address;
  PostRequest post;


  final int ADD_MILLIS_PER_TWEET = 20000;

  Timer(String addr) {
    this.address = addr;
  }

  void add(int currentMilliSeconds) {
    if (this.remainMilliSeconds == 0) {
      this.post = new PostRequest("http://" + this.address + "/api/rotate/forever");
      this.post.addHeader("Content-Type", "application/x-www-form-urlencoded");
      this.post.addData("speed", Integer.toString(SPEED));
      this.post.send();
      println("ON : " + this.post.getContent());
      this.beforeMilliSeconds = currentMilliSeconds;
    }
    this.remainMilliSeconds += ADD_MILLIS_PER_TWEET;
  }

  void consume(int currentMilliSeconds) {
    if (this.remainMilliSeconds == 0) return;
    else if (this.remainMilliSeconds < 0) {
      this.post = new PostRequest("http://" + this.address + "/api/stop");
      this.post.addHeader("Content-Type", "application/x-www-form-urlencoded");
      this.post.addData("smooth", Boolean.toString(true));
      this.post.send();
      println("OFF : " + this.post.getContent());
      this.remainMilliSeconds = 0;
    } else {
      this.remainMilliSeconds -= currentMilliSeconds - this.beforeMilliSeconds;
      this.beforeMilliSeconds = currentMilliSeconds;
    }
  }

  void draw(int currentMilliSeconds) {
    this.consume(currentMilliSeconds);
    drawStopWatch(this.remainMilliSeconds/1000, int(width*0.1-height*0.05625), int(width*0.5+height*0.28125), height/2);
  }

  void exit() {
    this.post = new PostRequest("http://" + this.address + "/api/stop");
    this.post.addHeader("Content-Type", "application/x-www-form-urlencoded");
    this.post.addData("smooth", Boolean.toString(true));
    this.post.send();
    println("OFF : " + this.post.getContent());
  }
}