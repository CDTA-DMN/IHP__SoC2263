`timescale 1ns / 1ps

module tb_adc_logic_calibrated;

    reg        clk;
    reg        reset_n;
    reg        sample_en;
    reg        adc_start;
    reg        comp_out;

    wire       comp_en;
    wire       ramp_en;
    wire       ramp_reset;
    wire       adc_done;
    wire       adc_busy;
    wire       mux_sel;
    wire [7:0] adc_data;

    integer ramp_count;
    integer calib_target;
    integer conv_target;
    integer pass_count;
    integer fail_count;

    integer expected;
    integer shift_sel;
    integer corrected;
    integer low_bound;
    integer high_bound;

    adc_logic_cal dut (
        .clk(clk),
        .reset_n(reset_n),
        .sample_en(sample_en),
        .adc_start(adc_start),
        .comp_out(comp_out),
        .comp_en(comp_en),
        .ramp_en(ramp_en),
        .ramp_reset(ramp_reset),
        .adc_done(adc_done),
        .adc_busy(adc_busy),
        .mux_sel(mux_sel),
        .adc_data(adc_data)
    );

    // 1 MHz clock
    initial begin
        clk = 1'b0;
        forever #500 clk = ~clk;
    end

    // Comparator/ramp model
    always @(posedge clk) begin
        if (ramp_reset) begin
            ramp_count <= 0;
            comp_out <= 1'b1;
        end else if (ramp_en && comp_en) begin
            ramp_count <= ramp_count + 1;
            if (ramp_count >= (mux_sel ? conv_target : calib_target))
                comp_out <= 1'b0;
            else
                comp_out <= 1'b1;
        end
    end

    task run_cal_test;
        input integer test_id;
        input integer cal_in;
        input integer conv_in;
        begin
            $display("\nTest %0d: cal_target=%0d conv_target=%0d", test_id, cal_in, conv_in);

            // Fresh reset for each case to force recalibration path
            reset_n = 1'b0;
            #3000;
            calib_target = cal_in;
            conv_target  = conv_in;
            reset_n = 1'b1;

            // Wait for calibration phase completion (mux switches to Vin path)
            wait (mux_sel == 1'b1);
            #2000;

            // Start conversion
            adc_start = 1'b1;
            #1000;
            adc_start = 1'b0;

            // Wait and evaluate
            wait (adc_done == 1'b1);
            #1000;

            // Replicate bracket logic from DUT
            if (cal_in < 241 || cal_in > 269)      shift_sel = 4;
            else if (cal_in < 245 || cal_in > 265) shift_sel = 5;
            else if (cal_in < 249 || cal_in > 261) shift_sel = 6;
            else if (cal_in < 253 || cal_in > 257) shift_sel = 7;
            else                                    shift_sel = 0;

            if (cal_in > 255)
                corrected = conv_in - (shift_sel == 0 ? 0 : (conv_in >> shift_sel));
            else
                corrected = conv_in + (shift_sel == 0 ? 0 : (conv_in >> shift_sel));

            if (corrected > 255) corrected = 255;
            if (corrected < 0)   corrected = 0;

            expected = corrected;
            low_bound = (expected > 2) ? (expected - 2) : 0;
            high_bound = (expected < 253) ? (expected + 2) : 255;

            $display("ADC Result: %0d (0x%02h), Expected ~%0d", adc_data, adc_data, expected);
            if ((adc_data >= low_bound) && (adc_data <= high_bound)) begin
                $display("✓ Test %0d PASSED", test_id);
                pass_count = pass_count + 1;
            end else begin
                $display("✗ Test %0d FAILED", test_id);
                fail_count = fail_count + 1;
            end

            #3000;
        end
    endtask

    initial begin
        $dumpfile("tb_adc_logic_calibrated.vcd");
        $dumpvars(0, tb_adc_logic_calibrated);

        reset_n      = 1'b0;
        sample_en    = 1'b0;
        adc_start    = 1'b0;
        comp_out     = 1'b1;
        ramp_count   = 0;
        pass_count   = 0;
        fail_count   = 0;

        $display("========================================");
        $display("Calibrated ADC Logic Testbench");
        $display("========================================");

        // shift_n=4: <241 or >269 (outermost range)
        run_cal_test(1, 240, 100);   // cal<241, positive correction
        run_cal_test(2, 230, 90);    // cal<241, positive correction
        run_cal_test(3, 270, 180);   // cal>269, negative correction
        run_cal_test(4, 300, 200);   // cal>269, negative correction
        
        // shift_n=5: <245 or >265 (next band)
        run_cal_test(5, 242, 95);    // cal=242 (<245), positive correction
        run_cal_test(6, 244, 105);   // cal=244 (<245), positive correction
        run_cal_test(7, 267, 170);   // cal=267 (>265), negative correction
        run_cal_test(8, 268, 175);   // cal=268 (>265), negative correction
        
        // shift_n=6: <249 or >261 (next band)
        run_cal_test(9, 246, 120);   // cal=246 (<249), positive correction
        run_cal_test(10, 248, 130);  // cal=248 (<249), positive correction
        run_cal_test(11, 262, 160);  // cal=262 (>261), negative correction
        run_cal_test(12, 264, 165);  // cal=264 (>261), negative correction
        
        // shift_n=7: <253 or >257 (inner band)
        run_cal_test(13, 250, 140);  // cal=250 (<253), positive correction
        run_cal_test(14, 252, 155);  // cal=252 (<253), positive correction
        run_cal_test(15, 258, 158);  // cal=258 (>257), negative correction
        run_cal_test(16, 260, 162);  // cal=260 (>257), negative correction
        
        // shift_n=0: 253-257 (center band, no correction)
        run_cal_test(17, 253, 145);  // cal=253, zero correction
        run_cal_test(18, 255, 150);  // cal=255, zero correction
        run_cal_test(19, 256, 152);  // cal=256, zero correction
        run_cal_test(20, 257, 154);  // cal=257, zero correction

        $display("\n========================================");
        $display("Test Summary");
        $display("========================================");
        $display("Total Tests: %0d", pass_count + fail_count);
        $display("Passed:      %0d", pass_count);
        $display("Failed:      %0d", fail_count);
        $display("Coverage:    shift_n=0,4,5,6,7");

        if (fail_count == 0)
            $display("\n*** ALL CALIBRATED ADC TESTS PASSED! ***");
        else
            $display("\n*** SOME CALIBRATED ADC TESTS FAILED! ***");

        $display("========================================");
        #5000;
        $finish;
    end

endmodule
