const std = @import("std");

pub fn main(init: std.process.Init) !void {
    var arena = init.arena;
    defer _ = arena.reset(.free_all);
    const allocator = arena.allocator();
    const resp = try fetch(allocator, init.io, "http://127.0.0.1:8082");
    std.debug.print("{s}\n", .{resp});
}


fn fetch(allocator: std.mem.Allocator, io: std.Io, path: []const u8) ![]const u8 {
    
    var client: std.http.Client = .{
        .allocator = allocator,
        .io = io,
        .now = try std.Io.Clock.real.now(io),
    };

    try client.ca_bundle.rescan(client.allocator, io, client.now.?);
    defer client.deinit();
    
    var result_body = std.Io.Writer.Allocating.init(allocator);
    defer result_body.deinit();
    
    const response = try client.fetch(.{
        .location = .{ .url = path },
        .method = .GET, // get is default 
        .response_writer = &result_body.writer,
    });
    
    if (response.status.class() != .success) {
        return error.HttpRequestFailed;
    }
    
    return try allocator.dupe(u8, result_body.written());
}


