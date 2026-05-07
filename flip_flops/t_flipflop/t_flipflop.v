`timescale 1ns / 1ps
//toggle t_flipflop
//basic idea:
    //0 > keep previous state
    //1 > toggle output

module t_flipflop(
    input t, clk,
    output reg q,
    output q_inv
    );

    initial begin
        q = 1'b0;
    end
    assign q_inv = ~q;
    always @(posedge clk) begin
        case (t)
        //always use damn <= for sequential circuits, makes the design non-blocking
        1'b0: q <= q;    //hold previous state
        1'b1: q <= ~q;    //toggle
        endcase
    end

endmodule

module t_main (
    input SW0, CLK,
    output [1:0] LED
);
    wire s1;
    assign s1 = ~SW0;

    t_flipflop T1 (
        .t(s1),
        .clk(CLK),

        .q (LED[0]),
        .q_inv(LED[1])
    );

endmodule