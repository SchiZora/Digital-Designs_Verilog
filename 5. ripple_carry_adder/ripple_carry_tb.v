`timescale 1ns / 1ps

//testbench module don't have ports
module ripple_carry_tb;

    reg [3:0] a;
    reg [3:0] b;
    reg cin;
    
    wire [3:0]sum;
    wire cout;
    
    //instantiate for testbench
    ripple_carry uut (
    
    .A(a),
    .B(b),
    .Cin(cin),
    
    .Sum(sum),
    .Cout(cout)
    );
  integer i;  
     // Test stimulus
    initial begin
    for (i = 0; i < 512; i = i + 1) begin
        {a, b, cin} = i;
        #10;
        end 
        $stop;
    end
    
    
endmodule