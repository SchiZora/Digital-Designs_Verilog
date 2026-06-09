`timescale 1ns / 1ps



module encoder_tb;

	//inputs
	reg [15:0] i_e;
	//outputs
	wire [1:0] o_e_4_2;
	wire [2:0] o_e_8_3;
	wire [3:0] o_e_16_4;
	wire [3:0] o_pe;

	//.<module ports>(<tb ports>)
	//Instantiate the designs (UUT)
	encoder_4_to_2 uut_4_2 (
		.i_e(i_e [3:0]),
		.o_e(o_e_4_2)
	);
	
	encoder_8_to_3 uut_8_3 (
		.i_e(i_e [7:0]),
		.o_e(o_e_8_3)	
	);
	
	encoder_16_to_4 uut_16_4 (
		.i_e(i_e [15:0]),
		.o_e(o_e_16_4)
	);

	priority_encoder uut_pe (
		.i_pe(i_e [15:0]),
		.o_pe(o_pe)
	);

	integer i;
	//stimulus
	initial begin
	$dumpfile("encoder_sim_ivrlg.vcd");   // output file name
    $dumpvars(0, encoder_tb);

		for (i = 0; i < 16; i = i+1) begin
			//left shift operator << : shifts bits towards left side
			i_e = 16'b1 << i;
			//here the missing bits are automatically written as 0 on left
			//vector name = value << shift by
			#10;
		end
		$finish;
	end      
endmodule

