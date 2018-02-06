const std = @import("std");
const warn = std.debug.warn;
const assert = std.debug.assert;
const mem = std.mem;
const getc = @cImport(@cInclude("stdio.h")).getc;

fn bf(src: []const u8, storage: []u8) void {

    var memptr: u16 = 0;
    var srcptr: u16 = 0;
    while (srcptr < src.len) {
        switch(src[srcptr]) {
            '+' => storage[memptr] +%= 1,
            '-' => storage[memptr] -%= 1,
            '>' => memptr += 1,
            '<' => memptr -= 1,
            '.' => warn("{c}", storage[memptr]),
            '[' => if (storage[memptr] == 0) {
                while (src[srcptr] != ']')
                    srcptr += 1;
            },
            ']' => if (storage[memptr] != 0) {
                while (src[srcptr] != '[')
                    srcptr -= 1;
            },
            else => undefined
        }
        srcptr += 1;
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

test "[] skips execution and exits" {
    var storage = []u8{0} ** 2;
    const src = "+++++>[>+++++<-]";
    bf(src, storage[0..]);
    assert(storage[0] == 5);
    assert(storage[1] == 0);
}

test "[] executes and exits" {
    var storage = []u8{0} ** 2;
    const src = "+++++[>+++++<-]";
    bf(src, storage[0..]);
    assert(storage[0] == 0);
    assert(storage[1] == 25);
}

