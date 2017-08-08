void setAccessToken() {
  PostRequest post = new PostRequest("https://api.twitter.com/oauth2/token");
  post.addHeader("Authorization", "Basic " + java.util.Base64.getEncoder().encodeToString((CONSUMER_KEY + ":" + CONSUMER_SECRET).getBytes()));
  post.addHeader("Content-Type", "application/x-www-form-urlencoded;charset=UTF-8");
  post.addData("grant_type", "client_credentials");
  post.send();
  println(post.getContent());
  BearerAccessToken = "Bearer " + JSONObject.parse(post.getContent()).getString("access_token");
}

void setSearchURL(String searchStr) {
  searchURL = "https://api.twitter.com/1.1/search/tweets.json";
  try {
    searchURL += "?q="+ java.net.URLEncoder.encode(searchStr, "UTF-8");
  }
  catch(java.io.UnsupportedEncodingException e) {
    e.printStackTrace();
  }
  searchURL += "&lang=ja";
}

void search() {
  GetRequest get = new GetRequest(searchURL);
  get.addHeader("Authorization", BearerAccessToken);
  get.send();
  JSONArray statuses = JSONObject.parse(get.getContent()).getJSONArray("statuses");
  for (int i = statuses.size()-1; i >= 0 ; i--) {
    if(id_list.hasValue(statuses.getJSONObject(i).getString("id_str"))) continue;
    tweet_list.add(new TweetData(statuses.getJSONObject(i)));
    println(statuses.getJSONObject(i).getString("text"));
  }
}

void checkLimit() {
  GetRequest get = new GetRequest(
    "https://api.twitter.com/1.1/application/rate_limit_status.json?resources=search"
    );
  get.addHeader("Authorization", BearerAccessToken);
  get.send();
  println(JSONObject.parse(get.getContent()).getJSONObject("resources").getJSONObject("search").getJSONObject("/search/tweets"));
}