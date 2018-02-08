const warn = @import("std").debug.warn;
const Stack = @import("./Stack.zig").Stack;
const assert = @import("std").debug.assert;

fn bfseek(src: []const u8, si: u32) u32 {
    var depth:u16 = 1;
    var sii:u32 = si + 1;

    while (depth > 0) {
        switch(src[sii]) {
            '[' => depth += 1,
            ']' => depth -= 1,
            else => undefined
        }
        sii += 1;
    }
    return sii - 1;
}

pub fn bf(src: []const u8, mem: []u8) %void {
    var i:u32 = 0;

    var stackmem: [10]u32 = undefined;
    var stackindex: usize = 0;

    var stack = Stack(u32) {
        .data = stackmem[0..],
        .index = stackindex
    };

    var si:  u32 = 0;
    while (si < src.len) {
        switch(src[si]) {
            '+' => mem[i] +%= 1,
            '-' => mem[i] -%= 1,
            '>' => i += 1,
            '<' => i -= 1,
            '[' => if (mem[i] == 0) {
                    si = bfseek(src, si);
                } else {
                    _ = stack.push(si);
                },
            ']' => {
                if (mem[i] == 0) {
                    _ = stack.pop();
                } else {
                    si = stack.peek();
                }
            },
            '.' => warn("{c}", u8(mem[i])),
            else => undefined
        }
        si += 1;
    }
}

test "basics" {
    var mem = []u8{0} ** 10;
    _ = bf("+++", mem[0..]);
    assert(mem[0] == 3);

    _ = bf("++---", mem[0..]);
    assert(mem[0] == 2);

    _ = bf(">>>+++++", mem[0..]);
    assert(mem[3] == 5);

    _ = bf(">>><<+", mem[0..]);
    assert(mem[1] == 1);
}

test "djfio" {
    var mem = []u8{0} ** 1;
    _ = bf("[++++++++++++]++", mem[0..]);
    assert(mem[0] == 2);
}

test "djfi" {
    var mem = []u8{0} ** 1;
    _ = bf("[++++[++++]++++]++", mem[0..]);
    assert(mem[0] == 2);
}

test "djif" {
    var mem = []u8{0} ** 1;
    _ = bf("+++++++++++[-]+", mem[0..]);
    assert(mem[0] == 1);
}

test "dfji" {
    var mem = []u8{0} ** 2;
    _ = bf("+++++[>+++++<-]", mem[0..]);
    assert(mem[1] == 25);
}
