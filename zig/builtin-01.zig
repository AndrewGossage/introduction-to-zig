// cd zig && zig run builtin-01.zig  && zig run builtin-01.zig -O ReleaseFast
const std = @import("std");
const builtin = @import("builtin");

pub fn main() !void {
    debug("Hello {t}{t}!\n", .{builtin.target.os.tag, builtin.target.cpu.arch});
    debug("Zig Version {s}\n\n", .{builtin.zig_version_string });
}

fn debug(comptime fmt: []const u8, args: anytype) void {
    if (builtin.mode == .Debug){
        std.debug.print(fmt, args);
    } else {
        std.debug.print("No debug for you! \n", .{});
    }
}


