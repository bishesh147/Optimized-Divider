module division_top(dividend, divisor, quotient, remainder, clk, reset, start, ready);
    input [63:0] dividend; 
    input [63:0] divisor;
    input clk, reset, start;
    output ready;
    output [63:0] remainder;
    output [63:0] quotient;

    wire [63:0]shifted_rem_q_out;
    wire [63:0]divisor_out;
    wire [63:0]subtractor_out;
    wire [63:0]rem_q_rem_out;
    wire [63:0]rem_q_q_out;
    wire control_wr;
    wire control_initial_wr;
    wire control_sh_left;


    divisor_register dvr1(
        .data_out(divisor_out), 
        .data_in(divisor), 
        .clk(clk), 
        .reset(reset));

    subtractor sub1(
        .diff(subtractor_out), 
        .a(shifted_rem_q_out), 
        .b(divisor_out));

    rem_q_register remq1(
        .clk(clk), 
        .reset(reset), 
        .data_in(subtractor_out), 
        .wr(control_wr), 
        .initial_data_in(dividend),
        .initial_wr(control_initial_wr), 
        .rem_out(rem_q_rem_out),
        .q_out(rem_q_q_out),
        .sh_left(control_sh_left),
        .shifted_rem_q(shifted_rem_q_out));

    control cu1(
        .clk(clk), 
        .reset(reset), 
        .start(start), 
        .data_in(subtractor_out), 
        .ready(ready), 
        .wr(control_wr), 
        .initial_wr(control_initial_wr),
        .sh_left(control_sh_left));
    
    assign quotient = rem_q_q_out;
    assign remainder = rem_q_rem_out;
endmodule

