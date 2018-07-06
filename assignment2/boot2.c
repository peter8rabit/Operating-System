// このプログラムは裸のハードウェアの上で動くので、
// printf 等のライブラリ関数は利用できない。
// 全て自分で実装しなければならない。

// halt のような補助関数を定義するときは先に宣言する
static void halt();

// boot1.asm の最後の命令は
// boot2.c の一番最初に書かれた関数へ jump する
void boot2() {
  int i;

  // Video メモリの先頭アドレス
  // 320 x 200 dot. 1 dot あたり 8bit の色番号
  char* ptr = (char*)0xa0000;

  ptr += 320 * 10;  // 10ドット下から描き始める
  while (ptr < 0xa0f00)
    *ptr++ = 15;    // 白

  // 最後には必ず halt を呼ぶ
  halt();
}

// 無限ループで停止
static void halt() {
  while(1);
}
