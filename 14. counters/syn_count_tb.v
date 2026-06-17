`timescale 1ns / 1ps


module syn_count_tb;

	reg clk;
	reg reset;
	reg enable;
	reg direction;
	wire [3:0] count_up;
	wire [3:0] count_down;
	wire [3:0] count_bi;

	// Instantiate the Unit Under Test (UUT)

	synchronous_counter_up SYNCUP (
		.clk(clk), 
		.reset(reset), 
		.enable(enable), 
		.count(count_up)
	);
	synchronous_counter_down SYNCDWN(
		.clk(clk), 
		.reset(reset), 
		.enable(enable), 
		.count(count_down)
	);
	synchronous_counter_bi SYNCBI(
		.clk(clk), 
		.reset(reset), 
		.enable(enable),
		.direction(direction), 
		.count(count_bi)
	);


	always #5 clk = ~clk;

	initial begin
	
	$dumpfile ("syn_count_tb.vcd");
	$dumpvars (0, syn_count_tb);
	
		// Initialize Inputs
		clk = 0;
		reset = 1;
		enable = 0;
		direction = 0;
		#10;
		reset = 0;
		enable = 1;
		direction = 1;
		#120;
		direction = 0;
		#120;
		enable = 0;
		#13;
		enable = 1;
		#17;
		enable = 0;
		#10;
		enable = 1;
		direction = 1;
		#200;/*
		reset = 1;
		reset = 0;*/
		$finish;
	end
      
endmodule

