`timescale 1ns / 1ps

module Instruction_memory
#(
    parameter MEMFILE = "test1.mem"  
)
(
    input rst,
    input [31:0] address,
    output [31:0] rd
    );

    reg [31:0] mem [0:1023]; // 1KB instruction memory

    initial begin
        $readmemh(MEMFILE, mem); // Load instructions from hex file
    end

    assign rd = (rst) ? 32'h00000000: mem[address[31:2]]; 

endmodule
