const std = @import("std");


pub fn main() !void {
    gen_ts(Foo);
    gen_ts(Bar);
}

const Bar = struct {
    first: i32,
    second: []const u8,
    foo: Foo,
};

const Foo = struct {
    first: i32,
    second: i32,
    thing: union {
        i: i32,
        q: union {
            b: bool,
            s: []const u8,

        },
    },
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
        .@"union" => convert_union(T),
        else => @compileError("Unsupported type"),
    };
}

inline fn convert_name(comptime T: type) [@typeName(T).len]u8 {
    const tn = @typeName(T);
    var name: [@typeName(T).len]u8 = undefined;
    inline for (0..name.len) |i| {
        if (tn[i] == '.') {
            name[i] = '_';
        } else {
            name[i] = tn[i];
        }
    }
    return name;
}



inline fn convert_union(comptime T: type) []const u8 {
    const len = comptime blk: {
        var l: usize = 0;
        for (@typeInfo(T).@"union".fields) |field| {
            const tn = convert_type(field.type);
            l += tn.len + 3;
        }
        break :blk l - 3;
    };

    const f = comptime blk: {
        var arr: [len]u8 = [_]u8{0} ** len;
        var i: usize = 0;
        var c: usize = 0;
        for (@typeInfo(T).@"union".fields) |field| {
            const tn = convert_type(field.type);
            c += 1;
            for (0..tn.len) |j| {
                arr[i] = tn[j];
                i += 1;
            }
            if (c < @typeInfo(T).@"union".fields.len) {
                arr[i] = ' ';
                i += 1;
                arr[i] = '|';
                i += 1;
                arr[i] = ' ';
                i += 1;
            }
        }
        break :blk arr;
    };

    return &f;
}


