#define FDC_DMA_BUF_ADDR   0x80000
#define FDC_DMA_BUF_SIZE   512

#define KBD_STATUS         0x64
#define KBD_DATA           0x60
#define KEY_UP_BIT         0x80
#define SCREEN_WIDTH       320

int xpos = 100;
int fdc_running = 0;
void boot2();
// Cylinder,Head,Sector
void toPairCHS(int block,int out[])
{
out[0] = block / 36;
out[1] = (block - 36 * out[0]) / 18;
out[2] = block - 36 * out[0] - 18 * out[1] + 1;
}
/* boot2() が最初に呼ばれる
 */
void boot2() {
  unsigned char* ptr;

  register_handlers();
  fdc_initialize();
  ptr = (unsigned char*)FDC_DMA_BUF_ADDR;

  for (int i = 0; i < FDC_DMA_BUF_SIZE; i++) {
    ptr[i]=0x00;
  }
  ptr[0] = 'A';
  ptr[1] = 'B';

  // 19ブロックにTEST.TXTがあった．
  // Directroy構造的の定義より，
  // 最後の6Bit:04 00 00 02 00 00
  // 26,27ビット目がFATの要素番号
  // 28,29,30,31ビット目がサイズ
  // それぞれの項目がリトルエンディアン
  // 0x00000200 = 512Byte
  // 0x0004 = FAT番号4 = 35セクタ
  int pair[3];
  toPairCHS(35,pair);

  fdc_running = 1;
  fdc_write(pair[0], pair[1], pair[2]);
  while (fdc_running)
    halt();

  fdc_write2();
  fdc_running = 0;

  // 問題２
  // ３つ目のファイルを追加したい１9セクタ：Writeで上書きされるので先にReadする必要がある
  toPairCHS(19,pair);

  //19セクタBOOTOBJファイルの要素番号5 -> FAT[5] = 0xff6
  //TEST.TXT ->  FAT[4] = 0xf00

  fdc_initialize();
  fdc_running = 1;
  fdc_read(pair[0], pair[1], pair[2]);
  while (fdc_running)
    halt();
  fdc_read2();
  fdc_running = 0;

  // ２つファイルがあるので、32*2Bitに続ける
  #define SHIFT 32*2
  ptr[0+SHIFT]='T';
  ptr[1+SHIFT]='E';
  ptr[2+SHIFT]='S';
  ptr[3+SHIFT]='T';
  ptr[4+SHIFT]='2';
  ptr[5+SHIFT]=0x20;
  ptr[6+SHIFT]=0x20;
  ptr[7+SHIFT]=0x20;
  ptr[8+SHIFT]='T';
  ptr[9+SHIFT]='X';
  ptr[10+SHIFT]='T';
  ptr[11+SHIFT]=0x20;//ファイル属性:通常は0x20
  ptr[12+SHIFT]=0x00;//予約領域：通常は0x00
  //TEST.TXTの数値を代用
  ptr[18+SHIFT]=0x9a;
  ptr[19+SHIFT]=0x39;
  ptr[20+SHIFT]=0x6b;
  ptr[21+SHIFT]=0x39;
  ptr[22+SHIFT]=0x40;
  ptr[23+SHIFT]=0x00;
  ptr[24+SHIFT]=0x6a;
  ptr[25+SHIFT]=0x39;

  ptr[26+SHIFT]=0x30;
  ptr[27+SHIFT]=0x00;

// 512Byte size
  ptr[28+SHIFT]=0x00;
  ptr[29+SHIFT]=0x02;

  toPairCHS(19,pair);

// 19セクタ上書き
  fdc_initialize();
  fdc_running = 1;
  fdc_write(pair[0], pair[1], pair[2]);
  while (fdc_running)
    halt();
  fdc_write2();
  fdc_running = 0;

  while (1)
    halt();
}

int kbd_handler() {
  out8(0x20, 0x61);	/* キーボード割り込み (IRQ1) を再度有効にする */
  int key = in8(KBD_DATA);
  if ((key & KEY_UP_BIT) == 0) {
    print(0, xpos, 60, 14);
    xpos += 5;
  }
}

int fdc_handler() {
  out8(0x20, 0x66);	/* フロッピーディスク割り込み (IRQ6) を再度有効にする */
  fdc_running = 0;
}

/* 割り込み処理関数を登録する
 */
int register_handlers() {
  int* ptr = (int*)0x7e00;
  *ptr = (int)kbd_handler;
  *(ptr + 2) = (int)fdc_handler;

  /* 割り込みを有効にする */
  sti();
  out8(0x21, 0xb9);	/* PIC0_IMR: accept only IRQ 1,6 and IRQ2 (PIC1) */
  out8(0xa1, 0xff);	/* PIC1_IMR: no interrupt */
}

int print(int num, int x, int y, int color) {
  static char bitmaps[][4] = {
    { 0x7e, 0x81, 0x81, 0x7e },	/* 0 */
    { 0x00, 0x41, 0xff, 0x01 }	/* 1 */
  };

  int i, j;
  char* vram = (char*)0xa0000;
  char* map = bitmaps[num];
  vram += y * SCREEN_WIDTH;
  for (i = 0; i < 8; i++) {
    for (j = 0; j < 4; j++) {
      char bits = map[j];
      if (bits & (0x80 >> i))
        *(vram + x + j) = color;
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
