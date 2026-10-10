`timescale 1ns / 1ps
//8bit synchoronous and asynchronous RAM

module ram_asyn #(
    parameter ADDR_SIZE = 16,    //no.of memory locations
    parameter DATA_SIZE = 8    //bits per location
)(  input [3:0] addr,       //4 bit address, i.e. 16 locations
    input write_enable,
    input [DATA_SIZE-1:0] data_in,
    output [DATA_SIZE-1:0] data_out 
);
    reg [DATA_SIZE-1:0] memory [0:ADDR_SIZE-1]; //array: 16 memory instances, where each instance is 8 bit
    //[ADDR_size] name [quantity]
    //write
    always @(*) begin
        if (write_enable)
            memory[addr] = data_in;     //data_out always equals to current memory address      
    end
    //read
    assign data_out = memory[addr];    //w_enable = 1, then write data_in at current memory[addr]
endmodule
    

module ram_syn #(
    parameter ADDR_SIZE = 16,
    parameter DATA_SIZE = 8
)(  input clk, write_enable,
    input [3:0] addr,
    input [DATA_SIZE-1:0] data_in,
    output reg [DATA_SIZE-1:0] data_out
);
    reg [DATA_SIZE-1:0] memory [0:ADDR_SIZE-1];

    always @(posedge clk) begin
        if (write_enable) begin
            data_out <= data_in;        //bypass the data directly when written
            memory[addr] <= data_in;    //write when write_enable is active high
        end else begin
            data_out <= memory[addr];   //read from memory, what was previously stored
        end
    end
endmodule

/*
[0:15] | [15:0] 
both will create an array of 16 instances,
difference is between accessing directions*/