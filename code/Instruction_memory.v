`timescale 1ns / 1ps

module Instruction_memory(
    input rst,
    input [31:0] address,
    output [31:0] rd
    );

    reg [31:0] mem [0:1023]; // 1KB instruction memory

    initial begin
        $readmemh("test1.mem", mem); // Load instructions from hex file
    end

    assign rd = (rst) ? 32'h00000000: mem[address[31:2]]; 

endmodule
