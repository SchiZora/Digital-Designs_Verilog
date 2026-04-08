`timescale 1ns / 1ps


module ones_complement(
    input [3:0]a, b, 
    output [3:0]diff, 
    output useless_cout
    );
    wire [3:0] sum;
    wire carry_to_add;

    RC_adder RC0 (a, ~b, 1'b0, sum, carry_to_add);
    //rc_adder RC0 (a, b, cin(GND), diff, end_ariund_carry);
    //carry here the value is 0, pin is directly taken from GND i.e. 0.a
    
    RC_adder Rc1 (sum, 4'b0000, carry_to_add, diff, useless_cout);
    //rc_adder RC0 (sum(previous), again direct 0 val (GND), previous carry, final_answer, (garbage value));

    
endmodule
