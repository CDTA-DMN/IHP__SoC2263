`timescale 1ps/1ps
module counter_tb;

// Testbench signals
reg clk;
reg reset_n;
reg en;
wire [3:0] select;

// Expected values for verification
reg [3:0] expected_select;
integer pass_count = 0;
integer fail_count = 0;
integer i;

// Instantiate the calibration FSM counter
cal_fsm_counter uut (
    .clk(clk),
    .reset_n(reset_n),
    .en(en),
    .select(select)
);

// Clock generation: 1000ns period (1MHz)
always #500 clk = ~clk;

// Test sequence
initial begin
    // Initialize signals
    clk = 0;
    reset_n = 0;
    en = 0;
    
    $display("========================================");
    $display("Starting Counter Testbench");
    $display("========================================\n");
    
    // Test 1: Reset verification
    $display("Test 1: Reset Verification");
    $display("-------------------------");
    #2000;
    if (select == 4'b1111)
        $display("  [PASS] Reset works correctly");
    else
        $display("  [FAIL] Reset failed: select = %d", select);
    
    // Test 2: Enable counting
    $display("\nTest 2: Enable Counting");
    $display("-----------------------");
    reset_n = 1;  // Release reset
    en = 1;       // Enable counting
    
    for (i = 0; i < 20; i++) begin
        #1000;  // Wait one clock cycle at 1MHz
        $display("  Time=%0t, select=%0d", $time, select);
    end
    
    // Test 3: Disable counting
    $display("\nTest 3: Disable Counting");
    $display("------------------------");
    en = 0;
    #3000;
    $display("  Time=%0t, select=%0d (should not change)", $time, select);
    
    // Test 4: Re-enable and verify wrap-around
    $display("\nTest 4: Wrap-around Test");
    $display("------------------------");
    en = 1;
    // Run until we see wrap-around
    for (i = 0; i < 20; i++) begin
        #1000;
        $display("  Time=%0t, select=%0d", $time, select);
        if (i > 0 && select < 0) begin
            $display("  [INFO] Counter wrapped at %0t", $time);
        end
    end
    
    // Test 5: Reset during operation
    $display("\nTest 5: Reset During Operation");
    $display("-----------------------------");
    #2000;
    reset_n = 0;
    #1000;
    if (select == 4'b1111)
        $display("  [PASS] Reset during operation works");
    else
        $display("  [FAIL] Reset during operation failed");
    
    // Test 6: Random enable/disable
    $display("\nTest 6: Random Enable/Disable");
    $display("-----------------------------");
    reset_n = 1;
    
    repeat(10) begin
        en = $random;
        #1000;
        $display("  Time=%0t, en=%b, select=%0d", $time, en, select);
    end
    
    // Summary
    $display("\n========================================");
    $display("Testbench Complete");
    $display("========================================");
    
    // Finish simulation
    #5000;
    $finish;
end

// Monitor for errors (if using the version without auto-reset)
always @(select) begin
    if (select > 4'b1111) begin
        $display("[ERROR] select out of range: %d at time %0t", select, $time);
    end
end

// Generate waveform file for GTKWave
initial begin
    $dumpfile("counter_tb.vcd");
    $dumpvars(0, counter_tb);
end

endmodule