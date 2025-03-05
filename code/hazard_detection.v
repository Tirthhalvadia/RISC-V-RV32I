`timescale 1ns / 1ps

module hazard_detection(
    //input clk,
    input [4:0] rs1_D, rs2_D, rd_E, rd_M, rd_W,
    input reg_write_E, reg_write_M, reg_write_W,
    output reg stall
    );

always @(*) begin
    if (
        ((rs1_D != 0) && (
            (rs1_D == rd_E && reg_write_E) || 
            (rs1_D == rd_M && reg_write_M) || 
            (rs1_D == rd_W && reg_write_W)
        )) ||
        ((rs2_D != 0) && (
            (rs2_D == rd_E && reg_write_E) || 
            (rs2_D == rd_M && reg_write_M) || 
            (rs2_D == rd_W && reg_write_W)
        ))
    ) begin
        stall = 1'b1;
    end else begin
        stall = 1'b0;     
    end
end

endmodule
