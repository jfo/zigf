const warn = @import("std").debug.warn;

error StackOverflow;
error StackUnderflow;
pub fn Stack(comptime T:type) type {
    return struct {
        data: []T,
        index: usize,

        fn push(self: &Stack(T), x: T) %void {
            if (self.index >= self.data.len) return error.StackOverflow;
            self.index += 1;
            self.data[self.index] = x;
        }

        fn pop(self: &Stack(T)) %T {
            if (self.index <= 0 ) return error.StackUnderflow;
            self.index -= 1;
            return self.data[self.index + 1];
        }

        fn peek(self: &Stack(T)) T {
            return self.data[self.index];
        }
    };
}

// test "run" {
//     var stackmem: [20000]u32 = undefined;
//     var stackindex: usize = 0;
//     var stack = Stack(u32) {
//         .data = stackmem[0..5],
//         .index = stackindex
//     };
//     warn("{}\n",stack.push(39));
//     warn("{}\n",stack.push(40));
//     warn("{}\n",stack.push(41));
//     warn("{}\n",stack.push(42));
//     warn("{}\n",stack.pop());
//     warn("{}\n",stack.pop());
//     warn("{}\n",stack.pop());
//     warn("{}\n",stack.pop());
//     warn("{}\n",stack.pop());
// }
