const warn = @import("std").debug.warn;
// main.zig
pub fn main() void {
  const mem = []u8{0} ** 30000;
  const src = "+++++";

  for (src) |c| {
      warn("{}", c);
  }
}
