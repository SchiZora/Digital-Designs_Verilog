`timescale 1ns / 1ps
//Moore: outputs depend on current current_state of the machine
//detect sequence 1011

module moore_sequence_detector(
    input clk, reset, x,  //inputs
    output reg y              //outputs
);
//input is comming in serially
reg [2:0] current_state;
reg [2:0] next_state;

//states check
parameter s0 = 3'b000;
parameter s1 = 3'b001;
parameter s2 = 3'b010;
parameter s3 = 3'b011;
parameter s4 = 3'b100;

//current_state reset and memory update
always @(posedge clk or posedge reset) begin
    if (reset) begin
        current_state <= s0;    //default
    end
    else
        current_state <= next_state;
end

//the logic can be rewritten if the sequence to detect is different
always @(*) begin
    case(current_state)
    s0: begin
        if (x) next_state <= s1;    //>1        -move
        else next_state <= s0;      //>0<       -loop
    end
    s1: begin
        if (x) next_state <= s1;    //>1<       -loop
        else next_state <= s2;      //>1>0      -move
    end
    s2: begin
        if (x) next_state <= s3;    //>1>0>1    -move
        else next_state <= s0;      //1>0>0     -back to start
    end
    s3: begin
        if (x) next_state <= s4;    //>1>0>1>1  -move
        else next_state <= s2;      //>1>0>1>0  -back to prev seq.
    end
    s4: begin
        if (x) next_state <= s1;    //back to s1
        else next_state <= s2;       //back to s2    
    end //sequence detected
    default: next_state <= s0; 
    endcase
end

always @(*) begin
    case (current_state)
        s4: y <= 1'b1;
        default: y <= 1'b0;
    endcase
end
endmodule
