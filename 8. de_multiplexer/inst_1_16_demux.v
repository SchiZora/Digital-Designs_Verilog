`timescale 1ns / 1ps

//here i'll use hierarchical way, 1 1:4 demux then, 4 1:4 demuxes 
module inst_1_16_demux(
    input [3:0]a, [3:0]s,
    output [15:0]y
    );
    //[MSB:LSB]
    //[]variable = declaring width
    //variable[] = accessing variable
    //will use wires to connect for readablity,
    wire [3:0]dm;
    //i tried giving each port as seprate but since i'm using previously defined module
    //it outputted in an array, which has to be taken in as an array.

    //i tried connect to connect seprate ports
    demux_1_4 dmx00 (a, s[1:0], dm); 
    //this outputs 4 ports array, where each will be used as indexed input  
    demux_1_4 dmx01 (dm[0], s[3:2], y[3:0]);
    demux_1_4 dmx02 (dm[1], s[3:2], y[7:4]);
    demux_1_4 dmx03 (dm[2], s[3:2], y[11:8]);
    demux_1_4 dmx04 (dm[3], s[3:2], y[15:12]);

endmodule


module inst_1_16_demux_4bit (
    input  [3:0]a, [3:0]s,
    //this is what i was talking about, 4bit 1:4 module outputs in  each port explicitly
    //therefore will have to wite each port specifically 
    output [3:0] y0, y1,y2, y3, y4, y5, y6, y7,
    y8, y9, y10, y11, y12, y13, y14, y15 //each will be 4 bit
);
    wire  [3:0] dm0, dm1, dm2, dm3;
   
    //first demux
    demux_1_4_4bit dmx00 (a, s[3:2], dm0, dm1, dm2, dm3);
   //rest all
    demux_1_4_4bit dmx01 (dm0, s[1:0], y0, y1, y2, y3);
    demux_1_4_4bit dmx02 (dm1, s[1:0], y4, y5, y6, y7);
    demux_1_4_4bit dmx03 (dm2, s[1:0], y8, y9, y10, y11);
    demux_1_4_4bit dmx04 (dm3, s[1:0], y12, y13, y14, y15); 
    //nice mamacita
endmodule