// zig run c.zig -lc
const c = @cImport({
    @cInclude("stdio.h");
});

pub fn main() void {
    _ = c.printf("Hello %s %d\n", "world", @as(i8, 4));
}



