module memory (
    input clk,
    input rst,
    input mem_read,
    input mem_write,
    input [31:0] alu_result,
    input [31:0] write_data,
    input [2:0] funct3,
    output [31:0] read_data
    );

    data_memory data_memory_inst(
        .clk(clk),
        .rst(rst),
        .mem_read(mem_read),
        .mem_write(mem_write),
        .address(alu_result),
        .write_data(write_data),
        .funct3(funct3),
        .read_data(read_data)
    );

endmodule