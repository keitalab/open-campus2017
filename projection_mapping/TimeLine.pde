class Timeline {  
  LinkedList<PImage> tweet_list;
  PImage timeline_image;
  PImage tweets_image;
  String searchStr;

  PGraphics buffer;

  int timelineWidth  = int(height*.5625);
  int timelineHeight = height;

  private float top_marginY    = 0;
  private int   new_tweet_tint = 0;

  Pattern highlight;

  final int ICON_SIZE = 64;

  final PFont BOLD    = createFont("Ricty BOLD", 22, true);
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
    this.searchStr = _searchStr;

    highlight = Pattern.compile("(" + suitRecognizeRegex("@[\\w]+")
      + ")|(" + suitRecognizeRegex("(http://|https://){1}[\\w\\.\\-/:\\#\\?\\=\\&\\;\\%\\~\\+]+")
      + ")|(" + suitRecognizeRegex("[#＃][Ａ-Ｚａ-ｚA-Za-z一-鿆0-9０-９ぁ-ヶｦ-ﾟー]+") + ")"
      );

    float glass_posX = timelineWidth/2-textWidth(_searchStr)/2-25;
    buffer = createGraphics(timelineWidth, timelineHeight);
    buffer.beginDraw();
    buffer.textAlign(LEFT, TOP);
    buffer.fill(WHITE);
    buffer.stroke(WHITE);
    buffer.rect(0, 30, timelineWidth, 40);
    buffer.fill(EXTRA_LIGHT_GRAY);
    buffer.rect(50, 30, timelineWidth-100, 30, 100);

    buffer.textFont(REGULAR, 24);
    buffer.fill(BLACK);
    buffer.textAlign(CENTER, CENTER);
    buffer.text(_searchStr, timelineWidth/2, 45);
    buffer.textAlign(LEFT, TOP);

    buffer.strokeWeight(2);
    buffer.stroke(DARK_GRAY);
    buffer.fill(EXTRA_LIGHT_GRAY);
    buffer.line(glass_posX, 45, glass_posX+9, 54);
    buffer.ellipse(glass_posX, 45, 16, 16);

    buffer.stroke(BLUE);
    buffer.noFill();
    buffer.beginShape();
    buffer.vertex(28, 35);
    buffer.vertex(20, 45);
    buffer.vertex(28, 55);
    buffer.endShape();
    buffer.strokeWeight(1);

    buffer.image(loadImage("status.png"), 0, 0, timelineWidth, 30);
    buffer.image(loadImage("category.png"), 0, 70, timelineWidth, 30);
    PImage menu = loadImage("menu.png");
    float menuHeight = timelineWidth*menu.height/menu.width;
    buffer.stroke(EXTRA_LIGHT_GRAY);
    buffer.rect(0, timelineHeight-menuHeight-1, timelineWidth, menuHeight);
    buffer.image(menu, 0, timelineHeight-menuHeight, timelineWidth, menuHeight);

    this.timeline_image = buffer.get();

    buffer.background(EXTRA_LIGHT_GRAY);
    this.tweets_image = buffer.get(0, 0, timelineWidth, timelineHeight-95);

    buffer.endDraw();

    // Streaming API setup
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
  }

  void add(Status status) {
    this.tweet_list.add(this.getTweetImage(status));
  }


  void draw() {
    fill(EXTRA_LIGHT_GRAY);
    stroke(EXTRA_LIGHT_GRAY);
    rect(0, 0, timelineWidth, timelineHeight);

    image(this.tweets_image, 0, 95 + this.top_marginY);

    if (this.tweet_list.size() != 0) {
      if (this.top_marginY >= this.tweet_list.get(0).height) {
        tint(255, new_tweet_tint);
        image(this.tweet_list.get(0), 0, 95);
        image(this.tweets_image, 0, 95 + this.tweet_list.get(0).height);
        tint(255, 255);
        if (this.new_tweet_tint > 255) {
          this.top_marginY = 0;
          this.tweet_list.remove(0);
          this.new_tweet_tint = 0;
          this.tweets_image = get(0, 95, timelineWidth, timelineHeight-95);
        } else this.new_tweet_tint += 15;
      } else this.top_marginY += 8;
    }


    image(this.timeline_image, 0, 0);

    textFont(BOLD, 18);
    fill(BLACK);
    text(hour()+":"+nf(minute(), 2), timelineWidth/2, 15);
  }

  // rewrite this class to method that return PImage

  PImage getTweetImage(Status status) {
    User   user        = status.getUser();
    String text        = status.getText();
    String name        = user.getName();
    String screen_name = "@" + user.getScreenName();
    int tweetHeight;
    float textLeading = buffer.textLeading;

    buffer.beginDraw();

    buffer.stroke(EXTRA_LIGHT_GRAY);
    buffer.fill(WHITE);
    buffer.rect(0, 0, buffer.width, buffer.height);

    buffer.textAlign(LEFT, BOTTOM);
    buffer.fill(BLACK);
    buffer.textFont(BOLD, 20);
    if (buffer.textWidth(name) > timelineWidth - 110) {
      screen_name = "";
      float len = buffer.textWidth("…") + 110;
      for (int i = 0; i < name.length(); i++) {
        len += buffer.textWidth(name.charAt(i));
        if (len > timelineWidth) {
          name = name.substring(0, i) + "…";
          break;
        }
      }
    } else {
      buffer.textFont(REGULAR, 22);
      if (buffer.textWidth(name) + buffer.textWidth(screen_name) > timelineWidth - 110) {
        float len = buffer.textWidth(name) + buffer.textWidth("…") + 110;
        for (int i = 0; i < screen_name.length(); i++) {
          len += buffer.textWidth(screen_name.charAt(i));
          if (len > timelineWidth) {
            screen_name = screen_name.substring(0, i) + "…";
            break;
          }
        }
      }
    }
    buffer.textFont(BOLD, 20);
    buffer.text(name, 85, 40);
    float nameWidth = buffer.textWidth(name);
    buffer.fill(DARK_GRAY);
    buffer.textFont(REGULAR);
    buffer.text(screen_name, 95+nameWidth, 40);

    buffer.textAlign(LEFT, TOP);
    buffer.fill(BLACK);
    buffer.textFont(REGULAR);
    int lineNum = 0;
    float lineWidth = 0;
    Matcher matcher = highlight.matcher(text);
    int highlight_start = -1;
    int highlight_end   = -1;
    int bold_start      = text.indexOf(searchStr);
    int bold_end        = text.indexOf(searchStr) + searchStr.length();
    if (matcher.find()) {
      highlight_start = matcher.start();
      highlight_end   = matcher.end();
    }
    for (int i = 0; i < text.length(); i++) {
      if (i == highlight_start) buffer.fill(BLUE);
      else if (i == highlight_end) {
        buffer.fill(BLACK);
        if (matcher.find()) {
          highlight_start = text.charAt(highlight_end) == ' ' ? matcher.start()+1 : matcher.start();
          highlight_end   = matcher.end();
        } else {
          highlight_start = -1;
          highlight_end   = -1;
        }
      }
      if (i == bold_start) buffer.textFont(BOLD, 20);
      else if (i == bold_end) {
        buffer.textFont(REGULAR);
        bold_start = text.indexOf(searchStr, bold_end);
        bold_end   = (bold_start == -1 ? -1 : bold_start+searchStr.length());
      }
      if (text.charAt(i) == '\n') {
        lineNum++;
        lineWidth = 0;
        continue;
      }
      float _w = buffer.textWidth(text.charAt(i));
      if (lineWidth + _w > timelineWidth-110) {
        lineNum++;
        lineWidth = 0;
      }
      buffer.text(text.charAt(i), 85+lineWidth, 45+lineNum*textLeading);
      lineWidth += _w;
    }

    tweetHeight = max(int(80 + (lineNum+1) * textLeading), 100);

    buffer.stroke(LIGHT_GRAY);
    buffer.noFill();
    buffer.beginShape();
    buffer.vertex(timelineWidth-25, 24);
    buffer.vertex(timelineWidth-17, 32);
    buffer.vertex(timelineWidth-9, 24);
    buffer.endShape();

    PImage icon = loadImage(user.getProfileImageURLHttps(), "png");
    icon.mask(MASK);
    buffer.image(icon, 15, 15, 60, 60);
    buffer.image(TOOL, 0, tweetHeight-TOOL.height-3);

    buffer.endDraw();
    return buffer.get(0, 0, timelineWidth, tweetHeight);
  }
}

String suitRecognizeRegex(String regex) {
  return "(^" + regex + ")|(\\s" + regex + ")|(\n" + regex + ")";
}