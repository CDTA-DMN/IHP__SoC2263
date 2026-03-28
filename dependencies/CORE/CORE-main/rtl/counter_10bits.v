module counter_10bits (
    input  wire clk_1hz,
    input  wire rst_n,
    input  wire trigger_flag, // LEVEL from fast domain
    output reg  clear_flag,   // handshake back
    output reg  timer_done    // 1-second level
);

    localparam [9:0] TARGET_COUNT = 10'd599; // 600 seconds -> 10 minutes use small for fast simulation

    reg [9:0] counter;

    // ---------------------------
    // Synchronize trigger_flag
    // ---------------------------
    reg trig_d1, trig_d2;

    always @(posedge clk_1hz or negedge rst_n) begin
        if (!rst_n)
            {trig_d1, trig_d2} <= 2'b00;
        else
            {trig_d1, trig_d2} <= {trigger_flag, trig_d1};
    end

    wire trig_edge = trig_d1 & ~trig_d2;

    // ---------------------------
    // Counter logic
    // ---------------------------
    always @(posedge clk_1hz or negedge rst_n) begin
        if (!rst_n) begin
            counter    <= 10'd0;
            timer_done <= 1'b0;
        end 
        else if (trig_edge) begin
            counter    <= 10'd0;
            timer_done <= 1'b0;
            clear_flag <= 1'b1; // acknowledge trigger
        end 
        else if (counter == TARGET_COUNT) begin
            counter    <= 10'd0;
            timer_done <= 1'b1;
            clear_flag <= 1'b0;
        end 
        else begin
            counter    <= counter + 1'b1;
            timer_done <= 1'b0;
            clear_flag <= 1'b0;
        end
    end

endmodule