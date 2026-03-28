`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 22.03.2026
// Design Name:
// Module Name: clock_gating_Cond
// Project Name:
// Target Devices:
// Tool Versions:
// Description: Latch-based clock gating for calibration/conditioning logic.
//
// Dependencies:
//
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//
//////////////////////////////////////////////////////////////////////////////////

module clock_gating_Cond(
    input wire clk,
    input wire ENB_COND,
    output wire clk_gated_cond
);

reg enable_latched;

always @(clk or ENB_COND) begin
    if (!clk)
        enable_latched <= ENB_COND;
end

assign clk_gated_cond = clk & enable_latched;

endmodule
