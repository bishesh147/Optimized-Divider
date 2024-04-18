module rem_q_register(clk, reset, data_in, wr, initial_data_in, initial_wr, sh_left, rem_out, q_out, shifted_rem_q);
    input [63:0] data_in;
    input [63:0] initial_data_in;
    input clk, reset, wr, initial_wr, sh_left;
    output [63:0]rem_out;
    output [63:0]q_out;
    output [63:0]shifted_rem_q;

    reg [63:0] rem_reg;
    reg [63:0] q_reg;

    always @(posedge clk) begin
        if (reset) begin
            rem_reg <= 64'd0;
            q_reg <= 64'd0;
        end
        else begin
            if (initial_wr == 1) begin
                rem_reg <= 64'd0; 
                q_reg <= initial_data_in;
            end
            else begin
                if (wr == 1) begin
                    rem_reg <= data_in;
                    q_reg <= {q_reg[62:0], 1'b1};
                end        
                else if (sh_left == 1) begin 
                    rem_reg <= shifted_rem_q;
                    q_reg <= {q_reg[62:0], 1'b0};
                end
            end
        end
    end
    assign shifted_rem_q = {rem_reg[62:0], q_reg[63]};
    assign rem_out = rem_reg;
    assign q_out = q_reg;
endmodule

        