const std = @import("std");
const io = std.io;
const sub = std.math.sub;

fn seekBack(src: []const u8, srcptr: u16) !u16 {
    var depth:u16 = 1;
    var ptr: u16 = srcptr;
    while (depth > 0) {
        ptr = sub(u16, ptr, 1) catch return error.OutOfBounds;
        switch(src[ptr]) {
            '[' => depth -= 1,
            ']' => depth += 1,
            else => {}
        }
    }
    return ptr;
}

fn seekForward(src: []const u8, srcptr: u16) !u16 {
    var depth:u16 = 1;
    var ptr: u16 = srcptr;
    while (depth > 0) {
        ptr += 1;
        if (ptr >= src.len) return error.OutOfBounds;
        switch(src[ptr]) {
            '[' => depth += 1,
            ']' => depth -= 1,
            else => {}
        }
    }
    return ptr;
}

pub fn bf(src: []const u8, storage: []u8) !void {
    const stdout = &(io.FileOutStream.init(&(io.getStdOut() catch unreachable)).stream);

    var memptr: u16 = 0;
    var srcptr: u16 = 0;
    while (srcptr < src.len) {
        switch(src[srcptr]) {
            '+' => storage[memptr] +%= 1,
            '-' => storage[memptr] -%= 1,
            '>' => memptr += 1,
            '<' => memptr -= 1,
            '[' => if (storage[memptr] == 0) srcptr = try seekForward(src, srcptr),
            ']' => if (storage[memptr] != 0) srcptr = try seekBack(src, srcptr),
            '.' => try stdout.print("{c}", storage[memptr]),
            else => {}
        }
        srcptr += 1;
    }
}

