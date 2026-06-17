`timescale 1ns / 1ps

module asynchronous_counter(
    //also called as ripple counter cause the one o/p of a flipflop is used as a clock for the next flipflop
    input  clk,
    input  reset,
    output reg [3:0] count
    );
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            count <= 4'b0000; // Reset count to 0
        end else begin
            count[0] <= ~count[0];  //bit 0 updated, delay > 0
        end
    end
    always @(posedge count[0] or posedge reset) begin
        if (reset) begin
            count <= 4'b0000; // Reset count to 0
        end else begin
            count[1] <= ~count[1];  //bit 1 updated, delay > 1
        end
    end
    always @(posedge count[1] or posedge reset) begin
        if (reset) begin
            count <= 4'b0000; // Reset count to 0
        end else begin
            count[2] <= ~count[2];  //bit 2 updated, delay > 2
        end
    end
    always @(posedge count[2] or posedge reset) begin
        if (reset) begin
            count <= 4'b0000; // Reset count to 0
        end else begin
            count[3] <= ~count[3];  //bit 3 updated, delay > 3
        end
    end
endmodule
