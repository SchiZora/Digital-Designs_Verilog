`timescale 1ns / 1ps

//declare module 16:1 4bit mux_tb
module inst_16_1_4bit_tb;
    //declare i/p-reg and o/p-wire
    reg [3:0] i0, i1, i2, i3, i4, i5, i6, i7, i8, i9, i10, i11, i12, i13, i14, i15;
    reg [3:0] s;
    wire [3:0] y; 

    //instantiate uut
    inst_16_1_mux_4bit uut(
    //inputs
    .i0(i0), .i1(i1), .i2(i2), .i3(i3), .i4(i4), .i5(i5), .i6(i6), .i7(i7),
    .i8(i8), .i9(i9), .i10(i10), .i11(i11), .i12(i12), .i13(i13), .i14(i14), .i15(i15),
    //select lines (4bit, select lines)
    .s(s),
    .y(y)
    );

    //apply stimulus
    integer i;
    initial begin
        //need to define the inputs. 
        i0 = 4'b0000; i1 = 4'b0001; i2 = 4'b0010; i3 = 4'b0011;
        i4 = 4'b0100; i5 = 4'b0101; i6 = 4'b0110; i7 = 4'b0111;
        i8 = 4'b1000; i9 = 4'b1001; i10 = 4'b1010; i11 = 4'b1011;
        i12 = 4'b1100; i13 = 4'b1101; i14 = 4'b1110; i15 = 4'b1111;
        for (i = 0; i < 16; i = i +1 ) begin
            {s} = i;
            #10; //delay of 10 units
        end 
        $stop;
    end 
    initial begin
        $monitor("s = %d, y = %b", s, y);
    end
endmodule
