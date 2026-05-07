`timescale 1ns / 1ps

module t_ff_tb;

	// Inputs
	reg t;
	reg clk;

	// Outputs
	wire q;
	wire q_inv;

	// Instantiate the Unit Under Test (UUT)
	t_flipflop uut (
		.t(t), 
		.clk(clk), 
		.q(q), 
		.q_inv(q_inv)
	);
    always begin
        #5 clk = ~clk;
        //toggles the clock (for stimulation)
        //0->5 ns zero
        //5->10 ns rising edge
    end
	integer i;
	initial begin
	// Initialize Inputs
	//to get waveform output: (iverilog)
    $dumpfile("t_sim_iverilog.vcd");   // output file name
    $dumpvars(0, t_ff_tb);      		// dump all signals under this module
		t = 0;
		clk = 0;
		for (i = 0; i <= 100; i++ )begin	
			#10;
			t = ~t;
		end

	$finish;
	end
      
endmodule

