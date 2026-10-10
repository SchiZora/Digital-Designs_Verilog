`timescale 1ns / 1ps

module rom_tb;

	parameter ADDR_WIDTH = 4;
	parameter DATA_SIZE = 8;

	reg clk;
	reg [3:0] addr;    		//4 bit address

	wire [7:0] data_out;

	// Instantiate the Unit Under Test (UUT)
	rom #(
		.ADDR_WIDTH(ADDR_WIDTH),
		.DATA_SIZE(DATA_SIZE),
		.DATA_FILE("rom_memory_data.hex")
	)rom_dut(
		.clk(clk),
		.addr(addr),
		.data_out(data_out)
	);
    
	initial begin
		clk = 0;
		forever begin
			#5 clk = ~clk;	//continous loop
		end 
	end
    integer i;
	initial begin
     	$dumpfile("rom_tb.vcd");
		$dumpvars(0, rom_tb);
        // Initial values
        addr  = 0;
        #10;
        // Read addresses 0 -> 15
        for (i = 0; i < 16; i = i + 1) begin
            addr = i;
            @(posedge clk);
            #1;
            $display(
                "Time = %0t | Address = %0d | Data = 0x%h",
                $time,
                addr,
                data_out
            );
            if (addr == 15) begin
                $display("Reached the end of the ROM address space.");
            end
        end
        #10;
        $finish;
    end
endmodule