class TweetData {
  // tweet text include hashtag
  String text;

  // user_name on Twitter
  String user_name;
  // screen name on Twitter
  String screen_name;

  // user icon
  PImage icon;

  TweetData(Status status) {
    User user        = status.getUser();
    
    this.text        = status.getText();
    this.user_name   = user.getName();
    this.screen_name = user.getScreenName();
    this.icon        = loadImage(user.getProfileImageURLHttps(), "png");
  }

  void draw() {
    rect(50, 100, 300, 100, 10);
  }

  @Override
    public String toString() {
    return this.user_name + "(@" + this.screen_name + ")\n" + this.text;
  }
}