`timescale 1ns / 1ps

module half_subtractor(
    input a,
    input b,
    output diff,
    output bor
    );
        
    assign diff = a ^ b;
    assign bor = ~a & b;
    
endmodule
