class Timeline {
  LinkedList<TweetData> tweet_list;
  String searchStr;

  float timelineWidth  = height*.5625;
  float timelineHeight = height;

  final color BLUE                   = #1DA1F2;
  final color BLACK                  = #14171A;
  final color DARK_GRAY              = #657786;
  final color LIGHT_GRAY             = #AAB8C2;
  final color EXTRA_LIGHT_GRAY       = #E1E8ED;
  final color EXTRA_EXTRA_LIGHT_GRAY = #F5F8FA;
  final color WHITE                  = #FFFFFF;

  final PFont BOLD    = createFont("Ricty BOLD", 45, true);
  final PFont REGULAR = createFont("Ricty", 33, true);

  Timeline(String _searchStr) {
    tweet_list = new LinkedList<TweetData>();
    this.searchStr = new String(_searchStr);

    /* Streaming API setup
     
     FilterListener listener = new FilterListener();
     
     // build Configuration and TwitterStream by app keys.
     Configuration configuration = new ConfigurationBuilder().setOAuthConsumerKey(CONSUMER_KEY)
     .setOAuthConsumerSecret(CONSUMER_SECRET)
     .setOAuthAccessToken(ACCESS_TOKEN)
     .setOAuthAccessTokenSecret(ACCESS_SECRET)
     .build();
     TwitterStream twitterStream = new TwitterStreamFactory(configuration).getInstance();
     twitterStream.addListener(listener);
     
     // use POST statuses/filter in Streaming APIs
     FilterQuery filter = new FilterQuery();
     filter.track(_searchStr);
     twitterStream.filter(filter);
     
     */
  }

  void add(Status status) {
    this.tweet_list.add(new TweetData(status));
  }

  @Deprecated
    void add(String _name, String _screen_name, String _text, String _icon_url) {
    this.tweet_list.add(
      new TweetData(_name, _screen_name, _text, _icon_url)
      );
  }

  void draw() {
    fill(EXTRA_LIGHT_GRAY);
    rect(0, 0, timelineWidth, timelineHeight);
    fill(WHITE);
    rect(0, 0, timelineWidth, 50);
    fill(EXTRA_LIGHT_GRAY);
    rect(50, 10, timelineWidth-100, 30, 100);

    textFont(REGULAR);
    fill(BLACK);
    textSize(24);
    textAlign(CENTER, CENTER);
    text(this.searchStr, timelineWidth/2, 25);
    textAlign(LEFT, TOP);

    strokeWeight(2);
    float glass_posX = timelineWidth/2-textWidth(this.searchStr)/2-20;
    stroke(DARK_GRAY);
    fill(EXTRA_LIGHT_GRAY);
    line(glass_posX, 25, glass_posX+9, 34);
    ellipse(glass_posX, 25, 16, 16);


    stroke(BLUE);
    noFill();
    beginShape();
    vertex(30, 16);
    vertex(22, 25);
    vertex(30, 34);
    endShape();
    strokeWeight(1);

    this.tweet_list.get(0).draw(0, 50);
  }




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

    @Deprecated
      TweetData(String _name, String _screen_name, String _text, String _icon_url) {
      this.text        = _text;
      this.user_name   = _name;
      this.screen_name = _screen_name;
      this.icon        = loadImage(_icon_url, "jpg");
    }

    void draw(float x, float y) {
      stroke(EXTRA_LIGHT_GRAY);
      fill(WHITE);
      rect(x, y, timelineWidth, this.height());
      image(this.icon, x+15, y+15, 80, 80);
      fill(BLACK);
      textFont(BOLD);
      text(this.user_name, x+120, y+15);

      text(this.text, x+30, y+130);

      fill(DARK_GRAY);
      textFont(REGULAR);
      text(this.screen_name, x+120, y+65);
    }

    float height() {
      // pass
      return 300.0f;
    }

    @Override
      public String toString() {
      return this.user_name + "(@" + this.screen_name + ")\n" + this.text;
    }
  }
}