`timescale 1ns / 1ps



module reg_tb;

	// Inputs
	reg clk;
	reg reset;
	reg enable;
	reg [3:0] d;
	reg load;

	// Outputs
	wire [3:0] q_reg;
	wire [3:0] q_left;
	wire [3:0] q_right;
	wire siso_out;
	wire [3:0] sipo_out;
	wire piso_out;
	wire [3:0] pipo_out;



	// Instantiate the Unit Under Test (UUT)
	register uut (
		.clk(clk), 
		.reset(reset), 
		.enable(enable), 
		.d(d), 
		.q(q_reg)
	);

	left_shift_reg uut2 (
		.clk(clk), 
		.reset(reset), 
		.enable(enable), 
		.q(q_left),
		.serial_in(d[0])
	);

	right_shift_reg uut3(
		.clk(clk), 
		.reset(reset), 
		.enable(enable), 
		.q(q_right),
		.serial_in(d[0])
	);

	siso uut4(
		.clk(clk), 
		.reset(reset), 
		.enable(enable), 
		.serial_in(d[0]),
		.serial_out(siso_out)
	);

	sipo uut5(
		.clk(clk), 
		.reset(reset), 
		.enable(enable), 
		.serial_in(d[0]),
		.q(sipo_out)
	);

	piso uut6(
		.clk(clk), 
		.reset(reset), 
		.enable(enable),
		.load(load), 
		.d(d),
		.serial_out(piso_out)
	);

	pipo uut7(
		.clk(clk), 
		.reset(reset), 
		.enable(enable),
		.d(d),
		.q(pipo_out)
	);








	//--------------------------------STIMULUS-------------------------------
	always #5 clk = ~clk;
	integer i;
	initial begin
		// Initialize Inputs
		clk = 0;
		reset = 1;
		enable = 0;
		load = 0;
		d = 0;

	$dumpfile("reg_sim_vrlg.vcd");   
    $dumpvars(0, reg_tb);         
	// Add stimulus here
		for (i = 0; i<=16; i = i + 1) begin
			#10;
			reset = 0;
			d = i;
			enable = 1;
			load = 1;
			if (i == 0) begin
				load = 1; //disable load to test if the reg can retain the value
			end
			else if (i == 1) begin
				load = 0; //enable load again to test if the reg can update the value
			end
			if (i == 10) begin
				reset = 1;
			end
			else if (i == 12) begin
				reset = 0;
				enable = 0; //disable the reg to test if it can retain the value
			#10;
			end
			else if (i == 14) begin
				enable = 1; //enable the reg again to test if it can update the value
			#10;
			end
			
		end


		//custom stimulus 1
		#10;
		reset = 0;
		d = 4'b1010;
		enable = 1;
		load = 1;
		#10;
		load = 0;
		#50;

		//custom stimulus 2
		reset = 1;
		#10;
		reset = 0;
		d = 4'b1100;
		enable = 1;
		load = 1;
		#10;
		load = 0;
		#50;
		


	$finish;
	end
endmodule