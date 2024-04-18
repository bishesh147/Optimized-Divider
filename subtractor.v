module subtractor(diff, a, b);
    input [63:0]a;
    input [63:0]b;
    output [63:0]diff;
    assign diff = a-b;
endmodule
