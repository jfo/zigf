const warn = @import("std").debug.warn;
// main.zig
pub fn main() void {
  var mem = []u8{0} ** 30000;
  const src = "+++++";

  for (src) |c| {
      switch(c) {
          '+' => mem[0] += 1
      }
  }
}
