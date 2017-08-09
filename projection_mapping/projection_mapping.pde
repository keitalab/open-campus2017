import java.util.LinkedList;

String track = "草";

LinkedList<TweetData> tweet_list = new LinkedList<TweetData>();

void setup() {
  StatusListener listener = new StatusListener() {
    @Override
      public void onStatus(Status status) {
      System.out.println("@" + status.getUser().getScreenName() + " - " + status.getText());
    }

    @Override
      public void onDeletionNotice(StatusDeletionNotice statusDeletionNotice) {
      System.out.println("Got a status deletion notice id:" + statusDeletionNotice.getStatusId());
    }

    @Override
      public void onTrackLimitationNotice(int numberOfLimitedStatuses) {
      System.out.println("Got track limitation notice:" + numberOfLimitedStatuses);
    }

    @Override
      public void onScrubGeo(long userId, long upToStatusId) {
      System.out.println("Got scrub_geo event userId:" + userId + " upToStatusId:" + upToStatusId);
    }

    @Override
      public void onStallWarning(StallWarning warning) {
      System.out.println("Got stall warning:" + warning);
    }

    @Override
      public void onException(Exception ex) {
      ex.printStackTrace();
    }
  };
  
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
  filter.track(track);
  twitterStream.filter(filter);
}

void draw() {
}