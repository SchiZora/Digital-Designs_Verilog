`timescale 1ns / 1ps


module decoder_tb;

	//inputs
	reg  [15:0] i_d;
	reg en;
	//outputs
	wire [3:0] o_d_2_4;
	wire [7:0] o_d_3_8;
	wire [15:0] o_d_4_16;
	wire [7:0] o_ed_3_8;

	decoder_2_to_4 uut_2_4 (
		.i_d(i_d[1:0]),
		.o_d(o_d_2_4)
	);
	
	decoder_3_to_8 uut_3_8 (
		.i_d(i_d[2:0]),
		.o_d(o_d_3_8)
	);
	
	decoder_4_to_16 uut_4_16 (
		.enable(en),
		.i_d(i_d[3:0]),
		.o_d(o_d_4_16)
	);
	
	en_decoder_3_to_8 uut_3_8_ed (
		.enable(en),
		.i_ed(i_d[2:0]),
		.o_ed(o_ed_3_8)
	);

	integer i;
	//stimulus
	initial begin
	$dumpfile("decoder_sim_ivrlg.vcd");   // output file name
    $dumpvars(0, decoder_tb);
		en = 1'd1;
		i_d = 1'd0;
		for (i = 0; i < 16; i = i+1) begin
			//left shift operator << : shifts bits towards left side
			i_d = i;
			//here the missing bits are automatically written as 0 on left
			//vector name = value << shift by
			#10;
			if (i >= 12)
				en  = 1'd0;
		end
		$finish;
	end          
endmodule