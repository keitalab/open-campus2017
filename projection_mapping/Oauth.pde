void Oauth() {
  PostRequest post = new PostRequest("https://api.twitter.com/oauth2/token");
  post.addData("Authorization", CONSUMER_KEY + ":" + CONSUMER_SECRET);
  post.send();
  println("Reponse Content: " + post.getContent());
  println("Reponse Content-Length Header: " + post.getHeader("Content-Length"));
}

String Base64(String arg) {
  return arg;
}