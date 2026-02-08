const std = @import("std");
const Io = std.Io;

const AnimalInterface = struct {
    writer: *std.Io.Writer,
    speak_fn: *const fn (*AnimalInterface) anyerror!void,
    pub fn speak(self: *AnimalInterface) !void {
        try self.speak_fn(self);
    }
};

const Dog = struct {
    interface: AnimalInterface,
    treats_received: i32 = 0,
    pub fn init(writer: *std.Io.Writer) Dog {
        return .{ .interface = .{
            .writer = writer,
            .speak_fn = bark,
        } };
    }
    pub fn bark(interface: *AnimalInterface) !void {
        const self: *Dog = @fieldParentPtr("interface", interface);
        try interface.writer.print("Woof! treats received: {d}\n", .{self.treats_received});
        self.treats_received += 1;
        try interface.writer.flush();
    }
};

const Cat = struct {
    interface: AnimalInterface,
    times_scared: i32 = 100,
    pub fn init(writer: *std.Io.Writer) Cat {
        return .{ .interface = .{
            .writer = writer,
            .speak_fn = meow,
        } };
    }
    pub fn meow(interface: *AnimalInterface) !void {
        const self: *Cat = @fieldParentPtr("interface", interface);
        try interface.writer.print("Meow! Times Scared: {d}\n", .{self.times_scared});
        self.times_scared += 1;
        try interface.writer.flush();
    }
};

pub fn main(init: std.process.Init) !void {
    const io = init.io;
    var stdout_buffer: [1024]u8 = undefined;
    var stdout_file_writer: Io.File.Writer = Io.File.Writer.init(.stdout(), io, &stdout_buffer);
    const stdout_writer = &stdout_file_writer.interface;
    var dog: Dog = .init(stdout_writer);
    var cat: Cat = .init(stdout_writer);
    const interfaces: [2]*AnimalInterface = .{ &dog.interface, &cat.interface };
    for (0..3) |_| {
        for (interfaces) |animal| { 
            try animal.speak();
        }
    }
}
