`timescale 1ns / 1ps

// a register is a collection of flip-flops that can store multiple bits of data simply.
//a 4bit register, using 4 flipflop to store 4 bits of data. 
//The input d is a 4-bit vector, and the output q is also a 4-bit vector.


module register(
    input clk, reset, enable,
    input [3:0] d,
    output reg [3:0] q
    );

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q <= 4'b0000;
        end
        else if (enable) begin
            q <= d; 
        end
    end
endmodule

//This is basically a big connection of 4 d flipflops. 


module left_shift_reg(
    input clk, reset, enable,
    output reg [3:0] q,
    input serial_in
);
    always @(posedge clk or posedge reset) begin
       
        if (reset) begin
            q <= 4'd0000;
        end
        else if (enable) begin  //Concatenation
           q <= {q[2:0], serial_in }; //shift left and input serial_in to the rightmost bit.
        end
    end

endmodule

module right_shift_reg(
    input clk, reset, enable,
    output reg [3:0] q,
    input serial_in
);
    always @(posedge clk or posedge reset) begin
       if (reset) begin
            q <= 4'd0000;
        end
        else if (enable) begin  //Concatenation
           q <= {serial_in, q[3:1] }; //shift right and input serial_in to the leftmost bit.
        end
    end

endmodule






//serial in serial out
module siso(
    input clk, reset, enable,
    input serial_in,
    output reg serial_out
);
    reg [3:0]q;
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q <= 4'b0000;
        end
        else if (enable) begin
            q <= {q[2:0], serial_in}; //shifts towards left and replace rightmost to serial_in
        end
        serial_out <= q[3]; //sends out whatever bit is at  q[3] at that clock cycle.
    end
endmodule





//serial in parallel out
module sipo(
    input clk, reset, enable,
    input serial_in,
    output reg [3:0] q
);
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q <= 4'b0000;
        end
        else if (enable) begin
            q <= {q[2:0], serial_in}; //shifts towards left and replace rightmost to serial_in
        end     //this gives the whole 4bits at the same time. 
    end
endmodule





//parallel in serial out
module piso(
    input clk, reset, enable, load,
    input [3:0] d,
    output reg serial_out
);
    reg [3:0] q;
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q <= 4'b0000;
        end 
        else if (enable) begin
            if (load) begin
                q <= d;     //loads whole 4bits into q to trnasfer to serial_out one by one.
            end
            else begin
                q <= {q[2:0], 1'b0};
            end
        end
        serial_out <= q[3]; //sends out whatever bit is at  q[3] at that clock cycle.
    end
endmodule





//parallel in parallel out
module pipo(
    input clk, reset, enable,
    input [3:0] d,
    output reg [3:0] q
);
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q <= 4'b0000;
        end
        else if (enable) begin
            q <= d; 
        end
    end //this is basically the same simple register module.
endmodule