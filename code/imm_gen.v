`timescale 1ns / 1ps

module imm_gen(
    input [31:0] instruction,
    output reg [31:0] imm_out
    );

    // Signed Extensions:-

    always @(*) begin
        case (instruction [6:0])
            7'b0010011, 7'b0000011, 7'b1100111: imm_out = {{20{instruction[31]}},instruction[31:20]}; // I-instruction
            7'b0100011: imm_out = {{20{instruction[31]}},instruction[31:25],instruction[11:7]}; // S- Instruction
            7'b1100011: imm_out = {{20{instruction[31]}},instruction[7], instruction[30:25],instruction[11:8],1'b0}; // B-Instruction
            7'b0110111, 7'b0010111: imm_out = {instruction[31:12], 12'b0}; // U-Instruction
            7'b1101111: imm_out = {{12{instruction[31]}},instruction[19:12],instruction[20],instruction[30:21],1'b0}; // J-Instruction
            default: imm_out = 32'b0;
        endcase
    end
    
endmodule
