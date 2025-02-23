module execute(
    input [31:0] rs1,
    input [31:0] rs2,
    input alu_src,
    input [31:0] imm_out,
    input [3:0] alu_control,
    input [1:0] jump,
    input [31:0] pc,
    input [2:0] funct3,
    input branch,
    output [31:0] alu_result,
    output branch_sel,
    output [31:0] branch_target,
    output [31:0] jump_target
);
    wire [31:0] alu_input2;

    assign alu_input2 = (alu_src)?imm_out:rs2;

    ALU ALU_inst (
        .rs1(rs1),
        .src2(alu_input2),
        .alu_control(alu_control),
        .alu_result(alu_result)
    );

    branch_comp branch_comp_inst(
        .rs1(rs1),
        .rs2(rs2),
        .funct3(funct3),
        .branch(branch),
        .branch_sel(branch_sel)
    );

    assign branch_target = pc+imm_out;
    assign jump_target = (jump == 2'b01)?alu_result:branch_target; // ?JALR = 01 :JAL = 10

endmodule