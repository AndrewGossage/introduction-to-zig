#include <stdio.h>

extern int add(int a, int b);

int main(void) {
    printf("Hello, World!\n");
    int result = add(5, 3);
    printf("5 + 3 = %d\n", result);
    return 0;
}
