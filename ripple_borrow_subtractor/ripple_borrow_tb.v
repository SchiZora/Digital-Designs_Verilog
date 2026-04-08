`timescale 1ns / 1ps

//testbench module don't have ports
module ripple_borrow_tb;

    reg [3:0] a;
    reg [3:0] b;
    reg bin;
    
    wire [3:0]diff;
    wire bout;
    
    //instantiate for testbench
    ripple_borrow uut (
    
    .a(a),
    .b(b),
    .bin(bin),
    
    .diff(diff),
    .bout(bout)
    );
  integer i;  
     // Test stimulus
    initial begin
    for (i = 0; i < 512; i = i + 1) begin
        {a, b, bin} = i;
        #10;
        end 
        $stop;
    end
    
    
endmodule