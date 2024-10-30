const std = @import("std");

const WIDTH = 600;
const HEIGHT = 600;

const Vec3 = struct {
    x: u8,
    y: u8,
    z: u8,
};

pub fn main() !void {
    var file = try std.fs.cwd().createFile(
        "test.ppm",
        .{ .read = true },
    );
    defer file.close();

    var pixels = [_]Vec3{
        Vec3{ .x = 255, .y = 0, .z = 255 },
        Vec3{ .x = 0, .y = 0, .z = 0 },
        Vec3{ .x = 255, .y = 0, .z = 255 },
        Vec3{ .x = 0, .y = 0, .z = 0 },
    };

    var pixSlice: []Vec3 = pixels[0..];
    try renderPPMBuffer(&pixSlice, &file);
}

fn renderPPMBuffer(pixels: *[]Vec3, file: *std.fs.File) !void {
    const pix = pixels.*;
    const header = try std.fmt.allocPrint(std.heap.page_allocator, "P6\n{} {}\n255\n", .{ WIDTH, HEIGHT });
    _ = try file.write(header);
    var buf = std.io.bufferedWriter(file.writer());
    var w = buf.writer();
    for (pix, 0..) |p, i| {
        if (i * 3 % buf.buf.len == 0) {
            try buf.flush();
        }
        const b = [_]u8{ p.x, p.y, p.z };
        _ = try w.write(&b);
    }
}

test "simple test" {}
