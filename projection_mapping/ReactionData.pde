class ReactionData {
  // user name on Twitter
  String screen_name;
  // tweet text include hashtag
  String text;
  // user icon
  PImage icon;

  ReactionData(String _name, PImage _icon, String _text) {
    this.screen_name = _name;
    this.icon        = _icon;
    this.text        = _text;
  }

  ReactionData(int tweet_id) {
    /*
    load data from tweet id
     */
  }
  
  void draw() {
    rect(50, 100, 300, 100, 10);
  }
}