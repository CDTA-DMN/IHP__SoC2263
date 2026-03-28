`timescale 1ns / 1ps

module clock_gating_adc_TB;

  // Inputs
  reg clk;
  reg ENB_ADC;

  // Output
  wire clk_gated_adc;

  // Instantiate the Unit Under Test (UUT)
  clock_gating_ADC uut (
    .clk(clk),
    .ENB_ADC(ENB_ADC),
    .clk_gated_adc(clk_gated_adc)
  );

  // Generate clock: 10 us period
  initial begin
    clk = 0;
    forever #500 clk = ~clk; // Toggle every 5us => 10us clock period
  end

  // Test sequence
  initial begin
    $dumpfile("clock_gating_adc_TB.vcd");
    $dumpvars(0, clock_gating_adc_TB);
    
    // Initialize
    ENB_ADC = 0;
    #1000;
    
    // Test 1: Disable enable (gated clock should be off)
    $display("[%0t] TEST 1: ENB_ADC=0 (disable clock)", $time);
    #5000;
    $display("[%0t] clk_gated_adc=%b (expect 0, enable is 0)", $time, clk_gated_adc);

    // Test 2: Enable clock gating
    ENB_ADC = 1;
    $display("[%0t] TEST 2: ENB_ADC=1 (enable clock)", $time);
    #50_000;
    $display("[%0t] clk_gated_adc=%b (expect 1)", $time, clk_gated_adc);

    // Test 3: Disable clock gating
    ENB_ADC = 0;
    $display("[%0t] TEST 3: ENB_ADC=0 (disable clock)", $time);
    #9_500;
    $display("[%0t] clk_gated_adc=%b (expect 0)", $time, clk_gated_adc);
    
    // Test 4: Enable again
    ENB_ADC = 1;
    $display("[%0t] TEST 4: Enable again (ENB_ADC=1)", $time);
    #9_200;
    $display("[%0t] clk_gated_adc=%b (expect 1 - normal operation)", $time, clk_gated_adc);
    
    // Test 5: Multiple enable/disable transitions
    #5000;
    ENB_ADC = 0;
    $display("[%0t] TEST 5: ENB_ADC=0 (disable)", $time);
    #5200;
    ENB_ADC = 1;
    $display("[%0t] TEST 5: ENB_ADC=1 (enable)", $time);
    #5000;
    $display("[%0t] clk_gated_adc=%b (expect 1, normal operation)", $time, clk_gated_adc);

    // Finish
    #5000;
    $finish;
  end

endmodule
