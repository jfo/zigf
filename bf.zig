const warn = @import("std").debug.warn;

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
                var depth:u16 = 1;
                srcptr += 1;
                while (depth > 0) {
                    switch(src[srcptr]) {
                        '[' => depth += 1,
                        ']' => depth -= 1,
                        else => undefined
                    }
                    srcptr += 1;
                }
            },
            ']' => if (storage[memptr] != 0) {
                var depth:u16 = 1;
                srcptr -= 1;
                while (depth > 0) {
                    switch(src[srcptr]) {
                        '[' => depth -= 1,
                        ']' => depth += 1,
                        else => undefined
                    }
                    srcptr -= 1;
                }
            },
            else => undefined
        }
        srcptr += 1;
    }
}

