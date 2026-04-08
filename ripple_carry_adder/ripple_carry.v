`timescale 1 ns/ 1ps

//this <type> [msb:lsb]<> is a vector and will create 4 wire for each.
//that means this is a bus (in bus, op bus)

module ripple_carry(
  input [3:0] A,
  input [3:0] B,
  input Cin,
  output [3:0] Sum,
  output Cout
);

//these are wires for cin
//they will carry the carry to add to the next adder as cin

wire c1, c2, c3;

//FA0 is the instance, first one.
full_adder FA0(A[0], B[0], Cin, Sum[0], c1);
full_adder FA1(A[1], B[1], c1, Sum[1], c2);
full_adder FA2(A[2], B[2], c2, Sum[2], c3);
full_adder FA3(A[3], B[3], c3, Sum[3], Cout);

//(A[0] first input (2 bit),
// B[0] second inout (2 bit),
// Cin carry,
// Sum[0] sum from lsb,
// c1 carry to next adder);


endmodule 