`timescale 1ns / 1ps

module tb_clock_gating_adc;

    reg clk;
    reg ENB_ADC;
    wire clk_gated_adc;

    // Instantiate the clock gating module
    clock_gating_ADC uut (
        .clk(clk),
        .ENB_ADC(ENB_ADC),
        .clk_gated_adc(clk_gated_adc)
    );

    // Clock generation: 1MHz (1000ns period)
    always #500 clk = ~clk;

    initial begin
        $dumpfile("vcd/tb_clock_gating_adc.vcd");
        $dumpvars(0, tb_clock_gating_adc);

        // Initialize
        clk = 0;
        ENB_ADC = 0;

        #1000;

        // Test 1: Enable signal goes high before clock rising edge
        #1500;
        ENB_ADC = 1;  // EN goes high at T=5500ns
        
        // Wait to see capture at rising edge
        #10000;
        ENB_ADC = 0;

        // Test 2: Enable pulses
        #2000;
        ENB_ADC = 1;
        #1000;
        ENB_ADC = 0;
        #1000;
        ENB_ADC = 1;
        #1000;
        ENB_ADC = 0;

        #10000;
        $finish;
    end

    // Monitor to display timing events
    initial begin
        $monitor("Time=%0t | clk=%b | ENB=%b | Q=%b | clk_gated=%b", 
                 $time, clk, ENB_ADC, uut.Q, clk_gated_adc);
    end

endmodule
