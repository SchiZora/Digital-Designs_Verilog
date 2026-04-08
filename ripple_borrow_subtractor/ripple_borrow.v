`timescale 1 ns/ 1ps

//this <type> [msb:lsb]<> is a vector and will create 4 wire for each.
//that means this is a bus (in bus, op bus)

module ripple_borrow(
  input [3:0] a,
  input [3:0] b,
  input bin,
  output [3:0] diff,
  output bout
);

//these are wires for cin
//they will carry the carry to add to the next adder as cin

wire b1, b2, b3;

//FS0 is the instance, first one.
full_subtractor FS0(a[0], b[0], bin, diff[0], b1);
full_subtractor FS1(a[1], b[1], b1, diff[1], b2);
full_subtractor FS2(a[2], b[2], b2, diff[2], b3);
full_subtractor FS3(a[3], b[3], b3, diff[3], bout);

endmodule 