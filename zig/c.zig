// zig run ./zig/c.zig -lc

const std = @import("std");
const c = @cImport({
    @cInclude("stdio.h");
});

pub fn main(init: std.process.Init) void {
    _ = init;
    _ = c.printf("Hello %s %d\n", "world", @as(i8, 4));
}



