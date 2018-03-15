const assert = @import("std").debug.assert;
const mem = @import("std").mem;
const bf = @import("./bf.zig").bf;

test "+" {
    var storage = []u8{0};
    const src = "+++";
    try bf(src, storage[0..]);
    assert(storage[0] == 3);
}

test "-" {
    var storage = []u8{0};
    const src = "---";
    try bf(src, storage[0..]);
    assert(storage[0] == 253);
}

test ">" {
    var storage = []u8{0} ** 5;
    const src = ">>>+++";
    try bf(src, storage[0..]);
    assert(storage[3] == 3);
}

test "<" {
    var storage = []u8{0} ** 5;
    const src = ">>>+++<++<+";
    try bf(src, storage[0..]);
    assert(mem.eql(u8, storage, "\x00\x01\x02\x03\x00"));
}

test "[] skips execution and exits" {
    var storage = []u8{0} ** 3;
    const src = "+++++>[>+++++<-]";
    try bf(src, storage[0..]);
    assert(storage[0] == 5);
    assert(storage[1] == 0);
    assert(storage[2] == 0);
}

test "[] executes and exits" {
    var storage = []u8{0} ** 2;
    const src = "+++++[>+++++<-]";
    try bf(src, storage[0..]);
    assert(storage[0] == 0);
    assert(storage[1] == 25);
}

test "[] skips execution with internal braces and exits" {
    var storage = []u8{0} ** 2;
    const src = "++>[>++[-]++<-]";
    try bf(src, storage[0..]);
    assert(storage[0] == 2);
    assert(storage[1] == 0);
}

test "[] executes with internal braces and exits" {
    var storage = []u8{0} ** 2;
    const src = "++[>++[-]++<-]";
    try bf(src, storage[0..]);
    assert(storage[0] == 0);
    assert(storage[1] == 2);
}

test "errors on mismatched brackets missing opening" {
    var storage = []u8{0} ** 2;
    const src = "++>++[-]++<-]";
    if (bf(src, storage[0..])) {
        @panic("expected error.Overflow");
    } else |err| switch (err) {
        error.OutOfBounds => {},
        else => {}
    }
}

test "errors on mismatched brackets missing closing" {
    var storage = []u8{0} ** 2;
    const src = "+-[+>++[-]++<-";
    if (bf(src, storage[0..])) {
        @panic("expected error.OutOfBounds");
    } else |err| switch (err) {
        error.OutOfBounds => {},
        else => {}
    }
}

