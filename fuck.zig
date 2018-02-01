const warn = @import("std").debug.warn;
const Stack = @import("./stack.zig").Stack;

fn bf(src: []const u8) void {
    var mem: [30000]u8 = undefined;
    var i:usize = 15000;

    var stackmem: [20000]u32 = undefined;
    var stackindex: usize = 1000;
    var stack = Stack {
        .data = stackmem,
        .index = stackindex
    };

    var si:  u32 = 0;
    while (si < src.len) {
        switch(src[si]) {
            '+' => (mem[i] = (mem[i] +% 1)),
            '-' => (mem[i] = (mem[i] -% 1)),
            '<' => i -= 1,
            '>' => i += 1,
            '[' => {
                stack.push(6);
            },
            ']' => {
                if (mem[i] == 0) {
                    _ = stack.pop();
                } else {
                    si = stack.peek() + 1;
                    warn("{} ", si);
                }
            },
            '.' => warn("{c}", mem[i]),
            else => undefined
        }
        // warn("{} ", mem[i]);
        // warn("{} ", si);
        si -= 2;
    }
}

fn main() void {
    const hello = "++++++++++[>+++++++>++++++++++>+++>+<<<<-]>++.>+.+++++++..+++.>++.<<+++++++++++++++.>.+++.------.--------.>+.>.";
    // const hello = "+++[-]";
    bf(hello);
}
test "run" {
    main();
}
