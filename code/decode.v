module decode (
    input clk,
    input rst,
    input [31:0] instruction,
    input [4:0] read_reg1,
    input [4:0] read_reg2,
    input [4:0] write_reg,
    input [31:0] write_data,
    input reg_write_i,
    output [31:0] read_data1,
    output [31:0] read_data2,
    output [31:0] imm_out,
    output [3:0] alu_control,
    output branch, mem_read, mem_to_reg, mem_write, alu_src, reg_write_o,
    output [1:0] jump
);
    wire [1:0] alu_op_wire;

    opcode_decoder opcode_decoder_inst(
        .opcode(instruction[6:0]),
        .branch(branch),
        .mem_read(mem_read),
        .mem_to_reg(mem_to_reg),
        .mem_write(mem_write),
        .alu_src(alu_src),
        .reg_write(reg_write_o),
        .jump(jump),
        .alu_op(alu_op_wire)
    );

    alu_decoder alu_decoder_inst (
        .alu_op(alu_op_wire),
        .funct3(instruction[14:12]),
        .funct7(instruction[31:25]),
        .opcode(instruction[6:0]),
        .alu_control(alu_control)
    );

    imm_gen imm_gen_inst (
        .instruction(instruction),
        .imm_out(imm_out)
    );

    register register_inst(
        .clk(clk),
        .rst(rst),
        .reg_write(reg_write_i),
        .read_reg1(read_reg1),
        .read_reg2(read_reg2),
        .write_reg(write_reg),
        .write_data(write_data),
        .read_data1(read_data1),
        .read_data2(read_data2)
    ); 

endmodule