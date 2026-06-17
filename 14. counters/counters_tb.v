`timescale 1ns / 1ps

//I'll upload the .vcd file its simulation results

module counters_tb;

	//inputs
	reg clk;
	reg reset;
	reg direction;

	//outputs
	wire [3:0] modn_count;

	wire [3:0] modn60_secs;
	wire [3:0] modn60_tens;
	wire [2:0] modn60_hrs;

	wire FDC2_clkout;
	wire FDC4_clkout;
	wire FDC8_clkout;

	wire [3:0] countRC;

	wire [3:0] countJC;

	// Instantiate the Unit Under Test (UUT)
	modn_counter MDN (
		.clk(clk),
		.reset(reset),
		.count(modn_count)
	);
	modn_overflow MDN60(
		.clk(clk),
		.reset(reset),
		.seconds(modn60_secs),
		.tens(modn60_tens),
		.hrs(modn60_hrs)
	);
	frequency_divider_counter FDC(
		.clk(clk),
		.reset(reset),
		.by2_clkout(FDC2_clkout),
		.by4_clkout(FDC4_clkout),
		.by8_clkout(FDC8_clkout)
	);
	ring_counter #(
		.WIDTH(4)
	)RC4(
		.clk(clk),
		.reset(reset),
		.direction(direction),
		.count(countRC)
	);
	johnson_counter #(
		.WIDTH(4)
	)JC4(
		.clk(clk),
		.reset(reset),
		.direction(direction),
		.count(countJC)
	);

	always #5 clk = ~clk;

	initial begin
		$dumpfile ("counters_sim.vcd");
		$dumpvars (0, counters_tb);
		clk = 0;
		direction = 0;	//right shift
		reset = 1;
		#10;
		reset = 0;
		direction = 1;	//left shift
		/*#200;
		reset = 1;
		#10;
		reset = 0;*/
		#100;
		direction = 0;	//right shift
		#100;
		direction = 1;	//left shift
		#100;
		//forcing a value for wire just for simulation....
		force RC4.count = 4'b0110;
		force JC4.count = 4'b0110;
		#100;
		release RC4.count;
		release JC4.count;
		#20;
		#2000;
		$finish;
	end
      
endmodule

