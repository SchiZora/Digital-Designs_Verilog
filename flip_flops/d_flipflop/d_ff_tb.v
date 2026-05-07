`timescale 1ns / 1ps

module d_ff_tb;

	// Inputs
	reg d;
	reg reset;
	reg clk;

	// Outputs
	wire q;
	wire q_inv;

	// Instantiate the Unit Under Test (UUT)
	d_flipflop uut (
		.d(d), 
		.reset(reset), 
		.clk(clk), 
		.q(q), 
		.q_inv(q_inv)
	);
	always begin
		#5 clk = ~clk;
	end
	integer i,j;
	initial begin
	//to get waveform output: (iverilog)
    $dumpfile("d_sim_iverilog.vcd");   // output file name
    $dumpvars(0, d_ff_tb);      		// dump all signals under this module
	d = 0;
	clk = 0;
	reset = 1; //reset active
	
	#10; //after 10 ns,
	reset = 1'b0; //reset off	
		for (j=0; j<=100;j++)begin
			for (i=0; i<=50; i++)begin
				d = ~d;
				#10;
				reset <= 1'b0;
			end
			reset <= 1'b1;
		end
	$finish;
	end
endmodule