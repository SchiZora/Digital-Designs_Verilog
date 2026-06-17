`timescale 1ns / 1ps

//universal shift register can shift in any direction, load data, and hold data.

module usr(
    input clk, reset, enable,
    input [3:0] data_in,
    input shift_left, shift_right, load,
    input serial_in_left, serial_in_right,
    output reg [3:0] data_out
);
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            data_out <= 4'b0000; //resets the data..
        end
        else if (enable) begin
            /*if (shift_left) begin
                data_out <= {data_out[2:0], data_in[0]}; //shifts left serially
            end
            else if (shift_right) begin
                data_out <= {data_in[3], data_out[3:1]}; //shifts right serially
            end
            else if (load) begin
                data_out <= data_in; //loads the data parallely
            end*/

            case ({shift_right, shift_left, load})
                3'b001: data_out <= data_in; // Load
                3'b010: data_out <= {data_out[2:0], serial_in_left}; // Shift left
                3'b100: data_out <= {serial_in_right, data_out[3:1]}; // Shift right
                default: data_out <= data_out; // Hold
            endcase
        end
    end
endmodule
