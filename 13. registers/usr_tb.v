`timescale 1ns / 1ps

module usr_tb;

	reg clk, reset, enable;
	reg [3:0] data_in;
	reg shift_left, shift_right, load;
	reg serial_in_left, serial_in_right;
	wire [3:0] data_out;

	// Instantiate the Unit Under Test (UUT)
	usr uut (
		.clk(clk),
		.reset(reset),
		.enable(enable),
		.data_in(data_in),
		.shift_left(shift_left),
		.shift_right(shift_right),
		.load(load),
		.serial_in_left(serial_in_left),
		.serial_in_right(serial_in_right),
		.data_out(data_out)
	);
	always #5 clk = ~clk;  
	initial begin
	clk = 0; 

	$dumpfile("usr_reg_sim_vrlg.vcd");   
    $dumpvars(0, usr_tb);  

		// Initialize Inputs
		clk = 0;
		reset = 1;
		enable = 0;
		data_in = 4'b0000;
		shift_left = 0;
		shift_right = 0;
		load = 0;
		serial_in_left = 0;
		serial_in_right = 0;
		#10;

        // 1. load custom data
		reset <= 0;
		enable <= 1;
		data_in <= 4'b1010;
		load <= 1;
		#10;

		// 2. shift left	
		/*reset <= 1;
		#10;
		reset <= 0;*/
		load <= 0;
		shift_left <= 1;
		serial_in_left <= 1;
		#10;
		shift_left <= 0;
		serial_in_left <= 0;
		#10;

		// 3. shift right
		/*reset <= 1;
		#10;
		reset <= 0;*/
		shift_right <= 1;
		serial_in_right <= 1;
		#10;
		shift_right <= 0;
		serial_in_right <= 0;
		#10;

		// 4. hold data
		reset <= 1;
		#10;
		reset <= 0;
		#10;

		load <= 1;
		data_in <= 4'b1111;
		#10;
		load <= 0;
		#10;	

		$finish;		
	end
      
endmodule

