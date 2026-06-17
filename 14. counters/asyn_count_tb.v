`timescale 1ns / 1ps


module asyn_count_tb;

	reg clk;
	reg reset;
	wire [3:0] count;


	// Instantiate the Unit Under Test (UUT)
	asynchronous_counter uut (
		.clk(clk),
		.reset(reset),
		.count(count)	
	);

	always begin
		clk = ~clk;
		#5;
	end
       

	initial begin

	$dumpfile("asyn_count_tb.vcd");   
    $dumpvars(0, asyn_count_tb);  

		// Initialize Inputs
		clk = 0;
		reset = 1;
		#10;
		reset = 0;


		//see count incrementing
		#200;
		reset = 1;
		#10;
		reset = 0;
		#200;
		$finish;
	end
      
endmodule

