`timescale 1ns / 1ps

//basically, at rising clock edge q_next <= d;
//no reset needed, but ill make a switch to reset value 

module d_flipflop(
    input d, reset, clk,
    output reg q,
    output q_inv
);
    initial begin
        q <= 1'b0;
    end
    assign q_inv = ~q;
    always @(posedge clk) begin
/*         if (reset)
            q <= 1'b0;
        else */
            q <= d;
        //reset ain't wrrking but due to clock and timing difference, 
        //woked in simulation, can see the timing changes so commented it to 
        //see th real time change in FPGA

        //until i keep pressing the switch, i.e. 
        //SW0 = 1, then LED[0] is on; 
        //SW0 = 0 (not pressed), then LED[0] is off, LED[1] (q_inv) is on;
        //without this the reset switch is always onand it keeps the o/p, i.e. LED[0] = 0
    end
endmodule

module d_main (
    input SW0, SW1, CLK,
    output [1:0] LED
);
    wire s, reset;
    assign s = ~SW0;
    assign reset = ~SW1;

    d_flipflop D1 (
        .d(s),
        .reset(reset),
        .clk(CLK),

        .q(LED[0]),
        .q_inv(LED[1])
    );
endmodule