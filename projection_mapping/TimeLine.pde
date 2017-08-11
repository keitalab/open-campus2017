class Timeline {
  LinkedList<PImage> tweet_list;
  PImage timeline_image;

  int timelineWidth  = int(height*.5625);
  int timelineHeight = height;

  final int ICON_SIZE = 64;

  final PFont BOLD    = createFont("Ricty BOLD", 30, true);
  final PFont REGULAR = createFont("Ricty", 22, true);

  final PImage MASK = loadImage("mask.png");
  final PImage TOOL = loadImage("tool.png");

  static final color BLUE                   = #1DA1F2;
  static final color BLACK                  = #14171A;
  static final color DARK_GRAY              = #657786;
  static final color LIGHT_GRAY             = #AAB8C2;
  static final color EXTRA_LIGHT_GRAY       = #E1E8ED;
  static final color EXTRA_EXTRA_LIGHT_GRAY = #F5F8FA;
  static final color WHITE                  = #FFFFFF;

  Timeline(String _searchStr) {
    tweet_list     = new LinkedList<PImage>();
    TOOL.resize(timelineWidth, int(timelineWidth*TOOL.height/TOOL.width));

    float glass_posX = timelineWidth/2-textWidth(_searchStr)/2-25;
    buffer = createGraphics(timelineWidth, timelineHeight);
    buffer.beginDraw();
    buffer.textAlign(LEFT, TOP);
    buffer.fill(WHITE);
    buffer.stroke(WHITE);
    buffer.rect(0, 0, timelineWidth, 65);
    buffer.fill(EXTRA_LIGHT_GRAY);
    buffer.rect(50, 25, timelineWidth-100, 30, 100);

    buffer.textFont(REGULAR, 24);
    buffer.fill(BLACK);
    buffer.textAlign(CENTER, CENTER);
    buffer.text(_searchStr, timelineWidth/2, 40);
    buffer.textAlign(LEFT, TOP);

    buffer.strokeWeight(2);
    buffer.stroke(DARK_GRAY);
    buffer.fill(EXTRA_LIGHT_GRAY);
    buffer.line(glass_posX, 40, glass_posX+9, 49);
    buffer.ellipse(glass_posX, 40, 16, 16);

    buffer.stroke(BLUE);
    buffer.noFill();
    buffer.beginShape();
    buffer.vertex(28, 30);
    buffer.vertex(20, 40);
    buffer.vertex(28, 50);
    buffer.endShape();
    buffer.strokeWeight(1);
  
    buffer.image(loadImage("status.png"), 0, 0, timelineWidth, 25);
    buffer.image(loadImage("category.png"), 0, 65, timelineWidth, 30);
    PImage menu = loadImage("menu.png");
    float menuHeight = timelineWidth*menu.height/menu.width;
    buffer.stroke(EXTRA_LIGHT_GRAY);
    buffer.rect(0, timelineHeight-menuHeight-1, timelineWidth, menuHeight);
    buffer.image(menu, 0, timelineHeight-menuHeight, timelineWidth, menuHeight);
    

    buffer.endDraw();
    this.timeline_image = buffer.get();



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

  /* TimeLine$TweetImage(Status status) is invalid.
   void add(Status status) {
   this.tweet_list.add((new TweetImage(status)).img);
   }
   */

  @Deprecated
    void add(String _name, String _screen_name, String _text, String _icon_url) {
    this.tweet_list.add(
      (new TweetImage(_name, _screen_name, _text, _icon_url)).img
      );
  }

  void draw() {
    fill(EXTRA_LIGHT_GRAY);
    stroke(EXTRA_LIGHT_GRAY);
    rect(0, 0, timelineWidth, timelineHeight);
    image(this.tweet_list.get(0), 0, 95);
    image(this.timeline_image, 0, 0);
  }

  class TweetImage {
    PImage img;

    //TweetImage(Status status) {
    //  User   user = status.getUser();
    //  String text = status.getText();
    //  textFont(BOLD);
    //  int lineNum = 1;
    //  float lineWidth = 0;
    //  for (int i = 0; i < text.length(); i++) {
    //    float _w = textWidth(text.charAt(i));
    //    if (lineWidth + _w > timelineWidth) {
    //      lineNum++;
    //      lineWidth = _w;
    //    } else {
    //      lineWidth += _w;
    //    }
    //  }      
    //  buffer.beginDraw();
    //  buffer.stroke(EXTRA_LIGHT_GRAY);
    //  buffer.fill(WHITE);
    //  buffer.rect(0, 0, buffer.width, buffer.height);
    //  PImage icon = loadImage(user.getProfileImageURLHttps(), "png");
    //  icon.mask(mask);
    //  buffer.image(icon, 15, 15, 60, 60);
    //  buffer.fill(BLACK);
    //  buffer.textFont(BOLD);
    //  buffer.text(user.getName(), 120, 15);

    //  buffer.text(text, 30, 130);

    //  buffer.fill(DARK_GRAY);
    //  buffer.textFont(REGULAR);
    //  buffer.text(user.getScreenName(), 120, 65);

    //  buffer.endShape();
    //  this.img = buffer.get(0, 0, timelineWidth, max(int(50+lineNum*g.textLeading), 100));
    //}

    @Deprecated
      TweetImage(String _name, String _screen_name, String _text, String _icon_url) {
      String text = _text;
      int tweetHeight;
      textFont(BOLD, 30);

      int lineNum = 1;
      float lineWidth = 0;
      for (int i = 0; i < text.length(); i++) {
        float _w = textWidth(text.charAt(i));
        if (lineWidth + _w > timelineWidth) {
          lineNum++;
          lineWidth = _w;
        } else {
          lineWidth += _w;
        }
      }
      tweetHeight = max(int(70+lineNum*g.textLeading), 110);

      buffer.beginDraw();

      buffer.stroke(EXTRA_LIGHT_GRAY);
      buffer.fill(WHITE);
      buffer.rect(0, 0, buffer.width, buffer.height);

      buffer.image(TOOL, 0, tweetHeight-TOOL.height-5);   

      PImage icon = loadImage(_icon_url, "png");
      println(icon.width, icon.height);
      icon.mask(MASK);
      buffer.image(icon, 15, 15, 60, 60);

      buffer.textAlign(LEFT, BOTTOM);
      buffer.fill(BLACK);
      buffer.textFont(BOLD, 22);
      buffer.text(_name, 85, 40);
      float nameWidth = textWidth(_name);
      buffer.fill(DARK_GRAY);
      buffer.textFont(REGULAR, 22);
      buffer.text(_screen_name, 95+nameWidth, 40);

      buffer.textAlign(LEFT, TOP);
      buffer.fill(BLACK);
      buffer.textFont(REGULAR, 24);
      buffer.text(text, 95, 45);

      buffer.stroke(LIGHT_GRAY);
      buffer.noFill();
      buffer.beginShape();
      buffer.vertex(timelineWidth-26, 24);
      buffer.vertex(timelineWidth-18, 32);
      buffer.vertex(timelineWidth-10, 24);
      buffer.endShape();

      buffer.endDraw();
      this.img = buffer.get(0, 0, timelineWidth, tweetHeight);
    }
  }
}