const std = @import("std");

pub fn main() !void {
    gen_ts(Bar);
}

const Bar = struct {
    first: i32,
    second: []const u8,
    third: bool,
};

pub fn gen_ts(T: type) void {
    const name: [@typeName(T).len]u8 = convert_name(T);
    std.debug.print("interface {s} {{\n", .{name});
    inline for (@typeInfo(T).@"struct".fields) |field| {
        std.debug.print("    {s}: {s};\n", .{ field.name, convert_type(field.type) });
    }
    std.debug.print("}};\n", .{});
}

inline fn convert_type(comptime T: type) []const u8 {
    return switch (@typeInfo(T)) {
        .@"struct" => &convert_name(T),
        .int, .float => "number",
        .bool => "boolean",
        .pointer => |ptr_info| if (ptr_info.child == u8) "string" else "any[]",
        else => @compileError("Unsupported type"),
    };
}

inline fn convert_name(comptime T: type) [@typeName(T).len]u8 {
    const tn = @typeName(T);
    var name: [@typeName(T).len]u8 = undefined;
    inline for (0..name.len) |i| {
        if (tn[i] == '.' or tn[i] == '-') {
            name[i] = '_';
        } else {
            name[i] = tn[i];
        }
    }
    return name;
}





