#define KBD_STATUS    0x64
#define KBD_DATA      0x60
#define KEY_UP_BIT    0x80
#define SCREEN_WIDTH  320

char* pptr = (char *)(0xa0000 + SCREEN_WIDTH * 50 + 250);//racket
char* bptr = (char*)(0xa0000 + SCREEN_WIDTH * 50 + 10);//ball
//���̒e���͂Q�Ƃ���
int line1 =  (char *)(0xa0000 + SCREEN_WIDTH * 50 + 250);
int line2 =  (char *)(0xa0000 + SCREEN_WIDTH * 150 + 250);

int kbd_handler();
int timer_handler();
/* �擪�� main �֐��łȂ����΂Ȃ��Ȃ� */
int main() {
  /* ���荞�ݏ����֐����o�^�������B
   * �{���͂��̃v���O�������I�������Ƃ��ɁA
   * ���荞�ݏ����֐������ɖ߂��Ȃ����΂Ȃ��Ȃ����A
   * ���̃v���O�����͉i���ɏI�����Ȃ��̂ŁA
   * ���ɖ߂������͏ȗ������B
   */
  int* ptr = (int*)0x7e00;
  *ptr = (int)kbd_handler;
  *(ptr + 1) = (int)timer_handler;

  *bptr = 14;
  *pptr = 15;

  syscall(0,0);//�����_

  while (1)
    halt();
}

int kbd_handler() {
  out8(0x20, 0x61);    /* �L�[�{�[�h���荞�� (IRQ1) ���ēx�L���ɂ��� */
  int value = in8(KBD_DATA);
  
  if (value & KEY_UP_BIT)
    return 0;

   /* ���P�b�g������ */
  *pptr = 0;

  //���݂Ɉړ�
  if(pptr==line1)
   pptr = line2;
  else
    pptr=line1;

  /* ���P�b�g���`�� */
  *pptr = 15;
}

int ball_direction=0;//0�͉E�����A1�͍�����
int point_left=0;
int point_right=0;

int timer_handler() {
  out8(0x20, 0x60);     /* �^�C�}�[���荞�� (IRQ0) ���ēx�L���ɂ��� */

  /* �{�[�������� */
  *bptr = 0;
  //
  //�{�[�����E�[�����O�Ƀ��P�b�g�ɓ��������璵�˕Ԃ�
  if (bptr==pptr) {
    ball_direction = 1;
    *bptr = 15;//racket
    bptr--;
    *bptr = 15;
    return 0;
  }

  //�{�[�����E�[�ɂ������E�ɂP�_�ǉ�����
  if (bptr==(char *)(0xa0000 + SCREEN_WIDTH * 50 + 319)
      ||bptr==(char *)(0xa0000 + SCREEN_WIDTH * 150 + 319)) {
    syscall(point_left,++point_right);
    //�{�[�����V���������瓊�����Ԑ��͓K��
    int random = point_right+point_left;
    if (random%2==0)
      bptr=(char *)(0xa0000 + SCREEN_WIDTH * 50 + 1);
    else
      bptr=bptr=(char *)(0xa0000 + SCREEN_WIDTH * 150 + 1);
    *bptr = 15;
    ball_direction = 0;
    return 0;
  }

  //�{�[�������[�ɂ����獶�Ɉ��_�ǉ�����
  if (bptr==(char *)(0xa0000 + SCREEN_WIDTH * 50 + 0)
      ||bptr==(char *)(0xa0000 + SCREEN_WIDTH * 150 + 0)) {
    syscall(++point_left,point_right);
    //�{�[�����V���������瓊�����Ԑ��͓K�� MathRand�g���Ȃ��̂�
    int random = (point_right+point_left)*7;
    if (random%3==0)
      bptr=(char *)(0xa0000 + SCREEN_WIDTH * 50 + 1);
    else
      bptr=bptr=(char *)(0xa0000 + SCREEN_WIDTH * 150 + 1);
    *bptr = 15;
    ball_direction = 0;
    return 0;
  }

  /* �{�[���̈ʒu���ύX */
  if (ball_direction)
    bptr--;
  else
    bptr++;

   /* �{�[�����`�� */
  *bptr = 25;
}

/* �\�t�g�E�F�A���荞�� 0x30 �𔭐������� */
int syscall(int a, int b) {
  asm volatile ("int $0x30"
                : : "D" (a), "S" (b));
  return 0;
}

int in8(int port) {
  int value;
  asm volatile ("mov $0, %%eax\n\tin %%dx,%%al"
                : "=r" (value) : "d" (port));
  return value;
}

int out8(int port, int value) {
  asm volatile ("out %%al,%%dx"
                : : "d" (port), "a" (value));
  return 0;
}

int halt() {
  asm volatile ("hlt");
  return 0;
}

int sti() {
  asm volatile ("sti");
  return 0;
}

int cli() {
  asm volatile ("cli");
  return 0;
}
 
