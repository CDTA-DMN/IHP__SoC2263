`timescale 1ns / 1ps

module fsm_tb;

    // DUT signals
    reg  clk;
    reg  rst_n;
    reg  wake_up_sg;
    reg  adc_done;
    reg  uart_done;
    reg  uart_busy;

    wire adc_en;
    wire uart_en;
    wire sc_en;
    wire adc_start;
    wire tx_start;
    wire [2:0] state_out;  // Debug: current FSM state

    // Instantiate DUT
    fsm uut (
        .clk           (clk),
        .rst_n         (rst_n),
        .wake_up_sg    (wake_up_sg),
        .adc_done      (adc_done),
        .uart_done     (uart_done),
        .uart_busy     (uart_busy),
        .adc_en        (adc_en),
        .uart_en       (uart_en),
        .sc_en         (sc_en),
        .adc_start     (adc_start),
        .tx_start      (tx_start),
        .state_out     (state_out)  // Connect state debug output
    );

    // Clock generator: 1 MHz (period = 1000 ns)
    initial begin
        clk = 0;
        forever #500 clk = ~clk;  // Toggle every 500 ns
    end

    // Stimulus process
    initial begin
        // Initialize all inputs
        rst_n         = 0;
        wake_up_sg    = 0;
        adc_done      = 0;
        uart_done     = 0;
        uart_busy     = 1;  // UART starts busy

        $display("[T=%0t] Starting simulation", $time);

        // Hold reset for 2 clock cycles (2 �s)
        #2000;
        rst_n = 1;
        $display("[T=%0t] Reset released", $time);

        // Wait 1 cycle before triggering
        #1000;

        // ===== TEST 1: Normal Operation =====
        $display("[T=%0t] === TEST 1: Normal FSM Cycle ===", $time);

        // Assert wake_up_sg for 1 full clock cycle (1 �s)
        wake_up_sg = 1;
        #1000;
        wake_up_sg = 0;
        $display("[T=%0t] wake_up_sg pulsed", $time);

        // Wait for FSM to enter WAKE_UP (should happen next cycle)
        #1000;

        // FSM should now be in WAKE_UP ? outputs active
        if (adc_en && sc_en) begin
            $display("[T=%0t] ? WAKE_UP: enables active", $time);
        end else begin
            $display("[T=%0t] ? WAKE_UP: some enables missing", $time);
        end

       

 

        // Wait for START_ADC (adc_start pulse)
        #2000;
        if (adc_start) begin
            $display("[T=%0t] ? START_ADC: adc_start pulsed", $time);
        end

        // Simulate ADC done
        #5500;  
        adc_done = 1;
        #1000;
        adc_done = 0;
        $display("[T=%0t] adc_done pulsed", $time);

        // Wait for UART_START (FSM waits for !uart_busy)
        #1000;
        uart_busy = 0;  // Release UART
        $display("[T=%0t] uart_busy released", $time);

        // Wait for UART_WAIT (tx_start pulse)
        #4000;
        if (tx_start) begin
            $display("[T=%0t] ? UART_WAIT: tx_start pulsed", $time);
        end
        uart_busy = 1; // now the uart is busy again
        // Simulate UART done
        #5500; 
        uart_done = 1;
        #1000;
        uart_done = 0;
        $display("[T=%0t] uart_done pulsed", $time);

        // Wait for return to IDLE
        #3000;
        if (state_out == 3'd0) begin
            $display("[T=%0t] ? Returned to IDLE", $time);
        end

        // ===== TEST 2: Abort Test =====
        $display("\n[T=%0t] === TEST 2: Abort with wake_up_sg ===", $time);

        // Trigger again
        #500;
        wake_up_sg = 1;
        #1000;
        wake_up_sg = 0;
        #1000;

        // Let it reach ADC_WAIT (state = 4)
        #3000;

        // Abort by re-asserting wake_up_sg
        wake_up_sg = 1;
        #1000;
        wake_up_sg = 0;
        $display("[T=%0t] Abort signal sent", $time);

        // Should ignore it 
        #4000;
        if (state_out != 3'd0) begin
            $display("[T=%0t] ? Continue successfully", $time);
        end
        // Simulate ADC done
        #5500;  
        adc_done = 1;
        #1000;
        adc_done = 0;
        $display("[T=%0t] adc_done pulsed", $time);

        // Wait for UART_START (FSM waits for !uart_busy)
        #1000;
        uart_busy = 0;  // Release UART
        $display("[T=%0t] uart_busy released", $time);

        // Wait for UART_WAIT (tx_start pulse)
        #4000;
        if (tx_start) begin
            $display("[T=%0t] ? UART_WAIT: tx_start pulsed", $time);
        end
        uart_busy = 1; // now the uart is busy again

        // Simulate UART done
        #5500; 
        uart_done = 1;
        #1000;
        uart_done = 0;
        $display("[T=%0t] uart_done pulsed", $time);
        // Wait for return to IDLE
        #3000;
        if (state_out == 3'd0) begin
            $display("[T=%0t] ? Returned to IDLE", $time);
        end
        // ===== TEST 3: Reset Test =====
        $display("\n[T=%0t] === TEST 3: Synchronous Reset ===", $time);

        wake_up_sg = 1;
        #1000;
        wake_up_sg = 0;
        #2000;

        // Assert reset
        rst_n = 0;
        #1000;
        rst_n = 1;
        $display("[T=%0t] Reset pulsed", $time);

        // Should be in IDLE
        #2000;
        if (state_out == 3'd0) begin
            $display("[T=%0t] ? Reset successful", $time);
        end

        // End simulation
        $display("\n[T=%0t] === SIMULATION COMPLETE ===", $time);
        #10000; // Total ~50 �s
        $finish;
    end
initial begin
    $dumpfile("fsm.vcd");   // waveform file
    $dumpvars(0, fsm_tb);   // dump all signals
end
endmodule