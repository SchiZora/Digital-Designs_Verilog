`timescale 1ns / 1ps
//mealy: output depends on current state and input
//detect sequence 1011

module mealy_sequence_detector(
    input clk, reset, x,
    output reg y 
);
//input is comming in serially
reg [1:0] current_state;
reg [1:0] next_state; 

//state check, need one less since the first states also check input
parameter s0 = 2'b00;
parameter s1 = 2'b01;
parameter s2 = 2'b10;
parameter s3 = 2'b11;

//current_state reset and memory update
always @(posedge clk or posedge reset) begin
    if (reset)
        current_state <= s0;
    else
        current_state <= next_state; 
end

always @(*) begin
    y = 0;
    case (current_state)
        s0:begin
            if (x) next_state = s1;
            else next_state = s0;
        end
        s1:begin
            if (x) next_state = s1;
            else next_state = s2;
        end 
        s2:begin
           if (x) next_state = s3;
           else next_state = s0; 
        end
        s3:begin
            if (x) begin
                next_state = s1;
                y = 1'b1;    //output high to alert that sequence is detected
            end
            else next_state = s2;
        end
        default: next_state = s0;
    endcase
end

endmodule
