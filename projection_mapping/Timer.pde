class Timer {
  int beforeMilliSeconds;
  int remainMilliSeconds;
  Sender sender;

  final int ADD_MILLIS_PER_TWEET = 20000;

  Timer(PApplet pApplet) {
    this.sender = new Sender(pApplet, 5000, 6000);
  }

  void add(int currentMilliSeconds) {
    if (this.remainMilliSeconds == 0) {
      this.sender.send("ON");
      this.beforeMilliSeconds = currentMilliSeconds;
    }
    this.remainMilliSeconds += ADD_MILLIS_PER_TWEET;
  }

  void consume(int currentMilliSeconds) {
    if (this.remainMilliSeconds == 0) return;
    else if (this.remainMilliSeconds < 0) {
      this.sender.send("OFF");
      this.remainMilliSeconds = 0;
    } else {
      this.remainMilliSeconds -= currentMilliSeconds - this.beforeMilliSeconds;
      this.beforeMilliSeconds = currentMilliSeconds;
    }
  }

  void draw(int currentMilliSeconds) {
    this.consume(currentMilliSeconds);
    if (frameCount % 100 == 0) {
      println(nf(this.remainMilliSeconds / 60000, 2) + "m "
        + nf((this.remainMilliSeconds % 60000) / 1000, 2) + "s");
    }
    //println(this.remainMilliSeconds);
  }

  @Deprecated
    class Sender {
    NetAddress myRemoteLocation;
    OscP5 oscP5;

    Sender(PApplet pApplet, int recievePort, int sendPort) {
      myRemoteLocation = new NetAddress("127.0.0.1", recievePort);
      oscP5            = new OscP5(pApplet, sendPort);
    }

    void send(String message) {
      oscP5.send(new OscMessage(message), myRemoteLocation);
    }
  }
}