# projection_mapping

2017年度オープンキャンパスのSNSを用いた「IoTオルゴール」用のアニメーションプログラム

Twitterで特定のタグをつけてツイートすると、そのテキストの長さに応じてオルゴールで音を奏でるというもの。

モーターにはwebmoを使用。

# settings

`key.pde` は以下のように書き換えること。

```java:key.pde
final String CONSUMER_KEY    = "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
final String CONSUMER_SECRET = "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
final String ACCESS_TOKEN    = "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
final String ACCESS_SECRET   = "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
```
