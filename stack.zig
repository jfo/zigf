const warn = @import("std").debug.warn;
pub const Stack = struct {
    data: [20000]u32,
    index: usize,

    pub fn push(self: &Stack, x: u32) void {
        self.index += 1;
        self.data[self.index] = x;
        warn("({}", self.data[self.index]);
    }

    pub fn pop(self: &Stack) u32 {
        self.index -= 1;
        return self.data[self.index + 1];
    }

    pub fn peek(self: &Stack) u32 {
        return self.data[self.index];
    }
};

test "run" {
    var stackmem: [20000]u32 = undefined;
    var stackindex: usize = 1000;
    var stack = Stack {
        .data = stackmem,
        .index = stackindex
    };
}
