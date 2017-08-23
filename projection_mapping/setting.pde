/**
 webmoの回転速度(負の値を設定すること)
 default : -900
 */
final int SPEED = -900;

/**
 演奏時間を延長する長さを、ツイート文の長さに応じて決定します。
 @param textLength ツイート文の長さ
 @return 演奏を延長する時間(ミリ秒)
 @return 5000 if text.equals("#IoTオルゴール")
 @return 23000 if text.equals("#IoTオルゴール が面白い！ #明治大学 #明治FMS ")
 @return 60000 if textLength > 70
 */
int additionalTime(int textLength) {
  return min(textLength * 900 - 3100, 45000);
}

/**
 プログラムスタート時のタイマーにセットする時間(ミリ秒単位)
 一度中断してしまい、この時間からスタートしたいという場合はここに数値を入れること
 (分 * 60000 + 秒 * 1000) を入れる
 default : 0
 */
final int FIRST_MILLISECONDS = 0;