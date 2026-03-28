`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.07.2025 17:14:37
// Design Name: 
// Module Name: clock_gating_ADC
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module clock_gating_ADC(
    input wire clk,
    input wire ENB_ADC,
    output wire clk_gated_adc
);

reg enable_latched ;

always @(clk or ENB_ADC) begin
 if (!clk)
    enable_latched <= ENB_ADC;
end

assign clk_gated_adc = clk & enable_latched;


endmodule