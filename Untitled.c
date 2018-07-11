#include <stdio.h>

void toPairCHS(int block,int out[])
{
out[0] = block / 36;
out[1] = (block - 36 * out[0]) / 18;
out[2] = block - 36 * out[0] - 18 * out[1] + 1;
}

int main(int argc, char const *argv[]) {
    int out[3];
    toPairCHS(34,out);
    printf("%d\n", out[2]);
}
