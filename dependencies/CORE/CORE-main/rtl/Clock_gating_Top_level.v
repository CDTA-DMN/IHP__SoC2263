
`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.10.2025 13:02:19
// Design Name: 
// Module Name: Clock_gating_Top_level
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


module Clock_gating_Top_level(
 input wire clk,             // System clock input
    input wire ENB_ADC,        // Enable signal for UART block
    input wire ENB_UART,         // Enable signal for ADC block
    input wire ENB_CAL,          // Enable signal for calibration block
    output wire clk_gated_adc, // Gated clock for UART
    output wire clk_gated_uart,  // Gated clock for ADC
    output wire clk_gated_cal    // Gated clock for calibration FSM
);



// Instantiate the ADC clock gating module
clock_gating_ADC adc_clk_gate (
    .clk(clk),
    .ENB_ADC(ENB_ADC),
    .clk_gated_adc(clk_gated_adc)
);

// Instantiate the UART clock gating module
clock_gating_UART uart_clk_gate (
    .clk(clk),
    .ENB_UART(ENB_UART),
    .clk_gated_uart(clk_gated_uart)
);

// Instantiate the calibration clock gating module
clock_gating_Cond cal_clk_gate (
    .clk(clk),
    .ENB_COND(ENB_CAL),
    .clk_gated_cond(clk_gated_cal)
);
endmodule