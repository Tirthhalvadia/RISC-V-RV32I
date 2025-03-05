module alu_decoder (
    input [1:0] alu_op,
    input [6:0] funct7,
    input [2:0] funct3,
    input [6:0] opcode,
    output reg [3:0] alu_control
);

always @(*) begin
    case(alu_op)
        2'b00: alu_control = 4'b0000; // add for load and store instructions
        2'b01: alu_control = 4'b0001; // subtract for branch instructions
        2'b11: alu_control = (opcode == 7'b0110111)?4'b1010:4'b1011; // ?LUI:AUIPC
        2'b10: begin
            case(funct3)
                3'b000: alu_control = (funct7[5])?4'b0001:4'b0000; // ?SUB-1:ADD-0
                3'b100: alu_control = 4'b0010; // XOR-2
                3'b110: alu_control = 4'b0011; // OR-3
                3'b111: alu_control = 4'b0100; // AND-4
                3'b001: alu_control = 4'b0101; // SLL-5
                3'b101: alu_control = (funct7[5])?4'b0111:4'b0110; // ?SRA-7:SRL-6
                3'b010: alu_control = 4'b1000; // SLT-8
                3'b011: alu_control = 4'b1001; // SLTU-9

                default: alu_control = 4'b0000; 
            endcase
        end
        default: alu_control = 4'b0000;
    endcase
end
endmodule