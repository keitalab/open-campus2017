# projection_mapping

2017年度オープンキャンパスのSNSを用いた「IoTオルゴール」用のアニメーションプログラム

`key.pde` は以下のように書き換えること。

```java:key.pde
final String CONSUMER_KEY    = "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
final String CONSUMER_SECRET = "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
final String ACCESS_TOKEN    = "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
final String ACCESS_SECRET   = "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
```

## Node.jsとの連携

今回は [このサイト](http://qiita.com/tkyko13/items/d219a509d8367e272055) を参考に `oscP5` ライブラリを使ってProcessingは5000番ポートから `ON` と `OFF` の２つの `AddrPatern` を送信しています。 また、Processing側の受信ポートは6000番ポートに設定してあります。