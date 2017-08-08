class TweetData {
  // tweet ID
  String tweet_id;
  // tweet text include hashtag
  String text;

  // user_name on Twitter
  String user_name;
  // screen name on Twitter
  String screen_name;

  // user icon
  PImage icon;

  @Deprecated
    String date;

  TweetData(JSONObject json) {
    JSONObject user  = json.getJSONObject("user");
    this.tweet_id    = json.getString("id_str");
    this.text        = json.getString("text");
    this.user_name   = user.getString("name");
    this.screen_name = user.getString("screen_name");
    this.icon        = loadImage(user.getString("profile_image_url", "png"));
    this.date = json.getString("created_at");
    
    id_list.append(this.tweet_id);
  }

  void draw() {
    rect(50, 100, 300, 100, 10);
  }

  @Override
    boolean equals(Object obj) {
    if (!(obj instanceof TweetData)) return false;
    return this.tweet_id == ((TweetData)obj).tweet_id;
  }

  @Override
    public String toString() {
    return this.tweet_id + "\n"
      + this.user_name + "(@" + this.screen_name + ")\n"
      + this.text + "\n"
      + this.date;
  }

  @Override
    int hashCode() {
    return this.tweet_id.hashCode();
  }
}