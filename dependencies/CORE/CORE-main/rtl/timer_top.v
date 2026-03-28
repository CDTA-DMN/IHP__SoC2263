module timer_top (
    input  wire clk_in,    // 1 MHz clock
    input  wire rst_n,     // Active-low reset
    input  wire trigger,   // External trigger
    output wire wakeup     // 1us pulse
);

    // ---------------------------
    // 1. Edge Detection (fast domain)
    // ---------------------------
    reg trig_d1, trig_d2;
    wire trig_edge;

    always @(posedge clk_in or negedge rst_n) begin
        if (!rst_n) {trig_d1, trig_d2} <= 2'b00;
        else        {trig_d1, trig_d2} <= {trigger, trig_d1};
    end

    assign trig_edge = trig_d1 & ~trig_d2;

    // ---------------------------
    // 2. Prescaler
    // ---------------------------
    wire clk_1hz;

    prescaler u_prescaler (
        .clk_in (clk_in),
        .rst_n  (rst_n),
        .clk_out(clk_1hz)
    );

    // ---------------------------
    // 3. Trigger Latch (FAST DOMAIN)
    // ---------------------------
    reg trigger_flag;
    wire clear_flag;        // from slow domain

    // Sync clear_flag back to fast domain
    reg clr_d1, clr_d2;
    always @(posedge clk_in or negedge rst_n) begin
        if (!rst_n) {clr_d1, clr_d2} <= 2'b00;
        else        {clr_d1, clr_d2} <= {clear_flag, clr_d1};
    end

    wire clear_flag_sync = clr_d2;

    always @(posedge clk_in or negedge rst_n) begin
        if (!rst_n)
            trigger_flag <= 1'b0;
        else if (trig_edge)
            trigger_flag <= 1'b1;
        else if (clear_flag_sync)
            trigger_flag <= 1'b0;
    end

    // ---------------------------
    // 4. Counter (slow domain)
    // ---------------------------
    wire timer_done_level;

    counter_10bits u_counter (
        .clk_1hz      (clk_1hz),
        .rst_n        (rst_n),
        .trigger_flag (trigger_flag),
        .clear_flag   (clear_flag),
        .timer_done   (timer_done_level)
    );

    // ---------------------------
    // 5. Pulse shaping (fast domain)
    // ---------------------------
    reg done_d1, done_d2;
    wire done_edge;

    always @(posedge clk_in or negedge rst_n) begin
        if (!rst_n) {done_d1, done_d2} <= 2'b00;
        else        {done_d1, done_d2} <= {timer_done_level, done_d1};
    end

    assign done_edge = done_d1 & ~done_d2;

    // Final output
    assign wakeup = trig_edge | done_edge;

endmodule