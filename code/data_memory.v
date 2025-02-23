`timescale 1ns / 1ps

`define MEM_SB  3'b000  // Store Byte
`define MEM_SH  3'b001  // Store Halfword
`define MEM_SW  3'b010  // Store Word

`define MEM_LB  3'b000  // Load Byte
`define MEM_LH  3'b001  // Load Halfword
`define MEM_LW  3'b010  // Load Word
`define MEM_LBU 3'b100  // Load Byte Unsigned
`define MEM_LHU 3'b101  // Load Halfword Unsigned


module data_memory(
    input clk,
    input rst, 
    input mem_read,
    input mem_write,
    input [31:0] address,
    input [31:0] write_data,
    input [2:0] funct3,
    output reg [31:0] read_data
    );

    // Memory array (1KB memory)    
    reg [7:0] memory [0:1023];
    integer i;
    //sequential logic

    always @(posedge clk or posedge rst) begin
        if (rst) begin
             for (i = 0; i < 1023; i = i + 1) begin
                memory[i] <= 8'b0;
            end 
        end else begin
                if (mem_write) begin
                    case (funct3)
                        `MEM_SB: memory[address] = write_data [7:0]; 
                        `MEM_SW: {memory[address+1],memory[address]} = write_data [15:0];
                        `MEM_SW: {memory[address+3],memory[address+2],memory[address+1],memory[address]} = write_data [31:0];
                        default:; 
                    endcase
                end
        end
    end
    

    //Combinational logic 

    always @(*) begin
        if (mem_read) begin
            case (funct3)
                `MEM_LB:  read_data = {{24{memory[address][7]}}, memory[address]};
                `MEM_LH:  read_data = {{16{memory[address+1][7]}}, memory[address+1], memory[address]};
                `MEM_LW:  read_data = {memory[address+3],memory[address+2],memory[address+1],memory[address]};
                `MEM_LBU: read_data = {24'b0, memory[address]};
                `MEM_LHU: read_data = {16'b0, memory[address+1],memory[address]};
                default:  read_data = 32'b0;
            endcase
        end else begin
            read_data = 32'b0;
        end
    end
endmodule
