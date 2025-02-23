`timescale 1ns / 1ps

module pc #()(
    input clk,
    input rst,
    input stall,
    input pc_sel,
    input [31:0] pc_nxt, //used when branch instructions are there
    output reg [31:0] pc_out //Current PC value
);

always @ (posedge clk) begin
    if (rst) begin
        pc_out<= 32'h00000000; // starting address
    end else begin
        pc_out<=(stall)?pc_out:((pc_sel)?pc_nxt:pc_out + 4); //when stalled it will not change it's value
    end
end

endmodule