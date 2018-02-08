const warn = @import("std").debug.warn;

fn bf_seek(src: []const u8, srcptr: u16) u16 {
    var depth:u16 = 1;
    var ptr = srcptr + 1;
    while (depth > 0) {
        switch(src[ptr]) {
            '[' => depth += 1,
            ']' => depth -= 1,
            else => undefined
        }
        ptr += 1;
    }
    return ptr;
}

pub fn bf(src: []const u8, storage: []u8) void {
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
                srcptr += bf_seek(src, srcptr);
            } else {
                _ = stack.push(srcptr);
            },
            ']' => if (storage[memptr] != 0) {
                srcptr = stack.peek();
            } else {
                _ = stack.pop();
            },
            else => undefined
        }
        srcptr += 1;
    }
}

