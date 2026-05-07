`timescale 1ns / 1ps

module tb_1_16_4bit;
    //defining the i/o's
    reg [3:0] a;
    reg [3:0] s;
    wire [3:0] y0, y1,y2, y3, y4, y5, y6, y7,
    y8, y9, y10, y11, y12, y13, y14, y15;

    //instantiating
    inst_1_16_demux_4bit uut (
    .a(a),
    .s(s),

    .y0(y0), .y1(y1), .y2(y2), .y3(y3), .y4(y4), .y5(y5), .y6(y6), .y7(y7),
    .y8(y8), .y9(y9), .y10(y10), .y11(y11), .y12(y12), .y13(y13), .y14(y14), .y15(y15)
    );

    //apply stimulus
    integer i, j;
    initial begin 
        for (j = 0; j < 16; j = j + 1 ) begin
            a = j;
            for (i = 0; i < 16; i = i + 1 ) begin
                {s} = i;
                #10; //delay of 10 units
            end
        end
        $stop;
    end
    initial begin 
        $monitor("a (Input) = %d, s (Selection) = %b | y0=%b y1=%b y2=%b y3=%b y4=%b y5=%b y6=%b y7=%b y8=%b y9=%b y10=%b y11=%b y12=%b y13=%b y14=%b y15=%b ", 
        a, s, y0, y1,y2, y3, y4, y5, y6, y7,
        y8, y9, y10, y11, y12, y13, y14, y15);
    end
    endmodule

    //altought this works, real demuxes arent like these, since real demuxes gives out one output rest all output ports are zero,
    //therefore i seaarched and came to know about case statements    