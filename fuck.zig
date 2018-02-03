const warn = @import("std").debug.warn;
const Stack = @import("./Stack.zig").Stack;

fn bf(src: []const u8) void {
    var mem: [30000]u16 = undefined;
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
            '+' => (mem[i] = (mem[i] + 1)),
            '-' => if (mem[i] > 0) { (mem[i] = (mem[i] - 1)); },
            '<' => i -= 1,
            '>' => i += 1,
            '[' => {
                stack.push(si);
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
        // for (mem[15010..15080]) |x| {
        //     if (x == 0) {
        //         warn(". ");
        //     } else {
        //         warn("{} ", x);
        //     }
        // }
        // warn("\n");
        si += 1;
    }
}

fn main() void {
    const hello = "++++++++++[>+++++++>++++++++++>+++>+<<<<-]>++.>+.+++++++..+++.>++.<<+++++++++++++++.>.+++.------.--------.>+.>.";
    const fizzbuzz = " >>>>>>>>>>>>>>>>>>>>>>><<+>+>+++>>>+++++>>>+>++++++++++>++++++++++>++++++++++>++++++++++++++++++++++++++++++++++++++++++++++++>++++++++++++++++++++++++++++++++++++++++++++++++>++++++++++++++++++++++++++++++++++++++++++++++++>>>>>>>>>>>>>>>>>+++++++[<<<<<++++++++++>>>>>-]+++++++++++[<<<<++++++++++>>>>-]<<<<----->>>>+++++++[<<<++++++++++>>>-]<<<---->>>++++++++++++[<<++++++++++>>-]<<--->>++++++++++++[<++++++++++>-]<++<<<<<<<<<<<<<<<<<<<<<<[>>><<[>><[><<<<<<<<<>[-]+>[-]<<[>>>>>>>>><<<<<<>[-]>[-]<<[>+>+<<-]>[<+>-]>[>>>>.>.>.>.<<<<<<<[-]]>>>><<<<<<<<<>-<[>>+<<-]]>>[<<+>>-]<[>>>>>>>>.>>>>>>>>>>>>>>>.>.>>>..<<<<<<<<<<<<<<<<<<<<<<<<<>[-]>[-]<<[>+>+<<-]>[<+>-]+>[<->[-]]<[>>>>>>>>>>>>>>>>>>>>>>.>.>..<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<[-]>>>>>>>>>>><<<<<-]>>>>><<<<<<<<<+++<++++++++++[-]+>>>>>>>>>><<<<<<<<-]>>>>>>>><<<<<<>[-]+>[-]<<[>-<[>>+<<-]]>>[<<+>>-]<[<+++++>>>>>><<<<<<<<<<[<[>>>>>>>>>>>.>>>>>>>>>>>>>>>>>.>.>..<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<-]+>-]+>>>>>>>>>><<<<<-]>>>>>>>>+<<<<<<<<<<<<->>>>>>>>><<<<<<->>>>>><-]++++++++++>>>>----------<+<<<<-]++++++++++>>>>----------<+<<<<-]>>>.>>>>>>>>>>>>>>>>>.>.>..<<<<<<<<<<<<<<<<<<<<<";

    bf(fizzbuzz);
}

test "run" {
    main();
}
