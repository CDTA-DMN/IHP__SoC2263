`timescale 1ns / 1ps

module clock_gating_uart_TB;

  reg clk;
  reg ENB_UART;
  wire clk_gated_uart;

  clock_gating_UART uut (
    .clk(clk),
    .ENB_UART(ENB_UART),
    .clk_gated_uart(clk_gated_uart)
  );

  // Generate clock: 10 us period
  initial begin
    clk = 0;
    forever #500 clk = ~clk; // Toggle every 5us => 10us clock period
  end

  // Test sequence
  initial begin
    $dumpfile("clock_gating_uart_TB.vcd");
    $dumpvars(0, clock_gating_uart_TB);
    
    // Initialize
    ENB_UART = 0;
    #5000;
    
    // Test 1: Disable enable (gated clock should be off)
    $display("[%0t] TEST 1: ENB_UART=0 (disable clock)", $time);
    #5000;
    $display("[%0t] clk_gated_uart=%b (expect 0, enable is 0)", $time, clk_gated_uart);
    
    // Test 2: Enable
    ENB_UART = 1;
    $display("[%0t] TEST 2: ENB_UART=1 (enable clock)", $time);
    #50_000;
    $display("[%0t] clk_gated_uart=%b (expect 1)", $time, clk_gated_uart);
    
    // Test 3: Disable
    ENB_UART = 0;
    $display("[%0t] TEST 3: ENB_UART=0 (disable clock)", $time);
    #9500;
    $display("[%0t] clk_gated_uart=%b (expect 0)", $time, clk_gated_uart);
    
    // Test 4: Enable again
    ENB_UART = 1;
    $display("[%0t] TEST 4: ENB_UART=1 (enable again)", $time);
    #9200;
    $display("[%0t] clk_gated_uart=%b (expect 1 - normal operation)", $time, clk_gated_uart);
    
    // Test 5: Multiple enable/disable transitions
    #5000;
    ENB_UART = 0;
    $display("[%0t] TEST 5: ENB_UART=0 (disable)", $time);
    #5200;
    ENB_UART = 1;
    $display("[%0t] TEST 5: ENB_UART=1 (enable)", $time);
    #5000;
    $display("[%0t] clk_gated_uart=%b (expect 1, normal operation)", $time, clk_gated_uart);
    
    #5000;
    $finish;
  end

endmodule