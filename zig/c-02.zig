// zig build-obj zig/c-02.zig && zig cc -o program zig/zig.c c-02.o && ./program
export fn add(a: c_int, b: c_int) c_int {
    return a + b;
}


// zig.c
// #include <stdio.h>
//
// extern int add(int a, int b);
//
// int main(void) {
//     printf("Hello, World!\n");
//     int result = add(5, 3);
//     printf("5 + 3 = %d\n", result);
//     return 0;
// }
