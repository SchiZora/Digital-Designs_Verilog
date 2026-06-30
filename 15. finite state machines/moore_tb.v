`timescale 1ns / 1ps


module moore_tb;

	reg clk, reset, inp;
	wire outp;

	// Instantiate the Unit Under Test (UUT)
	moore_sequence_detector uut (
		.clk(clk),
		.reset(reset),
		.x(inp),
		.y(outp)
	);

	always #5 clk = ~clk;
	initial begin
	$dumpfile ("moore_tb.vcd");
	$dumpvars (0, moore_tb);
	clk = 0;
	inp = 0;
	reset = 0; 	#10;
	reset = 1;	#10;
	reset = 0;	#10;
	//sequence here
	inp = 1; #10;
    inp = 0; #10;
    inp = 1; #10;
    inp = 1; #10;
	//random value
	inp = 1; #10;
    inp = 0; #10;
	#100;
	//sequence again here
	inp = 1; #10;
    inp = 0; #10;
    inp = 1; #10;
    inp = 1; #10;
	#50;
	$finish;
	end
      
endmodule

