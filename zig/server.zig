const std = @import("std");

pub fn main(init: std.process.Init) !void {
    try listen( init.io);
}

fn listen(io: std.Io) !void {
    const addr: std.Io.net.IpAddress = try .resolve(io, "127.0.0.1", 8082);
    var tcp_server = try addr.listen(io, .{});
    var recv_buffer: [1024]u8 = undefined;
    var send_buffer: [1024]u8 = undefined;
    while (true) {
        var stream = try tcp_server.accept(io);
        var connection_reader = stream.reader(io, &recv_buffer);
        var connection_writer = stream.writer(io, &send_buffer);
        var server: std.http.Server = .init(&connection_reader.interface, &connection_writer.interface);
        var request = try server.receiveHead();
        const header: std.http.Header = .{ .name = "Content-Type", .value = "application/json" };
        try request.respond("{\"message\":\"success\"}", .{ .extra_headers = &.{header} });
    }
    return;
}
