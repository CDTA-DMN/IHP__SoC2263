`timescale 1ns / 1ps

module tb_full_final;

    // Parameters for FAST SIMULATION
    localparam SIM_PRESCALER_MAX = 499;
    localparam SIM_COUNTER_MAX = 9;
    // Timer delay = (counter+1) * 1kHz prescaler = 10 * 1ms = 10ms
    localparam SIM_TIMER_DELAY = (SIM_COUNTER_MAX + 1) * (SIM_PRESCALER_MAX + 1) * 1000;

    reg clk = 0;
    reg rst_n = 1;
    reg adc_comp_out = 0;
    reg cal_comp_out = 0;
    reg trigger = 0;

    wire tx;
    wire [2:0] state_out;
    wire wakeup;
    wire comp_en;
    wire ramp_en;
    wire ramp_reset;
    wire adc_done;
    wire uart_done;
    wire cal_measure_sel;
    wire select_cal;
    wire select_sen;
    wire amplifier_en_output;
    wire [3:0] select;
    
    reg [7:0] adc_captured;
    integer test_num = 0;
    
    full_system_top uut (
        .clk(clk),
        .rst_n(rst_n),
        .adc_comp_out(adc_comp_out),
        .cal_comp_out(cal_comp_out),
        .tx(tx),
        .state_out(state_out),
        .wakeup(wakeup),
        .comp_en(comp_en),
        .ramp_en(ramp_en),
        .ramp_reset(ramp_reset),
        .adc_done(adc_done),
        .uart_done(uart_done),
        .cal_meas_sel(cal_measure_sel),
        .select_cal(select_cal),
        .select_sen(select_sen),
        .amplifier_en_output(amplifier_en_output),
        .select(select),
        .trigger(trigger)
    );

    always #500 clk = ~clk;

    always @(posedge adc_done)
        adc_captured <= uut.adc_result;

    always @(posedge uart_done)
        $display("  [TEST %0d] UART DONE at t=%0t: transmitted 0x%02H", test_num, $time, adc_captured);

    // Monitor wakeup signal for TEST 1
    reg wakeup_detected = 0;
    always @(posedge wakeup) begin
        if (test_num == 1 && !wakeup_detected) begin
            $display("  PASS: Wakeup asserted at t=%0t", $time);
            wakeup_detected = 1;
        end
    end

    initial begin
        $display("\n");
        $display("========== FULL SYSTEM INTEGRATION TEST ==========");
        $display("Fast Simulation Parameters:");
        $display("  Prescaler: %0d", SIM_PRESCALER_MAX + 1);
        $display("  Counter: %0d", SIM_COUNTER_MAX + 1);
        $display("  Timer Delay: %0d ns\n", SIM_TIMER_DELAY);
        
        // INITIALIZATION with calibration sequence
        $display("[INIT] Reset and calibration startup...");
        trigger = 0; adc_comp_out = 0; cal_comp_out = 0; rst_n = 1;
        #1000; rst_n = 0; #1000;
        
        // On reset release: drive adc_comp_out high for calibration (~1.2ms)
        rst_n = 1; adc_comp_out = 1;
        
        // cal_comp_out transitions high at ~250us (within 240-270us window)
        #7000; cal_comp_out = 1;
        trigger = 1;
        #2000 trigger = 0;
        // Keep both high for rest of calibration window (~1.2ms total from adc_high)
        #260000; adc_comp_out = 0; cal_comp_out = 0;
        
        $display("[INIT] Calibration complete");
        $display("[DEBUG] wakeup=%b at t=%0t\n", wakeup, $time);

        // TEST 1: TIMER
        test_num = 1;
        $display("[TEST 1] TIMER-BASED WAKE");
        $display("  Waiting for wakeup signal...");
        @(posedge wakeup);
        $display("[DEBUG] Wakeup detected: wakeup=%b, state=%b at t=%0t", wakeup, state_out, $time);
        $display("[TEST 1] Timer ~10ms + ADC/UART ~1.4ms = ~11.4ms total\n");
        adc_comp_out = 1;
        #90000; adc_comp_out = 0;
        #3_000_000;
        $display("  Done\n");

        // TEST 2: TRIGGER
        test_num = 2;
        $display("[TEST 2] TRIGGER WAKE");
        trigger = 1; 
        adc_comp_out = 1;
        #200000; adc_comp_out = 0;
        #1_000_000; trigger = 0;
        #5_000_000;
        $display("  Done\n");

        // TEST 3: SUCCESSIVE
        test_num = 3;
        $display("[TEST 3] SUCCESSIVE OPS");
        trigger = 1; 
        adc_comp_out = 1;
        #240000; adc_comp_out = 0;
        #1_000_000; trigger = 0;
        #7_000_000;
        $display("  Done\n");

        // TEST 4: RESET
        test_num = 4;
        $display("[TEST 4] RESET DURING OP");
        trigger = 1; 
        adc_comp_out = 1;
        #1000000; rst_n = 0; #1000; rst_n = 1;
        #248000;adc_comp_out = 0; #5000;
        trigger = 0;
        if (state_out == 0) $display("  PASS: IDLE recovered");
        else $display("  state=%b", state_out);
        $display("  Done\n");

        #8_000_000; 
        $display("========== TESTS COMPLETE ==========\n");
        $finish;
    end

    initial begin
        $dumpfile("vcd/full_system_top.vcd");
        $dumpvars(0, tb_full_final);
    end

endmodule
