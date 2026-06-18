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
    
    initial begin
    
    a = 0; b = 0; bin = 0; #10;
    a = 0; b = 0; bin = 1; #10;
    a = 0; b = 1; bin = 0; #10;
    a = 0; b = 1; bin = 1; #10;
    a = 1; b = 0; bin = 0; #10;
    a = 1; b = 0; bin = 1; #10;
    a = 1; b = 1; bin = 0; #10;
    a = 1; b = 1; bin = 1; #10;

    $stop;
end
endmodule
