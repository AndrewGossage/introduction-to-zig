const std = @import("std");
const Io = std.Io;

const AnimalInterface = struct {
    writer: *std.Io.Writer,

    vtable: struct {
        speak: *const fn(*AnimalInterface) anyerror!void,
    },
    
    pub fn speak(self: *AnimalInterface) !void {
        try self.vtable.speak(self);
        try self.writer.flush();
    }
    
};

const Dog = struct {
    interface: AnimalInterface,

    pub fn init(writer: *std.Io.Writer) Dog {
        return .{.interface = .{.writer = writer, .vtable = .{.speak = bark} }};
    }

    pub fn bark(self: *AnimalInterface) !void {
        try self.writer.print("Woof!\n", .{});
    }

};


const Cat = struct {
    interface: AnimalInterface,

    pub fn init(writer: *std.Io.Writer) Cat {
        return .{.interface = .{.writer = writer, .vtable = .{.speak = meow} }};

    }
    
    pub fn meow(self: *AnimalInterface) !void {
        try self.writer.print("Meow!\n", .{});
    }

};




pub fn main(init: std.process.Init) !void {
    const io = init.io;
    var stdout_buffer: [1024]u8 = undefined;
    var stdout_file_writer: Io.File.Writer = Io.File.Writer.init(.stdout(), io, &stdout_buffer);
    const stdout_writer = &stdout_file_writer.interface;
    
    var dog: Dog = .init(stdout_writer);
    try dog.interface.speak();

    var cat: Cat = .init(stdout_writer);
    try cat.interface.speak();
}


