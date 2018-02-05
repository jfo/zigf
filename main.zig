fn bf(src: []const u8, mem: [30000]u8) void {
    var memptr: u16 = 0;
    for (src) |c| {
        switch(c) {
            '+' => mem[memptr] += 1,
            '-' => mem[memptr] -= 1,
            '>' => memptr += 1,
            '<' => memptr -= 1,
            else => undefined
        }
    }
}

pub fn main() void {
    var mem = []u8{0} ** 30000;
    const src = "+++++";
    bf(src, mem);
}
