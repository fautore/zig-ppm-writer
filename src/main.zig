const std = @import("std");

const WIDTH = 600;
const HEIGHT = 600;

pub fn main() !void {
    const file = try std.fs.cwd().createFile(
        "test.ppm",
        .{ .read = true },
    );
    defer file.close();
    const str = try std.fmt.allocPrint(std.heap.page_allocator, "P6\n{} {}\n255\n", .{ WIDTH, HEIGHT });
    _ = try file.write(str);
    const p1 = [_]u8{
        255,
        0,
        255,
    };
    _ = try file.write(p1[0..p1.len]);
}

test "simple test" {}
