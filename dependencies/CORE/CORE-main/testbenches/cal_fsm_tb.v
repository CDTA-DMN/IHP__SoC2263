`timescale 1ps/1ps
module tb_cal_fsm();

// Testbench signals
reg clk;
reg reset_n;
reg compare_result;
reg signal_conditionning_en;
wire select_cal;
wire select_sen;
wire amplifier_en_output;
wire cal_busy;
wire [3:0] select;

integer cycle_count;
integer pass_count;
integer fail_count;
integer test_number;

// Instantiate the FSM
cal_fsm uut (
    .clk(clk),
    .reset_n(reset_n),
    .compare_result(compare_result),
    .signal_conditionning_en(signal_conditionning_en),
    .select_cal(select_cal),
    .select_sen(select_sen),
    .amplifier_en_output(amplifier_en_output),
    .cal_busy(cal_busy),
    .select(select)
);

// Clock generation: 1MHz (1µs period)
localparam CLK_PERIOD = 1000000; // 1,000,000ps = 1µs
always #(CLK_PERIOD/2) clk = ~clk;

// Main test control
initial begin
    integer i;
    reg [3:0] expected_code;
    reg test_passed;
    reg loop_done;
    
    // Initialize
    clk = 0;
    reset_n = 0;
    compare_result = 0;
    signal_conditionning_en = 0;
    cycle_count = 0;
    pass_count = 0;
    fail_count = 0;
    test_number = 0;
    
    $display("========================================");
    $display("Starting cal_fsm Testbench");
    $display("Clock Period: %0d ps = 1µs", CLK_PERIOD);
    $display("========================================\n");
    
    // Release reset after 2 cycles
    #(CLK_PERIOD*2);
    reset_n = 1;
    #(CLK_PERIOD);
    
    // Test 1: Normal operation - code 6 works
    test_number = test_number + 1;
    expected_code = 6;
    $display("\n--- Test %0d: Code %0d works ---", test_number, expected_code);
    
    // Reset before test
    reset_n = 0;
    #(CLK_PERIOD);
    reset_n = 1;
    #(CLK_PERIOD*2); // Through GEN_VMIN and SEL_CAL
    
    test_passed = 0;
    loop_done = 0;
    
    for (i = 0; i < 20 && !loop_done; i = i + 1) begin
        #(CLK_PERIOD);
        
        // Set compare_result based on the code being tested THIS cycle
        if (uut.state == 2'b10) begin // TEST_CMP
            // The code being tested is what we saw at the beginning of this cycle
            if (select == expected_code && !test_passed) begin
                compare_result = 1;
                test_passed = 1;
                $display("  Cycle %0d: Testing code %0d - PASS (setting compare=1)", 
                         i, select);
            end else begin
                compare_result = 0;
                $display("  Cycle %0d: Testing code %0d - FAIL", i, select);
            end
        end else begin
            compare_result = 0;
        end
        
        // Check if calibration completed
        if (uut.state == 2'b11) begin // IDLE
            $display("  Calibration completed at cycle %0d, final code = %0d", i, select);
            if (select == expected_code) begin
                $display("  ✅ Test %0d PASSED", test_number);
                pass_count = pass_count + 1;
            end else begin
                $display("  ❌ Test %0d FAILED - Expected %0d, got %0d", 
                         test_number, expected_code, select);
                fail_count = fail_count + 1;
            end
            loop_done = 1;
        end
    end
    
    #(CLK_PERIOD*5);
    
    // Test 2: Code 15 works immediately
    test_number = test_number + 1;
    expected_code = 15;
    $display("\n--- Test %0d: Code %0d works immediately ---", test_number, expected_code);
    
    reset_n = 0;
    #(CLK_PERIOD);
    reset_n = 1;
    #(CLK_PERIOD*2);
    
    test_passed = 0;
    loop_done = 0;
    
    for (i = 0; i < 20 && !loop_done; i = i + 1) begin
        
        
        if (uut.state == 2'b10) begin
            if (select == expected_code && !test_passed) begin
                compare_result = 1;
                test_passed = 1;
                $display("  Cycle %0d: Testing code %0d - PASS", i, select);
            end else begin
                compare_result = 0;
                $display("  Cycle %0d: Testing code %0d - FAIL", i, select);
            end
        end else begin
            compare_result = 0;
        end
        
        if (uut.state == 2'b11) begin
            $display("  Calibration completed at cycle %0d, final code = %0d", i, select);
            if (select == expected_code) begin
                $display("  ✅ Test %0d PASSED", test_number);
                pass_count = pass_count + 1;
            end else begin
                $display("  ❌ Test %0d FAILED - Expected %0d, got %0d", 
                         test_number, expected_code, select);
                fail_count = fail_count + 1;
            end
            loop_done = 1;
        end
        #(CLK_PERIOD);
    end
    
    #(CLK_PERIOD*5);
    
    // Test 3: Code 1 works (latest compare pass point)
    test_number = test_number + 1;
    expected_code = 1;
    $display("\n--- Test %0d: Code %0d works ---", test_number, expected_code);
    
    reset_n = 0;
    #(CLK_PERIOD);
    reset_n = 1;
    #(CLK_PERIOD*2);
    
    test_passed = 0;
    loop_done = 0;
    
    for (i = 0; i < 20 && !loop_done; i = i + 1) begin
        #(CLK_PERIOD);
        
        if (uut.state == 2'b10) begin
            if (select == expected_code && !test_passed) begin
                compare_result = 1;
                test_passed = 1;
                $display("  Cycle %0d: Testing code %0d - PASS", i, select);
            end else begin
                compare_result = 0;
                $display("  Cycle %0d: Testing code %0d - FAIL", i, select);
            end
        end else begin
            compare_result = 0;
        end
        
        if (uut.state == 2'b11) begin
            $display("  Calibration completed at cycle %0d, final code = %0d", i, select);
            if (select == expected_code) begin
                $display("  ✅ Test %0d PASSED", test_number);
                pass_count = pass_count + 1;
            end else begin
                $display("  ❌ Test %0d FAILED - Expected %0d, got %0d", 
                         test_number, expected_code, select);
                fail_count = fail_count + 1;
            end
            loop_done = 1;
        end
    end
    
    #(CLK_PERIOD*5);
    
    // Test 4: No code works 
    test_number = test_number + 1;
    $display("\n--- Test %0d: No code works (should exit at 15) ---", test_number);
    
    reset_n = 0;
    #(CLK_PERIOD);
    reset_n = 1;
    #(CLK_PERIOD*2);
    
    compare_result = 1; // Never passes
    loop_done = 0;
    
    for (i = 0; i < 20 && !loop_done; i = i + 1) begin
        #(CLK_PERIOD);
        
        if (uut.state == 2'b10) begin
            $display("  Cycle %0d: Testing code %0d - FAIL", i, select);
        end
        
        if (uut.state == 2'b11) begin
            $display("  Calibration completed at cycle %0d, final code = %0d", i, select);
            if (select == 15) begin
                $display("  ✅ Test %0d PASSED", test_number);
                pass_count = pass_count + 1;
            end else begin
                $display("  ❌ Test %0d FAILED - Expected 15, got %0d", test_number, select);
                fail_count = fail_count + 1;
            end
            loop_done = 1;
        end
    end
    
    #(CLK_PERIOD*5);
    
    // Test 5: Reset during calibration
    test_number = test_number + 1;
    $display("\n--- Test %0d: Reset during calibration ---", test_number);
    
    reset_n = 0;
    #(CLK_PERIOD);
    reset_n = 1;
    #(CLK_PERIOD*3); // Let it get to TEST_CMP
    
    // Assert reset
    reset_n = 0;
    #(CLK_PERIOD);
    
    // Check reset state
    if (uut.state == 2'b00 && uut.counter_en == 0) begin
        $display("  ✅ Reset correct: state=GEN_VMIN, counter_en=0");
        pass_count = pass_count + 1;
    end else begin
        $display("  ❌ Reset incorrect: state=%0d, counter_en=%0d", 
                 uut.state, uut.counter_en);
        fail_count = fail_count + 1;
    end
    
    // Release reset
    #(CLK_PERIOD);
    reset_n = 1;
    #(CLK_PERIOD*5);
    
    // Test 6: Signal conditioning enable test
    test_number = test_number + 1;
    $display("\n--- Test %0d: Signal conditioning enable ---", test_number);
    
    reset_n = 0;
    #(CLK_PERIOD);
    reset_n = 1;
    signal_conditionning_en = 1;
    #(CLK_PERIOD*10);
    
    if (amplifier_en_output) begin
        $display("  ✅ amplifier_en_output asserted with signal conditioning");
        pass_count = pass_count + 1;
    end else begin
        $display("  ❌ Enable problem: amp=%0d", amplifier_en_output);
        fail_count = fail_count + 1;
    end
    
    // Summary
    $display("\n========================================");
    $display("Test Summary: PASS=%0d, FAIL=%0d", pass_count, fail_count);
    $display("========================================");
    
    if (fail_count == 0)
        $display("\n✅ ALL TESTS PASSED!");
    else
        $display("\n❌ %0d TESTS FAILED!", fail_count);
    
    #(CLK_PERIOD*10);
    $finish;
end

// Monitor FSM state
always @(posedge clk) begin
    cycle_count = cycle_count + 1;
    
    if (uut.state > 2'b11) begin
        $display("  ⚠️ WARNING: Undefined state detected: %0d at cycle %0d", uut.state, cycle_count);
    end
end

// Dump waveforms
initial begin
    $dumpfile("cal_fsm_tb.vcd");
    $dumpvars(0, tb_cal_fsm);
end

endmodule