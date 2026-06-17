`timescale 1ns / 1ps

module full_sub_1tb;

    reg a, b, bin;
    wire diff, bout;
    
    full_subtractor uut(

        //.reg(port)
        .a(a),
        .b(b),
        .bin(bin),

        .diff(diff),
        .bout(bout)
    );
integer i;   
    initial begin
    for (i = 0; i < 8; i = i + 1)begin
    {a, b, bin} = i;
    #10;
    end
    $stop;
end
endmodule
