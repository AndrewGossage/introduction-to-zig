// cd zig && echo "Andrew" | zig run input-02.zig
const std = @import("std");

pub fn main(init: std.process.Init) !void {
    const io = init.io;
    if (try std.Io.File.stdin().isTty(io)){
        std.debug.print("Enter your name: ", .{});
    }
    var stdin_buffer: [1024]u8 = undefined;
    var stdin_reader = std.Io.File.stdin().reader(io, &stdin_buffer);
    const stdin = &stdin_reader.interface;

    const name = try stdin.takeDelimiterExclusive('\n');
    std.debug.print("\nHello {s}\n", .{name});
}
