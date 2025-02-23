module writeback(
    input [31:0] alu_result,
    input [31:0] read_data,
    input mem_to_reg,
    output [31:0] write_data
    );

    assign write_data = (mem_to_reg)?read_data:alu_result;
    
endmodule