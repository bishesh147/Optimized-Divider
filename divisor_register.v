module divisor_register(data_out, data_in, clk, reset);
    input [63:0]data_in;
    input clk, reset;
    output [63:0]data_out;
    reg [63:0]div_reg;
    always @(posedge clk) begin //Register process block
        if (reset) div_reg <= 64'd0;
        else div_reg <= data_in;
    end
    assign data_out = div_reg;
endmodule
