module fetch (
    input clk,
    input rst,
    input stall,
    input pc_sel,
    input [31:0] pc_nxt,
    output [31:0] pc_f,
    output [31:0] instruction
);
    // Program Counter Module
    pc pc_inst (
        .clk(clk),
        .rst(rst),
        .stall(stall),
        .pc_sel(pc_sel),
        .pc_nxt(pc_nxt),
        .pc_out(pc_f)
    );

    // Instruction Memory Module
    Instruction_memory imem_inst (
        .rst(rst),
        .address(pc_f),
        .rd(instruction)
    );
    
endmodule