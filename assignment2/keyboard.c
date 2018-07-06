// boot2.c の代わり

#define KBD_STATUS    0x64
#define KBD_DATA      0x60
#define KEY_UP_BIT    0x80
#define SCREEN_WIDTH  320
// 関数 boot2() より前に他の関数の定義(実装)や、大域変数宣言を書いてはいけない
void boot2();

int myEventFlag = 0;//boolが使えない．
int myValue =0;

void boot2() {
  register_kbd_handler();
  int key = 0;
  while (1) {
    cli();
    if (myEventFlag) {
      // キー番号を保存してある大域変数を読み書き
      int value = myValue;
      sti();
      // キー番号を表示

        // 前回の表示を消す
      print(1, 10, 10, 0);
      print(0, 10, 10, 0);
      print(key >> 4,10,20,0);
      print(key & 0x0f,20,20,0);

        if (value & KEY_UP_BIT)    // if key up
          print(1, 10, 10, 15);
        else
          print(0, 10, 10, 15);

        key = value & 0x7f;

          print(key >> 4,10,20,10);
          print(key & 0x0f,20,20,10);


      myEventFlag = 0;
    }
    else
    {
      sti_and_halt();
    }
  }
}

int xpos = 100;//未使用

int kbd_handler() {
  out8(0x20, 0x61);	// PIC0_OCW2: accept IRQ1 again
  myValue = in8(KBD_DATA);
  myEventFlag = 1;
}

// 割り込み処理関数を登録する
int register_kbd_handler() {
  int* ptr = (int*)0x7e00;
  *ptr = (int)kbd_handler;
  sti();
  out8(0x21, 0xf9);	// PIC0_IMR: accept only IRQ1 and IRQ2 (PIC1)
  out8(0xa1, 0xff);	// PIC1_IMR: no interrupt
}

int print(int num, int x, int y, int color) {
  static char bitmaps[][4] = {
    { 0x7e, 0x81, 0x81, 0x7e },	// 0
    { 0x00, 0x41, 0xff, 0x01 },	// 1
    { 0x61, 0x83, 0x85, 0x79}, // 2
     { 0x42, 0x91,0x99,0x66 }, // 3
    { 0xf8, 0x08,0xff,0x08 }, // 4
    { 0xf1, 0x91,0x89,0x8f }, // 5
    { 0xff, 0x89,0x89,0x8f }, // 6
    { 0xc0, 0x80,0x80,0xff }, // 7
    { 0x66, 0x99,0x99,0x66 }, // 8
    { 0xf0, 0x90,0x90,0xff }, // 9
    { 0x7f, 0x90,0x90,0xe7f }, // A
    { 0xff, 0x91,0x91,0x6e }, // B
    { 0xff, 0x81,0x81,0x81 }, // C
    { 0xff, 0x81,0x81,0x7e }, // D
    { 0xff, 0x91,0x91,0x91 }, // E
    { 0xff, 0x90,0x90,0x90 } // F
  };

  int i, j;
  char* vram = (char*)0xa0000;
  char* map = bitmaps[num];
  vram += (y * SCREEN_WIDTH + x);

  for (i = 0; i < 8; i++) {
    for (j = 0; j < 4; j++) {
      char bits = map[j];
      if (bits & (0x80 >> i))
        *(vram + j) = color;
    }

    vram += SCREEN_WIDTH;
  }

  return 0;
}

// in 命令で port の値 (8bit) を読む
int in8(int port) {
  int value;
  asm volatile ("mov $0, %%eax\n\tin %%dx,%%al"
                : "=r" (value) : "d" (port));
  return value;
}

// out 命令で port に値 (8bit) を書き込む
int out8(int port, int value) {
  asm volatile ("out %%al,%%dx"
                : : "d" (port), "a" (value));
  return 0;
}

// sti 命令 (割り込み許可) を実行
int sti() {
  asm volatile ("sti");
  return 0;
}

// cli 命令 (割り込み禁止) を実行
int cli() {
  asm volatile ("cli");
  return 0;
}

// hlt 命令でプロセッサを停止させる
int halt() {
  asm volatile ("hlt");
  return 0;
}

// sti 命令と hlt 命令を連続して実行
// sti してから hlt までのわずかの時間に割り込みが発生しないようにする。
int sti_and_halt() {
  asm volatile ("sti\n\thlt");
  return 0;
}
