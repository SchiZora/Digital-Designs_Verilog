`timescale 1ns / 1ps

module sr_flipflop(
        input clk, s, r,
        output reg q,
        output q_invert
    );
    //output is q and its complement/invert is q'

    initial begin
        q = 1'b0;
        //so this starts with clock and is 0
    end
    always @(posedge clk) begin         //posedge = positive edge i.e. rising edge
        case ({s, r})
            2'b00: q <= q;
            2'b01: q <= 0; //reset
            2'b10: q <= 1; //set
            2'b11: q <= q; //hold last value  
                    //1'bx (forbidden state);
        endcase
    end 
    assign q_invert = ~q;
endmodule

module sr_main (
    input SW0, SW1, CLK,
    output [1:0] LED
);

    wire s1, s2;

    assign s1 = ~SW0;
    assign s2 = ~SW1;

    sr_flipflop SR1(
        .clk (CLK),
        .s (s1),
        .r (s2),

        .q (LED[0]),
        .q_invert(LED[1])
    );

    
endmodule