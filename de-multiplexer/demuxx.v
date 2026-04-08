`timescale 1ns / 1ps

module demux_1_2(
    input a, s,
    output y1, y2
    );
    //can write both ways---
    wire a_inv;
    assign y1 = a & s;
    not(a_inv, a);
    and(y2, a_inv, s);
    //using assign is better, it is dataflow modelling....
endmodule

//now, 1:4 demux can be made from gates or 3 1:2_demuxes

module demux_1_4 (
    //this will use gates, 1:16_demux will have 4 1:4_demuxes
    input a, [1:0]s,
    //output y1, y2, y3, y4
    //making an array of wires 
    //along with two select lines
    output [3:0] y
);
    //no need to explicitly write not gate
    assign y[0] = a & ~s[0] & ~s[1];
    assign y[1] = a & ~s[0] & s[1];
    assign y[2] = a & s[0] & ~s[1];
    assign y[3] = a & s[0] & s[1];

endmodule


module demux_1_4_4bit (
    input [3:0] a, [1:0] s,
    /*here we need 4 outputs each 4 bits wide,
    vetor before (left side), bus width, i.e. 4 bits
    vector agfter (right side), output channels, i.e. 4 channel outputs
    /////////////////////////////////////////////////////////////////////////
    ok that was giving an error cause verilog-2001 isnt allowing multi dimensional arrays for ports 
    output [3:0] y [3:0]          <---- this is corrrect, but wont work*/
    output [3:0] y0, y1, y2, y3
);
    assign y0 = a & {4{~s[1] & ~s[0]}};
    assign y1 = a & {4{~s[1] & s[0]}};
    assign y2 = a & {4{s[1] & ~s[0]}};
    assign y3 = a & {4{s[1] & s[0]}};
    
    //4 here is no. of time it has to be done 
    //4 and gates for 4 bit outputs 
endmodule

/*one thing here, since verilog isn't used much, and caused an error due to version (verilog-2001) 
    I'll be using systemverilog for next projects
    it wont change anything as verilog is a subset of systemverilog
    so just all files will be saved as .sv instead of .v 
    and i will move on to systemverilog eventually.*/
//Niggeru-chan♡ 