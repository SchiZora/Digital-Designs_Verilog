//Declaring timescale
`timescale 1ns / 1ps

//Declaring Module
module full_adder_2nd_tb;

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

 integer i;
//applying stimulus (simulation using initial block)
initial begin
for (i = 0; i <8; i = i + 1) begin
        {a, b, cin} = i;
        #10;
    end
    $stop;
end

endmodule