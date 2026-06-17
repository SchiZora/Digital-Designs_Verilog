`timescale 1ns / 1ps

//this encodes multiple line inputs into output
//i_e -> input encoder
//o_e -> output encoder

module encoder_4_to_2(
    input [3:0] i_e,  //4bit(a 4bit_bus) input
    output reg [1:0]  o_e //2bit output
);
    always @(*) begin
        //@(*) -> means all signals are used inside this block. 
        case (i_e)
        //comparing the value of i_e against everyone
             
            4'b0001 : o_e = 2'b00;
            4'b0010 : o_e = 2'b01;
            4'b0100 : o_e = 2'b10;
            4'b1000 : o_e = 2'b11;
            default: o_e = 2'bxx;
            //this default value will show high impedence i.e. X
        endcase
    end

endmodule

module encoder_8_to_3(
    input [7:0] i_e,  //8bit(a 8bit_bus) input
    output reg [2:0] o_e  //3bit output
);
    always @(*) begin
        case (i_e)
            8'b00000001 : o_e = 3'b000;
            8'b00000010 : o_e = 3'b001;
            8'b00000100 : o_e = 3'b010;
            8'b00001000 : o_e = 3'b011;
            8'b00010000 : o_e = 3'b100;
            8'b00100000 : o_e = 3'b101;
            8'b01000000 : o_e = 3'b110;
            8'b10000000 : o_e = 3'b111; 
            default: o_e = 3'bxxx;
        endcase
    end
endmodule

module encoder_16_to_4(
    input [15:0] i_e,  //16bit(a 16bit_bus) input
    output [3:0] o_e  //4bit output
);
    integer i;
    reg [3:0] to_o_e;
    always @(*) begin

        //using something called bit indexing
        //Bit Indexing (accessing a specific bit of a vector).
        //vector is i_e here and the int i will determine which bit from i_e will be selected
        //starting from LSB (rightmost bit), eg if i is 3, i_e = 16'b000000000001000
        //only the specific bit will be selected. and i will be passed as an output to o_e, passed as binary. 
        
        to_o_e = 4'b0000;              // default: handles all-zero input
        for (i = 0; i < 16; i=i+1) begin
            if (i_e[i])
                to_o_e = i; 
        end

        //loop logic: scanning A&A, when a high bit is found, position is given
        // to int i is checked and passed to o_e,

        //multiple bits are 1, later one is passed
    end
    assign o_e = to_o_e; 

    //it fails over 2 issues, multiple inputs or all low input
    //for multiple high bit, we can count the total high bits with the loop iteration
    //and be deafult if there are multiple high bits....encoder_16_to_4
    //this is a strict encoder

endmodule


//16bit
module priority_encoder (
    input [15:0] i_pe,
    output reg [3:0]  o_pe
);
    //think of found here basically as a signal saying we found one high bit now stop
    integer i;
    reg found;
    always @(*) begin
        o_pe = 4'bxxxx;
        found = 0;
        for (i = 16; i >=0; i = i - 1) begin
            if (i_pe[i] && !found) begin
                o_pe = i;
                found = 1;
                //here found locks the output of the loop, 
                //after this no high bit will be considered
                //    ->  7  ->  0  ->
            end
        end
    end

endmodule


//priority 4 to 2 encoder for fpga 
module priority_encoder_4_to_2(
    input [3:0] i_pe,  //4bit(a 4bit_bus) input
    output reg [1:0]  o_pe //2bit output
);
    integer i;
    reg found;
    always @(*) begin
        o_pe = 2'bxx;
        found = 0;
        for (i = 3; i >=0; i = i - 1) begin
            if (i_pe[i] && !found) begin
                o_pe = i;
                found = 1;
                //here found locks the output of the loop, 
                //after this no high bit will be considered
                //    ->  7  ->  0  ->
            end
        end
    end

endmodule
