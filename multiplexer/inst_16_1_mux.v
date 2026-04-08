`timescale 1ns / 1ps
//first, there is a difference between 16:1 mux and a 16 bit mux
//my dumbahh got condfused in them, 
//this is a 16:1 mux, i.e. 16 inputs : 1 outputs, niggeru-chan♡

//altough we specifically use seprate wire here, we'll use array later in demux and index through wires  

module inst_16_1_mux(
    input i0, i1, i2, i3, i4, i5, i6, i7, i8, i9, i10, i11, i12, i13, i14, i15, [3:0]s,
    output y
    );
    wire w0, w1, w2, w3;
    //total 5, 4:1 mux used
    mux_4_1 mux0(i0, i1, i2, i3, s[1], s[0], w0);
    mux_4_1 mux1(i4, i5, i6, i7, s[1], s[0], w1);
    mux_4_1 mux2(i8, i9, i10, i11, s[1], s[0], w2);
    mux_4_1 mux3(i12, i13, i14, i15, s[1], s[0], w3);
    mux_4_1 mux4(w0, w1, w2, w3, s[3], s[2], y);

endmodule


module inst_16_1_mux_4bit (
    input [3:0] i0, i1, i2, i3, i4, i5, i6, i7, i8, i9, i10, i11, i12, i13, i14, i15,
    input [3:0] s,
    output [3:0] y);

    //similarly, 5 4:1, 4bit muxes were used
    wire [3:0] w0, w1, w2, w3;

    mux4_1_4bit mux0(i0[3:0], i1[3:0], i2[3:0], i3[3:0], s[1], s[0], w0);
    mux4_1_4bit mux1(i4[3:0], i5[3:0], i6[3:0], i7[3:0], s[1], s[0], w1);
    mux4_1_4bit mux2(i8[3:0], i9[3:0], i10[3:0], i11[3:0], s[1], s[0], w2);
    mux4_1_4bit mux3(i12[3:0], i13[3:0], i14[3:0], i15[3:0], s[1], s[0], w3);
    mux4_1_4bit mux4(w0, w1, w2, w3, s[3], s[2],y);

    
endmodule