module IF_Reg(input clk, rst, freeze, flush,
              input [31:0] pc, instruction,
              output reg [31:0] pc_out, instruction_out
);

    always @(posedge clk) begin

        if (rst || flush) begin
            pc_out <= 32'b0;
            instruction_out <= 32'b0;
        end
        
        else if (~freeze) begin
            pc_out <= pc;
            instruction_out <= instruction;
        end

    end

endmodule