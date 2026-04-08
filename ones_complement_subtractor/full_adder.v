`timescale 1ns / 1ps
//4 bit full_adder
module full_adder(
    input a, b, cin,
    output sum, cout
    );

    wire sum1, carry1, carry2;
    
    //cin is automatically defined to GND, since won't be taken in as testbench*** 
    assign  sum1 = a ^ b;
    assign carry2 = a & b;
    assign carry1 = sum1 & cin;

    assign sum = sum1 ^ cin;
    assign cout  = carry1 | carry2;

endmodule

module RC_adder(
    input [3:0] a, b,
    input cin,
    output [3:0] sum,
    output cout
);
    wire c1, c2, c3;
    //an instance for each bit, and last bit wil be cout 
    full_adder FA0 (a[0], b[0], cin, sum[0], c1);
    full_adder FA1 (a[1], b[1], c1, sum[1], c2);
    full_adder FA2 (a[2], b[2], c2, sum[2], c3);
    full_adder FA3 (a[3], b[3], c3, sum[3], cout);

endmodule