`timescale 1ns / 1ps


module half_sub_2tb;
    reg a;
    reg b;
    wire diff;
    wire bor;

    half_subtractor uut(
        .a(a),
        .b(b),
        .diff(diff),
        .bor(bor));
integer i;
    initial begin
        for (i = 0; i < 4; i = i +1 )begin
            {a, b} = i;
            #10;
        end
        $finish;
    end 
endmodule
