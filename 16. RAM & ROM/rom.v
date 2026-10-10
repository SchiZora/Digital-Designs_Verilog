`timescale 1ns / 1ps
//Synchronous ROM (Read only memory, updates on the posedge of a clock)    

module rom #(
    parameter ADDR_WIDTH = 4,                       //4 bits wide (16 locations) 
    parameter DATA_SIZE = 8,                        //8 bits each
    parameter DATA_FILE = "rom_memory_data.hex"    //file containing actual hexadecimal data values 
    //consider this a backup if one in tb dont work...
    )(  input clk,
    input [ADDR_WIDTH-1:0] addr,
    output reg [DATA_SIZE-1:0] data_out
);
    reg [DATA_SIZE-1:0] rom_memory [0:(2**ADDR_WIDTH)-1]; 
    //array: 16 memory instances, where each instance holds 8 bits
    //** = ^, ie: here 2** = 2^4, to get 16 locations
    //this means,
    //addr_width (16 diff locations) * data_size = 128 bits

    initial begin
        if (DATA_FILE != "")
            $readmemh(DATA_FILE, rom_memory);
            //will read values from rom_memory_data.hex file
            //$readmemh is a simulation only construct
            //rom dont look like this ikkk
    end

    always @(posedge clk) begin
        data_out <= rom_memory[addr];   //show whatever memory addr holds
    end
endmodule