`timescale 1ns / 1ps


module mux_2_1(
    input a, b, s,
    output y
    );

    wire a1, b1;
    
    /* STRUCTURAL MODELING
    assign a1 = a & ~s;
    assign b1 = b & s;
    assign y = a1 | b1;
    ^^^ THIS IS GREAT, well too much, BUT THIS IS MUCH BETTER: ∨∨∨∨∨∨ */
    
    assign y = (a & ~s) | (b & s);

    /*or maybe this-
    assign y = s ? b : a;   >
    >here,
        ? is the conditional operator, which is an if-else statement. It evaluates the condition s; 
        if s is true (1), it returns b; otherwise, it returns a.
        the synthesis tool automatically uses an multiplexer for this code.*/

endmodule

//for this, vivado will break and use 2:1 AND and OR Gates.
module mux_4_1(
    input a,b,c,d, s1, s2,
    output y
);
    /*
    //STRUCTURAL MODELING
    wire a1, b1, c1, d1;
    assign a1 = a & ~s1 & ~s2;
    assign b1 = b & ~s1 & s2;
    //another way of writing the same thing
    and (c1, c , s1, ~s2);
    and (d1, d, s1, s2);
    assign y = a1|b1|c1|d1;
    //cascaded way of writing, using 1 OR gate instead of 3, 2:1  
    */


    //DATAFLOW MODELING
    assign y = (a & ~s1 & ~s2 | b & ~s1 & s2 | c & s1 & ~s2 | d & s1 & s2);

endmodule

module mux4_1_4bit(
    input [3:0] a, b, c, d,
    input s1, s2,
    output [3:0] y
);
    /*
    {4{expression}}
    = repeat expression 4 times*/
    //avoid confusion niggeru-chan

    //DATAFLOW MODELING
    assign y = (a & {4{~s1 & ~s2}} | b & {4{~s1 & s2}} | c & {4{s1 & ~s2}} | d & {4{s1 & s2}});


endmodule