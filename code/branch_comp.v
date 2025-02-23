`timescale 1ns / 1ps

`define BRANCH_BEQ  3'b000
`define BRANCH_BNE  3'b001
`define BRANCH_BLT  3'b100
`define BRANCH_BGE  3'b101
`define BRANCH_BLTU 3'b110
`define BRANCH_BGEU 3'b111

module branch_comp(
    input [31:0] rs1,
    input [31:0] rs2,
    input [2:0] funct3,
    input branch,
    output reg branch_sel
    );

    always @(*) begin
        if (branch) begin
            case (funct3) 
                `BRANCH_BEQ:  branch_sel = (rs1 == rs2); 
                `BRANCH_BNE:  branch_sel = (rs1 != rs2); 
                `BRANCH_BLT:  branch_sel = ($signed(rs1) < $signed(rs2)); 
                `BRANCH_BGE:  branch_sel = ($signed(rs1) >= $signed(rs2)); 
                `BRANCH_BLTU: branch_sel = (rs1 < rs2); 
                `BRANCH_BGEU: branch_sel = (rs1 >= rs2);
                default: branch_sel = 0;
            endcase
        end else begin
            branch_sel = 0;
        end
    end
endmodule
