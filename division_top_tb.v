`timescale 1ps/1ps

module division_top_tb;
    reg [63:0] dividend, divisor;
    reg clk, reset, start;
    wire ready;
    wire [63:0]quotient, remainder;
    
    integer i;

    division_top dvt1(dividend, divisor, quotient, remainder, clk, reset, start, ready);

    always #1 clk = ~clk;

    initial begin
        reset = 1; clk = 1; dividend = 64'd0; divisor = 64'd0; start = 0;
        #2;
        reset = 0;
        dividend = 17;
        divisor = 27;
        start = 1;
        #4;
        for (i = 0; i < 100; i = i + 1) begin
            while (ready == 0) begin
                #2; 
            end
            $display("%d. \t time = %d \t dividend = %d \t divisor = %d \t quotient = %d \t remainder = %d", i+1, $time, dividend, divisor, quotient, remainder);
            start = 1;
            dividend = dividend*5;
            divisor = divisor*3;
            #2;
        end 
        #10 $finish;
    end
endmodule