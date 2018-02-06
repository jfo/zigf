const std = @import("std");
const assert = std.debug.assert;
const mem = std.mem;

fn bf(src: []const u8, storage: []u8) void {
    var memptr: u16 = 0;
    for (src) |c| {
        switch(c) {
            '+' => storage[memptr] +%= 1,
            '-' => storage[memptr] -%= 1,
            '>' => memptr += 1,
            '<' => memptr -= 1,
            else => undefined
        }
    }
}

pub fn main() void {
    var storage = []u8{0} ** 30000;
    const src = "+++++";
    bf(src, storage[0..]);
}

test "+" {
    var storage = []u8{0};
    const src = "+++";
    bf(src, storage[0..]);
    assert(storage[0] == 3);
}

test "-" {
    var storage = []u8{0};
    const src = "---";
    bf(src, storage[0..]);
    assert(storage[0] == 253);
}

test ">" {
    var storage = []u8{0} ** 5;
    const src = ">>>+++";
    bf(src, storage[0..]);
    assert(storage[3] == 3);
}

test "<" {
    var storage = []u8{0} ** 5;
    const src = ">>>+++<++<+";
    bf(src, storage[0..]);
    assert(mem.eql(u8, storage, "\x00\x01\x02\x03\x00"));
}
