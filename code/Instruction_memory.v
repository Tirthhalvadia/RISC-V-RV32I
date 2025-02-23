`timescale 1ns / 1ps

module Instruction_memory(
    input rst,
    input [31:0] address,
    output [31:0] rd
    );

    reg [31:0] mem [0:1023]; // 1KB instruction memory

    // initial begin
    //     $readmemh("mem.hex", mem); // Load instructions from hex file
    // end


initial begin
    mem[0] = 32'h00900293; // addi x5, x0, 9       // x5 = 9
    mem[1] = 32'h00800313; // addi x6, x0, 8       // x6 = 8
    mem[2] = 32'h006283B3; // add  x7, x5, x6      // x7 = x5 + x6 = 17
end

    initial begin
        $monitor("Time: %0t, rst: %b, address: %h, rd: %h, mem[0]: %h, mem[1]: %h, mem[2]: %h", $time, rst, address, rd, mem[0],mem[1], mem[2]);
    end

    assign rd = (rst) ? 32'h00000000: mem[address[31:2]]; 

endmodule
