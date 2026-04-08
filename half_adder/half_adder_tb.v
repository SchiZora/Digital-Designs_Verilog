`timescale 1ns / 1ps

module half_adder_tb;

    //input
    reg a;
    reg b;
    //output
    wire sum;
    wire carry;
    
    //instantiate this design
    half_adder uut(
        .a(a),
        .b(b),
        .sum(sum),
        .carry(carry)
    
    );
    
    //simluation block
    initial begin 
        a = 0; b = 0; #10;
        a = 0; b = 1; #10;
        a = 1; b = 0; #10;
        a = 1; b = 1; #10;
    
    $finish;    //end simulation
   end 
    
    
    
endmodule
