`timescale 1ns / 1ps

module full_subtractor(
    input a,
    input b,
    input bin,
    
    output diff,
    output bout
    );
    
    wire d1, b1, b2;
    
    assign d1 = a ^ b; 
    assign diff = d1 ^ bin;
    
    assign b1= ~a & b;
    assign b2 = ~d1  & bin;
    
    assign bout = b1 | b2;
    
endmodule