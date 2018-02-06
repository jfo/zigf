const bf = @import("./bf.zig").bf;

pub fn main() void {
    var storage = []u8{0} ** 30000;
    const src = "+++++";
    bf(src, storage[0..]);
}
