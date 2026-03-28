`timescale 1ns / 1ps

module Clock_gating_TB;

reg clk;
reg ENB_ADC;
reg ENB_UART;
reg ENB_CAL;
wire clk_gated_adc;
wire clk_gated_uart;
wire clk_gated_cal;

Clock_gating_Top_level dut (
    .clk(clk),
    .ENB_ADC(ENB_ADC),
    .ENB_UART(ENB_UART),
    .ENB_CAL(ENB_CAL),
    .clk_gated_adc(clk_gated_adc),
    .clk_gated_uart(clk_gated_uart),
    .clk_gated_cal(clk_gated_cal)
);

// Clock generation (1000ns period = 1 MHz)
initial begin
    clk = 0;
    forever #500 clk = ~clk;
end

initial begin
    $dumpfile("Clock_gating_TB.vcd");
    $dumpvars(0, Clock_gating_TB);
    
    // Initialize
    clk = 0;
    ENB_ADC = 0;
    ENB_UART = 0;
    ENB_CAL = 0;
    #5000;
    
    // Test 1: Enable ADC
    $display("[%0t] TEST 1: ENB_ADC=1", $time);
    ENB_ADC = 1;
    #9500;
    $display("[%0t] clk_gated_adc=%b (expect 1)", $time, clk_gated_adc);
    
    // Test 2: Enable UART instead
    ENB_ADC = 0; 
    ENB_UART = 1; 
    $display("[%0t] TEST 2: ENB_ADC=0, ENB_UART=1", $time);
    #9200;
    $display("[%0t] clk_gated_uart=%b (expect 1)", $time, clk_gated_uart);
    
    // Test 3: Enable CAL only
    ENB_UART = 0;
    ENB_CAL = 1;
    $display("[%0t] TEST 3: ENB_UART=0, ENB_CAL=1", $time);
    #9700;
    $display("[%0t] clk_gated_cal=%b (expect 1)", $time, clk_gated_cal);

    // Test 4: Disable CAL
    ENB_CAL = 0;
    $display("[%0t] TEST 4: ENB_CAL=0 (disable CAL clock)", $time);
    #9500;
    $display("[%0t] clk_gated_cal=%b (expect 0)", $time, clk_gated_cal);

    // Test 5: Enable all clocks
    ENB_ADC = 1;
    ENB_UART = 1;
    ENB_CAL = 1;
    $display("[%0t] TEST 5: ENB_ADC=1, ENB_UART=1, ENB_CAL=1", $time);
    #9500;
    $display("[%0t] clk_gated_adc=%b, clk_gated_uart=%b, clk_gated_cal=%b (all expect 1)", $time, clk_gated_adc, clk_gated_uart, clk_gated_cal);
    
    #5000;
    $finish;
end 

endmodule