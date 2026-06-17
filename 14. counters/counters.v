`timescale 1ns / 1ps

//modN counter uses N no. of states
//this below is simple decimal 10 state counter
module modn_counter(
    input clk, reset,
    output reg [3:0] count 
);
    //here it should only count till required, all other states should be discarded.
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            count <= 4'b0000;   //reset to 0000
        end
        else if (count == 4'b1010) begin
            count <= 4'b0000; //counts till decimal 10, back to 0000 after reached it.
        end
        else 
            count <= count +1; //basic up counter
    end
endmodule

//this is a basic practice of how a overflow will looks like.....
//taking example of a clock
module modn_overflow(
    input clk, reset,
    output reg [3:0] seconds,   //10 states
    output reg [3:0] tens,      //6 satetes
    output reg [2:0] hrs        //6 states
);
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            seconds <= 3'b000;      //reset all to 0000
            tens <= 3'b000;
            hrs <= 3'b000;
        end
        else if (seconds == 4'd9 && tens == 4'd5) begin
            seconds <= 4'b000;      //STRUCTURE MATTERS: first check hrs
            tens <= 4'b0000;
            hrs <= hrs + 1;
        end
        else if (seconds == 4'd9) begin
            seconds <= 4'b0000;     //second, check and update tens
            tens <= tens + 1;
        end 
        else                        //third update seconds
            seconds <= seconds +1;  //basic up counter   
    end
endmodule

//---------------------------------------------------------------------------------------------------------//

//this divides clock frequency or count, HIGH -> LOW
//this is similar to asynchronous counter however what matters is the output.
module frequency_divider_counter(
    input clk, reset,
    output reg by2_clkout,
    output reg by4_clkout,
    output reg by8_clkout
);  
    //each clock counter needs their own count... 
    //so it depends on that single counter for toggling and dividing the frequency
    reg [3:0] count2;
    reg [3:0] count4;
    reg [3:0] count8;
    always @(posedge clk or posedge reset) begin
        if (reset) begin            //reset all
            count2 <= 4'b0000;
            count4 <= 4'b0000;
            count8 <= 4'b0000;
            by2_clkout <= 1'b0;
            by4_clkout <= 1'b0;
            by8_clkout <= 1'b0;
        end
        else begin
            if (count2 == 1) begin      //2 clock cycles
                by2_clkout = ~by2_clkout;   // toggle
                count2 <= 4'd0;             // reset count
            end
            else    count2 <= count2 + 1;

            if (count4 == 3) begin      //4 clock cycles
                by4_clkout = ~by4_clkout;   //toggle
                count4 <= 4'd0;
            end
            else    count4 <= count4 + 1;
            if (count8 == 7) begin      //8 clock cyles
                by8_clkout = ~by8_clkout;   //toggle
                count8 <= 4'd0;
            end
            else    count8 <= count8 + 1;
            //This below code first two dividers were dependent on a single counter which resets after 
            //16 cycles, which caused them to stretched their own clkout similar to by8_clkout;  
            //my own mistake, and first try....  
            /*if (count == 4'd1)      by2_clkout <= ~by2_clkout;     
            if (count == 4'd3)      by4_clkout <= ~by4_clkout;
            if (count == 4'd7) begin
                by8_clkout <= ~by8_clkout;
                count <= 4'd0;      //resets the counter
            end
            else begin
            count <= count + 1;   //count
            end*/
        end
    end    
endmodule

//---------------------------------------------------------------------------------------------------------//

//like a shift register where only one bit is high
//basically, 0010 > 0100 
module ring_counter#(
//this time instead of explicitly describing output for 4 bits,
//i'll use parameters, which are constant that akes module reusable //describing
    parameter WIDTH = 4    //4 bit width -> is a name not keyword   //declaration
)(  input clk, reset, direction,
    output reg [WIDTH-1:0] count    //width minus one, 4-1=3,= reg [3:0] count
);
    wire valid = (count !=0 && (count & (count -1)) == 0);     //this makes sure the the sate is one hot or not all zero
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            count <= {{(WIDTH-1){1'b0}},1'b1}; //width-1=4-1=3, {{3 times 1'b0}<concatenates> 1'b1}
        end 
        else if (!valid) begin
            count <= {{(WIDTH-1){1'b0}},1'b1};  //same as above, resets it back to op value
        end
        else if (direction) begin   //1 is left || 0 is right
            count <= {count[WIDTH-2:0],count[WIDTH-1]}; // count[2:0]<concatenates>count[3]       
            end
        else begin
            count <= {count[0],count[WIDTH-1:1]}; //count[3]<concatenates>count[2:0]
        end
    end
endmodule

//---------------------------------------------------------------------------------------------------------//

//this is same ring counter basically inverts the shifting bit.
//more sates than ring (2N) and multiple high bits allowed
module johnson_counter#(
    parameter WIDTH = 4)
(   input clk, reset, direction,
    output reg [WIDTH-1:0] count
    );
    always @(posedge clk or posedge reset) begin
    if (reset) begin
            count <= {{(WIDTH-1){1'b0}},1'b1}; //width-1=4-1=3, {{3 times 1'b0}<concatenates> 1'b1}
        end 
        else if (direction) begin   //1 is left || 0 is right
            count <= {count[WIDTH-2:0],~count[WIDTH-1]}; // new MSB = NOT old_LSB << shift left
            end
        else begin
            count <= {~count[0],count[WIDTH-1:1]}; //   new LSB = NOT old_MSB >> shift right
        end
    end

endmodule