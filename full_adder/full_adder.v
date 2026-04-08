`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/19/2026 02:50:55 PM
// Design Name: 
// Module Name: full_adder
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


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
