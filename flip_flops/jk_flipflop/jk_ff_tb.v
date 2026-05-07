`timescale 1ns / 1ps

//JK, instead of S and R both being 1 and
//Q being INVALID, it toggles Q between 1 and 0 
//at every clock edge, until S R are both 2`b11
//q_inv will also toggle here

module jk_flipflop(
    input clk, j, k,
    output reg q,
    output q_inv
);

initial begin
    q = 1'b0;
end

always @(posedge clk) begin
    case ({j, k})
        2'b00: q <= q;
        2'b01: q <= 0;  //reset
        2'b10: q <= 1;  //set
        2'b11: q <= ~q; //toggle                   
    endcase
end
assign q_inv = ~q;
endmodule


module jk_main (
    input SW0, SW1, CLK,
    output [1:0] LED
);
    wire s1, s2;
    assign s1 = ~SW0;
    assign s2 = ~SW1;

    jk_flipflop JK1(
        .clk (CLK),
        .j (s1),
        .k (s2),

        .q (LED[0]),
        .q_inv (LED[1])
    );
   
endmodule