`timescale 1ns / 1ps



module full_adder(
    input a,
    input b,
    input cin,
    output sum,
    output cout
    );
    //initiallvaluies required falues for nect adder
    wire sum1;      //op of XOR
    wire carry1;      //op of first and
    wire carry2;      //op of second and
    
    assign  sum1 = a ^ b;
    assign carry2 = a & b;
    assign carry1 = sum1 & cin;

    assign sum = sum1 ^ cin;
    assign cout  = carry1 | carry2;
    
endmodule
