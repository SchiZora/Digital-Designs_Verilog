`timescale 1ns / 1ps

//THE SYNC RAM WILL SHOULD AND ONLY UPDATE ON POSEDGE
//THAT'S HOW IT WAS DESIGNED!!!S

module ram_tb;

	//Declaration
		parameter ADDR_SIZE = 16;
		parameter DATA_SIZE = 8;

		reg clk;
		reg w_enable;			//decides if data shoud be written
		reg [3:0] addr;    		//4 bit address
		reg [7:0] data_in;   	//actual data stored	 
		
		wire [7:0] asyn_data_out;
		wire [7:0] syn_data_out;

	// Instantiate the Unit Under Test (UUT)
		ram_asyn #(
			.ADDR_SIZE(ADDR_SIZE),
			.DATA_SIZE(DATA_SIZE)
		)asyn_uut(	.addr(addr),
			.write_enable(w_enable),
			.data_in(data_in),
			.data_out(asyn_data_out)
		);
		ram_syn #(
			.ADDR_SIZE(ADDR_SIZE),
			.DATA_SIZE(DATA_SIZE)
		)syn_uut(	.clk(clk),
			.write_enable(w_enable),
			.addr(addr),
			.data_in(data_in),
			.data_out(syn_data_out)
		);
		
		initial clk = 0;
		always #5 clk = ~clk;

	//--------------------------------------------------------------------------//
	//from here i came to know about many things, one is task: a reusable block
	//of code, similar to a functions, but can have timimng delays unlike fns.
	//these tasks helped me to test both rams simultaneously and also check their differences
		
	task write_memory;
		//this writes to both ram modules together	
		input [3:0] wt_addr;
		input [7:0] wt_data;
		begin
			@(negedge clk);				//this changes input before rising edge
				w_enable = 1'b1;		//write enabled
				addr = wt_addr;			//write at addr
				data_in = wt_data;		//write data
			@(posedge clk);
				//Ram writes now, 
				//sync will update from here on pos edge by design (again, non blocking assignment)
				#5;						//hold up to avoid race condition
				w_enable = 1'b0;		//write disabled now
		end
	endtask
	//task call : write_memory(addr, data)

	task read_memory;
		input [3:0] rd_addr;
		input [7:0] expected;
		begin
			@(negedge clk)
				w_enable = 1'b0;		//dont write, i.e read			
				addr = rd_addr;			//select this address
			@(posedge clk)
				#1;						//hold up to read
				//since synchronous ram reads at pos edge (non-blocking assignment)
				//need a lil delay to read properly,
            	$display("ADDR=%0d | ASYNC=%0d (exp %0d) %s | SYNC=%0d (exp %0d) %s",
                addr,
                asyn_data_out, expected, (asyn_data_out === expected) ? "PASS" : "FAIL",
                syn_data_out,  expected, (syn_data_out  === expected) ? "PASS" : "FAIL"
            );
		end
	endtask
	//task call : read_memory(addr, expected_result)
	
//-------------------------STIMULUS-------------------------//
	integer i = 0;
	initial begin
		$dumpfile("ram_tb.vcd");
		$dumpvars(0, ram_tb);

		//initializing values
		addr = 4'd0;
		data_in = 8'd00;
		w_enable = 1'b0;

		//this repeats for three positive clock
		repeat(3) @(posedge clk);

		$display("\n--- TEST 1: Random Testing ---");

			//Writing random values
			write_memory(4'h0, 8'hAA);	// Write AA to address 0
			write_memory(4'h5, 8'h55); 	// Write 55 to address 5
			write_memory(4'hF, 8'hFF); 	// Write FF to address 15 (max address)
						
			repeat(2) @(posedge clk);

			//Reading and checking those random values
			read_memory(4'h0, 8'hAA);  	// Should PASS
			read_memory(4'h5, 8'h55);  	// Should PASS
			read_memory(4'hF, 8'hCC);  	// Should FAIL

			//check if the memory retains value
			w_enable = 1'b1;
			read_memory(4'hF, 8'hFF);	//check if write enable dosent affect the memory 
			w_enable = 1'b0;
		
		
		repeat(3) @(posedge clk);	//wait
		
		$display("\n--- TEST 2 : Whole testing ---");
		$display("\n--- TEST 2.1: Writing at all locations ---");
		for (i = 0; i < ADDR_SIZE; i = i + 1) begin
			write_memory(i[3:0], i * 10);
		end

		$display("\n--- TEST 2.2 : Reading from all locations ---");
		//%-20s means 20 width space and then string
		$display("%-12s | %-20s | %-20s", "ADDR", "ASYNC RAM", "SYNC RAM");
		//checking all the locations:
		$display("--------------------------------------------------------");
		for (i = 0; i < ADDR_SIZE; i = i + 1) begin
			read_memory(i[3:0], i * 10);
		end

		repeat(2) @(posedge clk);

		$display("\n--- TEST 3 : Random Clock testing ---");

		@(negedge clk);
			w_enable = 1'b0;
			addr = 4'd0;
		#2; 
		addr     = 4'd5; // Move address to 5 mid-cycle
		#0.1;

		$display("\nImmediate test:		-");
		$display("  ASYNC = %0d", asyn_data_out);
		$display("  SYNC  = %0d", syn_data_out);

		//the syn_data_out will still show the past data from test 2.2, because no posedge
		@(posedge clk);	#1;
		$display("\nPost posedge test:	-");
		$display("  ASYNC = %0d", asyn_data_out);
		$display("  SYNC  = %0d", syn_data_out);
		//will update the syn_data_out after posedge
		
		$display("\n");
		#50;
		$finish;
	end
endmodule