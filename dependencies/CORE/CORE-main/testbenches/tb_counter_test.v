`timescale 1ns / 1ps

module tb_counter_test;

    reg clk_1hz;
    reg rst_n;
    reg trigger;
    wire wakeup;

    // Instantiate DUT
    counter_10bits dut (
        .clk_1hz(clk_1hz),
        .rst_n(rst_n),
        .trigger(trigger),
        .timer_done(wakeup)
    );

    // Clock generation (1MHz for simulation consistency across testbenches)
    // Clock period = 1000ns
    initial begin
        clk_1hz = 0;
        forever #500 clk_1hz = ~clk_1hz;
    end

    // Stimulus
    initial begin
        // Initial values
        rst_n = 0;
        trigger = 0;

        // Release reset
        #5000;
        rst_n = 1;

        // Wait some cycles so counter reaches TARGET_COUNT (29)
        // Each count happens on posedge, so just wait
        #50_000;

        // Trigger externally to test wakeup OR feature
        trigger = 1;
        #5000;
        trigger = 0;

        // Wait a bit more then stop
        #25_000;
        $finish;
    end

    // Optional waveform / debug monitor
    initial begin
        $monitor("Time=%0t | rst_n=%b | counter=%d | timer_done? wakeup=%b | trigger=%b",
                 $time,rst_n, dut.counter, wakeup, trigger);
    end

endmodule
