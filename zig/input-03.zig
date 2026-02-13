// zig run input-03.zig -- hello world
const std = @import("std");
const Io = std.Io;

pub fn main(init: std.process.Init) !void {
    const arena: std.mem.Allocator = init.arena.allocator();
    const args = try init.minimal.args.toSlice(arena);
    for (args, 0..args.len) |arg, i| {
        if (i > 0) {
            std.log.info("{d} - {s}", .{ i, arg });
        }
    }
}
