`timescale 1us / 1ns

module tb_timer_top;

    reg clk;
    reg rst_n;
    reg trigger;
    wire wakeup;

    // DUT
    timer_top uut (
        .clk_in(clk),
        .rst_n(rst_n),
        .trigger(trigger),
        .wakeup(wakeup)
    );

    // 1 MHz clock → 1 us period
    always #0.5 clk = ~clk;

    // ---------------------------
    // Helper: generate trigger pulse
    // ---------------------------
    task send_trigger;
        begin
            trigger = 1;
            #1;
            trigger = 0;
        end
    endtask

    // ---------------------------
    // Helper: long trigger
    // ---------------------------
    task long_trigger;
        begin
            trigger = 1;
            #20;
            trigger = 0;
        end
    endtask

    // ---------------------------
    // Monitor (very useful)
    // ---------------------------
    initial begin
        $display("Time\t rst trigger wakeup");
        $monitor("%0t\t %b   %b      %b", $time, rst_n, trigger, wakeup);
    end

    // ---------------------------
    // Stimulus
    // ---------------------------
    initial begin
        $dumpfile("tb_timer_top.vcd");
        $dumpvars(0, tb_timer_top);

        clk = 0;
        rst_n = 0;
        trigger = 0;

        // ---------------------------
        // TEST 0: Reset behavior
        // ---------------------------
        #5;
        rst_n = 1;

        // ---------------------------
        // TEST 1: Single trigger → timer runs
        // ---------------------------
        $display("\nTEST 1: single trigger");
        #10;
        send_trigger();

        // wait for timer_done
        #200;

        // ---------------------------
        // TEST 2: Long trigger (should act as single pulse)
        // ---------------------------
        $display("\nTEST 2: long trigger");
        long_trigger();

        #200;

        // ---------------------------
        // TEST 3: Multiple triggers (restart timer)
        // ---------------------------
        $display("\nTEST 3: multiple triggers");

        send_trigger();
        #50;

        send_trigger(); // restart before done
        #200;

        // ---------------------------
        // TEST 4: Back-to-back triggers
        // ---------------------------
        $display("\nTEST 4: back-to-back triggers");

        send_trigger();
        #5;
        send_trigger();
        #5;
        send_trigger();

        #200;

       s

        // ---------------------------
        // TEST 7: Continuous operation
        // ---------------------------
        $display("\nTEST 7: continuous triggers");

        repeat (5) begin
            send_trigger();
            #150;
        end

        #300;

        // ---------------------------
        // TEST 8: Timer-generated wakeup (no trigger)
        // ---------------------------
        $display("\nTEST 8: timer wakeup without trigger");
        trigger = 0;

        // Reset and wait for natural timer expiration with fast RTL settings
        // (prescaler MAX_COUNT=499, counter TARGET_COUNT=9).
        rst_n = 0;
        #5;
        rst_n = 1;

        fork
            begin
                @(posedge wakeup);
                $display("  PASS: Timer-generated wakeup detected at t=%0t", $time);
                #20000;
            end
            begin
                #500000;
                $display("  FAIL: Timeout waiting for timer-generated wakeup");
                $fatal(1);
            end
        join_any
        disable fork;
        #2000;
        // ---------------------------
        // END SIMULATION
        // ---------------------------
        $display("\nSimulation Finished");
        $finish;
    end

endmodule