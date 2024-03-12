module IF_Stage (
    input clk, rst, freeze, Branch_taken, 
    input [31:0] Branch_Addr,
    output [31:0] PC, Instruction
);
    wire[31:0] next_pc, cur_pc;

    mux_2to1 mux1(.data0(PC),
                  .data1(Branch_Addr),
                  .sel(Branch_taken),
                  .result(next_pc));
    
    pc_register pc_reg1(.clk(clk),
                        .rst(rst),
                        .freeze(freeze),
                        .next_pc(next_pc),
                        .pc(cur_pc));

    pc_addr pc_addr1(.pc(cur_pc),
                     .next_pc(PC));

    IM im1(.address(cur_pc),
           .instruction(Instruction));
endmodule


module mux_2to1 #(parameter WIDTH = 32) (
    input [WIDTH-1:0] data0,
    input [WIDTH-1:0] data1,
    input sel,
    output [WIDTH-1:0] result
);

   assign result = sel ? data1 : data0;

endmodule

module pc_addr (input [31:0] pc,
                output [31:0] next_pc
);

    assign next_pc = pc + 32'h00000004;

endmodule

module pc_register (
    input clk,
    input rst,
    input freeze,
    input [31:0] next_pc,
    output reg [31:0] pc
);

    always @(posedge clk) begin
        if (rst) begin
            pc <= 32'h0;
        end

        else if (!freeze) begin
            pc <= next_pc;
        end
  end

endmodule

module IM (input [31:0] address,
           output reg [31:0] instruction);

    always @(address) begin
        case (address)
            0:   instruction = 32'b000000_00001_00010_00000_00000000000;
            4:   instruction = 32'b000000_00011_00100_00000_00000000000;
            8:   instruction = 32'b000000_00101_00110_00000_00000000000;
            12:  instruction = 32'b000000_00111_01000_00010_00000000000;
            16:  instruction = 32'b000000_01001_01010_00011_00000000000;
            20:  instruction = 32'b000000_01011_01100_00000_00000000000;
            24:  instruction = 32'b000000_01101_01110_00000_00000000000;
            default: instruction = 32'b00000000000000000000000000000000;
        endcase
    end

endmodule

module temp (
    input clk, rst,
    input [31:0] pc_in,
    output reg [31:0] pc
);

    always @(posedge clk) begin

        if (rst) begin
            pc <= 32'b0;
        end

        else
            pc <= pc_in;
    end

endmodule