`timescale 1ns / 1ps

`define ALU_ADD  4'b0000
`define ALU_SUB  4'b0001
`define ALU_XOR  4'b0010
`define ALU_OR   4'b0011
`define ALU_AND  4'b0100
`define ALU_SLL  4'b0101
`define ALU_SRL  4'b0110
`define ALU_SRA  4'b0111
`define ALU_SLT  4'b1000
`define ALU_SLTU 4'b1001

module ALU(
    input [31:0] rs1,
    input [31:0] src2,
    input [3:0] alu_control,
    output reg [31:0] alu_result
    );

    always @(*) begin
        case(alu_control) 
            `ALU_ADD:  alu_result = rs1 + src2;
            `ALU_SUB:  alu_result = rs1 - src2;
            `ALU_XOR:  alu_result = rs1 ^ src2; 
            `ALU_OR:   alu_result = rs1 | src2;
            `ALU_AND:  alu_result = rs1 & src2;
            `ALU_SLL:  alu_result = rs1 << src2;
            `ALU_SRL:  alu_result = rs1 >> src2;
            `ALU_SRA:  alu_result = $signed(rs1) >>> src2;
            `ALU_SLT:  alu_result = ($signed(rs1) < $signed(src2))?1:0;
            `ALU_SLTU: alu_result = (rs1 < src2)?1:0;
            default:   alu_result = 32'b0;
    endcase
    end

endmodule