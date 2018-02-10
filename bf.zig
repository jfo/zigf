const warn = @import("std").debug.warn;

fn seekBack(src: []const u8, srcptr: u16) u16 {
    var depth:u16 = 1;
    var ptr: u16 = srcptr - 1;
    while (depth > 0) {
        ptr -= 1;
        switch(src[ptr]) {
            '[' => depth -= 1,
            ']' => depth += 1,
            else => undefined
        }
    }
    return ptr;
}

fn seekForward(src: []const u8, srcptr: u16) u16 {
    var depth:u16 = 1;
    var ptr: u16 = srcptr + 1;
    while (depth > 0) {
        ptr += 1;
        switch(src[ptr]) {
            '[' => depth += 1,
            ']' => depth -= 1,
            else => undefined
        }
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
            '[' => if (storage[memptr] == 0) srcptr = seekForward(src, srcptr),
            ']' => if (storage[memptr] != 0) srcptr = seekBack(src, srcptr),
            '.' => warn("{c}", storage[memptr]),
            else => undefined
        }
        srcptr += 1;
    }
}

