var Twit = require('twit');

var queary_word='#hoge';//ハッシュタグを書く

var T = new Twit({
  consumer_key: 'xxxxx',
  consumer_secret: 'xxxxx',
  access_token: 'xxxxx',
  access_token_secret: 'xxxxx'
});


T.get('search/tweets', { q: queary_word, count: 100 }, function(err, data, response) {
    
      console.log(Object.keys(data.statuses).length);//ヒットしたツイート数表示
   
})