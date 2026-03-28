`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.07.2025 18:11:35
// Design Name: 
// Module Name: clock_gating_UART
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


module clock_gating_UART(

   input wire clk,
   input wire ENB_UART,
   output wire clk_gated_uart
);

reg enable_latched ;

always @( clk or ENB_UART ) begin
    if (!clk)
    enable_latched <= ENB_UART;
end

assign clk_gated_uart = clk & enable_latched ;


endmodule