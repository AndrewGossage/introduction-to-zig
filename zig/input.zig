//  echo "Andrew" | zig run input.zig
const std = @import("std");

pub fn main(init: std.process.Init) !void {
    const io = init.io;
    std.debug.print("Enter your name: ", .{});
    const allocator = init.arena.allocator();
    const stdin_buffer = try allocator.alloc(u8, 256);
    var stdin_reader = std.Io.File.stdin().reader(io, stdin_buffer);
    const stdin = &stdin_reader.interface;

    const name = try stdin.takeDelimiterExclusive('\n');
    std.debug.print("\nHello {s}\n", .{name});
}
