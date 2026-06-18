//Declaring timescale
`timescale 1ns / 1ps

//Declaring Module
module full_adder_tb;

//Declaring inputs and outputs
    reg a;
    reg b;
    reg cin;

    wire sum;
    wire cout;

//Instantiating
    full_adder uut(

        //.reg(port)
        .a(a),
        .b(b),
        .cin(cin),

        .sum(sum),
        .cout(cout)
    );

//applying stimulus (simulation using initial block)
initial begin
        a = 0; b = 0; cin = 0; #10;
    a = 0; b = 0; cin = 1; #10;
    a = 0; b = 1; cin = 0; #10;
    a = 0; b = 1; cin = 1; #10;
    a = 1; b = 0; cin = 0; #10;
    a = 1; b = 0; cin = 1; #10;
    a = 1; b = 1; cin = 0; #10;
    a = 1; b = 1; cin = 1; #10;

    $stop;
end

endmodule