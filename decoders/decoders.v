`timescale 1ns / 1ps

//this decodes comming in inputs into multiple output
//i_d -> input decoder
//o_d -> output decoder

module decoder_2_to_4(
    input [1:0] i_d,    //2bit input bus
    output reg [3:0] o_d    //4bit output bus
);
    always @(*) begin
        case (i_d)
            2'b00 : o_d = 4'b0001;
            2'b01 : o_d = 4'b0010;
            2'b10 : o_d = 4'b0100;
            2'b11 : o_d = 4'b1000; 
            default: o_d = 4'bxxxx;
        endcase
    end

endmodule

module decoder_3_to_8(
    input [2:0] i_d,
    output reg [7:0] o_d
);   
    always @(*) begin
        /*case (i_d)
            3'b000 : o_d = 8'b00000000
            default: 
        endcase*/
        //instead use shift operator to shift the output bit into position
        //selected by input
        o_d = 8'b00000001 << i_d;
        //here whatever input will be, this will take it as a value and shift  
        //towards left by that value.... 
    end

endmodule

//enable: this acts as a selector for selecting one output
//using this ignores all outputs (enable = 0: no output selected)
//can be created by if-else

module decoder_4_to_16(
    input enable,
    input [3:0] i_d,
    output reg [15:0] o_d
);
    always @(*) begin
        if (!enable)
            o_d = 16'b0000000000000000;
            //this keeps all the value smoll
        else begin
            o_d = 16'b1 << i_d;
        end 
    end

endmodule


module en_decoder_3_to_8(
    input enable, 
    input [2:0] i_ed,
    output reg [7:0] o_ed
);
    always @(*) begin
        if (!enable)
            o_ed = 8'b00000000; 
        else begin
            o_ed = 8'b1 << i_ed;
        end
    end

endmodule
