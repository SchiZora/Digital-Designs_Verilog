`timescale 1ns / 1ps

module one_comp_tb;

//inputs
reg [3:0]a, b;
wire [3:0]diff;
wire  useless_cout;
//instantiate
ones_complement uut(
    .a(a), .b(b), 
    .diff(diff),
    .useless_cout(useless_cout)
);
//stimulus
integer i , j;
initial begin
    /* a = 4'b1101;
    b = 4'b0011;
    #10; */
    //here this will sbutract 0-15, for all 0-15 no.s each (all are 4 bits)
    for (i = 0; i<16; i = i + 1)begin
        a = i;
        for (j = 0; j<16; j = j + 1)begin
            b = j;
            #10;
        end
    end
    $stop;
end
initial begin
    $monitor("a = %b, b = %b, difference = %b, Sign = %b", a,b,diff,useless_cout);
    $display("Simulation Finished");
end
endmodule
