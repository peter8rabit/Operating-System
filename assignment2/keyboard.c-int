/* boot2.c の代わり
 */

#define KBD_STATUS    0x64
#define KBD_DATA      0x60
#define KEY_UP_BIT    0x80
#define SCREEN_WIDTH  320

/* 関数 boot2() より前に他の関数の定義(実装)や、大域変数宣言を書いてはいけない
 */

void boot2() {
  while ((in8(KBD_STATUS) & 1) == 0)
    ;

  int value = in8(KBD_DATA);
  if (value & KEY_UP_BIT)    /* if key up */
    print(1, 100, 50, 15);
  else
    print(0, 100, 50, 15);

  int key = value & 0x7f;
  halt();
}

/* 戻り値が int である関数は事前に宣言しなくても
   よいので、全ての関数の戻り値を int にしておく。
   適当な戻り値がない場合は 0 を返すことにする。
*/

int xpos = 100;

int kbd_handler() {
  out8(0x20, 0x61);	/* PIC0_OCW2: accept IRQ1 again */
  int value = in8(KBD_DATA);

  /* 表示: ここを書き換えればよい */
  print(0, xpos, 60, 14);
  xpos += 5;
}

/* 割り込み処理関数を登録する
 */
int register_kbd_handler() {
  int* ptr = (int*)0x7e00;
  *ptr = (int)kbd_handler;
  sti();
  out8(0x21, 0xf9);	/* PIC0_IMR: accept only IRQ1 and IRQ2 (PIC1) */
  out8(0xa1, 0xff);	/* PIC1_IMR: no interrupt */
}

int print(int num, int x, int y, int color) {
  static int bitmaps[][4] = {
    { 0x7e, 0x81, 0x81, 0x7e },	/* 0 */
    { 0x00, 0x41, 0xff, 0x01 }	/* 1 */
  };

  int i, j;
  char* vram = (char*)0xa0000;
  int* map = bitmaps[num];
  vram += (y * SCREEN_WIDTH + x);

  for (i = 0; i < 8; i++) {
    for (j = 0; j < 4; j++) {
      int bits = map[j];
      if (bits & (0x80 >> i))
        *(vram + j) = color;
    }

    vram += SCREEN_WIDTH;
  }

  return 0;
}

/* in 命令で port の値 (8bit) を読む
 */
int in8(int port) {
  int value;
  asm volatile ("mov $0, %%eax\n\tin %%dx,%%al"
                : "=r" (value) : "d" (port));
  return value;
}

/* out 命令で port に値 (8bit) を書き込む
 */
int out8(int port, int value) {
  asm volatile ("out %%al,%%dx"
                : : "d" (port), "a" (value));
  return 0;
}

/* sti 命令 (割り込み許可) を実行
 */
int sti() {
  asm volatile ("sti");
  return 0;
}

/* cli 命令 (割り込み禁止) を実行
 */
int cli() {
  asm volatile ("cli");
  return 0;
}

/* hlt 命令でプロセッサを停止させる
 */
int halt() {
  asm volatile ("hlt");
  return 0;
}

/* sti 命令と hlt 命令を連続して実行
 * sti してから hlt までのわずかの時間に
 * 割り込みが発生しないようにする。
 */
int sti_and_halt() {
  asm volatile ("sti\n\thlt");
  return 0;
}
