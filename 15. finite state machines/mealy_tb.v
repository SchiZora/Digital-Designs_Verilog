`timescale 1ns / 1ps


module mealy_tb;

	reg clk, reset, x;	
	wire y;

	// Instantiate the Unit Under Test (UUT)
	mealy_sequence_detector uut (
		.clk(clk),
		.reset(reset),
		.x(x),
		.y(y)
	);

always #5 clk = ~clk;
	initial begin
	$dumpfile ("mealy_tb.vcd");
	$dumpvars (0, mealy_tb);
	clk = 0;
	x = 0;
	reset = 0; 	#10;
	reset = 1;	#10;
	reset = 0;	#10;
	//sequence here
	x = 1; #10;
    x = 0; #10;
    x = 1; #10;
    x = 1; #10;
	//random value
	x = 1; #10;
    x = 0; #10;
	#100;
	//sequence again here
	x = 1; #10;
    x = 0; #10;
    x = 1; #10;
    x = 1; #10;
	#50;
	$finish;
	end
      
endmodule