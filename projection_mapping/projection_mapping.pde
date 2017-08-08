import http.requests.*;
import java.util.LinkedList;

String BearerAccessToken = "";
String searchURL = "";

StringList id_list    = new StringList();
LinkedList tweet_list = new LinkedList();

void setup() {
  setAccessToken();
  setSearchURL("草");
  //checkLimit();
}

//void draw() {
//  search();
//}