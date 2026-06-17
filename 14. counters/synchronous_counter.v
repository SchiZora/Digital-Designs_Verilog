`timescale 1ns / 1ps
//in sync cause all fliflop connected to same clock

//4 bit synchronous up counter
module synchronous_counter_up(
    input  clk,
    input  reset, enable,
    output reg [3:0] count
);
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            count <= 4'b0000; //reset the counter
        end
        else if (enable) begin
            count <= count + 1;     //counts from 0 
        end
    end
endmodule

//4bit synchronous down counter
module synchronous_counter_down(
    input clk,
    input reset, enable,
    output reg [3:0] count
);
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            count <= 4'b1111; //resets the counter
        end
        else if (enable) begin
            count <= count - 1;     //counts till 0        
        end
    end  
endmodule

//4bit synchronous directional counter
module synchronous_counter_bi(
    input clk,
    input reset, enable, direction, //direction -1 for up -0 for down 
    output reg [3:0] count
);
    always@(posedge clk or posedge reset) begin
        if(reset) begin
            case (direction)
                1'b1 : count <= 4'b0000;    //resets to lowest
                1'b0 : count <= 4'b1111;    //resets to highest
            default: count <= count;    //holds
            endcase
        end 
        else if (enable) begin
            if (direction) begin
                count <= count + 1;         //up counter
            end
            else
                count <= count - 1;         //down counter
        end 
    end  
endmodule