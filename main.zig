const warn = @import("std").debug.warn;

pub fn main() void {
    var mem = []u8{0} ** 30000;
    const src = "+++++";

    var memptr: u16 = 0;

    for (src) |c| {
        switch(c) {
            '+' => mem[memptr] += 1,
            '-' => mem[memptr] -= 1,
            else => undefined
        }
    }
}
