pub const Stack = struct {
    data: [20000]u32,
    index: usize,

    pub fn push(self: &Stack, x: u32) void {
        self.index += 1;
        self.data[self.index] = x;
    }

    pub fn pop(self: &Stack) u32 {
        self.index -= 1;
        return self.data[self.index + 1];
    }

    pub fn peek(self: &Stack) u32 {
        return self.data[self.index];
    }
};
