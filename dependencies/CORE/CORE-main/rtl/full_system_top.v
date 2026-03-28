`timescale 1ns / 1ps

// ============================================================
// FULL SYSTEM TOP LEVEL - SoC Temperature Sensor
// ============================================================
// SIMULATION MODE: Timer parameters optimized for fast simulation
// HARDWARE MODE: Before deployment, set hardware parameter values
//                in the timer_top instantiation (see line ~44-47)
// ============================================================

module full_system_top (
    input  wire clk,
    input  wire rst_n,        // asynchronous active-low reset (from pin/POR)
    input  wire adc_comp_out,
    input  wire cal_comp_out,
    input  wire trigger,

    output wire tx,
    output wire [2:0] state_out,
    // Changed: expose ADC analog control signals to top level.
    output wire comp_en,
    output wire ramp_en,
    output wire ramp_reset,
    // Changed: expose ADC and UART completion signals for testbench verification.
    output wire adc_done,
    output wire adc_sel_cal,
    output wire adc_sel_meas,
    // Calibration outputs
    output wire select_cal,
    output wire select_sen,
    output wire singnal_conditionning_en,
    output wire [3:0] select
);

    // === Timer parameters (manual selection) ===
    // Edit these values directly depending on use:
    // - Hardware 10-minute wakeup: PRESCALER_MAX=999_999, COUNTER_MAX=10'd599
    // - Fast simulation:          PRESCALER_MAX=499,     COUNTER_MAX=10'd9
    localparam integer TIMER_PRESCALER_MAX = 499;     // Fast simulation default
    localparam [9:0]  TIMER_COUNTER_MAX   = 10'd9;    // Fast simulation default

    // === Reset Synchronizer (2-stage) ===
  
    //always @(posedge clk) begin
     //   rst_n <= rst_n_async;
    //end
    //wire rst_n = rst_sync;  // synchronized active-low reset

    // === FSM control signals ===
    wire adc_en;
    wire uart_en;
    wire sc_en;
    wire clk_gated_adc;
    wire clk_gated_uart;
    wire clk_gated_cal;
    // Changed: removed clk_gating_en (not needed—adc_en/uart_en control clock gates directly).
    wire adc_busy;
    wire cal_busy;
    wire cal_active;
    wire adc_clk_en;

    wire tx_start;
    wire uart_busy;
    wire adc_start;
    wire trigger_armed;
    wire [7:0] adc_result;
    wire uart_done;
    wire wakeup;

    // === 10-minute Wake-up Timer (or immediate external trigger) ===
    // Parameters selected by HARDWARE_TIMER_MODE macro above.
    assign trigger_armed = trigger & rst_n & ~cal_busy & ~adc_busy;

    timer_top uut_timer (
        .clk_in(clk),
        .trigger(trigger_armed),
        .wakeup(wakeup),
        .rst_n(rst_n)
    );

    assign cal_active = (!rst_n) | cal_busy;
    assign adc_clk_en = (!rst_n) | adc_en | adc_busy;

    // === Clock Gating ===
    // Keep ADC clock enabled during startup calibration, then use FSM adc_en.
    Clock_gating_Top_level uut_clock_gating (
        .clk(clk),
        .ENB_ADC(adc_clk_en),
        .ENB_UART(uart_en),
        .ENB_CAL(cal_active),
        .clk_gated_adc(clk_gated_adc),
        .clk_gated_uart(clk_gated_uart),
        .clk_gated_cal(clk_gated_cal)
    );

    // === FSM ===
    fsm uut_fsm (
        .clk           (clk),
        .rst_n         (rst_n),
        .wake_up_sg    (wakeup),
        .adc_done      (adc_done),
        .uart_done     (uart_done),
        .uart_busy     (uart_busy),

        .adc_en        (adc_en),
        // Changed: removed clk_gating_en port.
        .sc_en         (sc_en),
        .adc_start     (adc_start),
        .uart_en       (uart_en),
        .tx_start      (tx_start),
        .state_out     (state_out)
    );

    // === ADC Digital Logic (Calibrated) ===
    adc_logic_cal uut_adc_logic (
        // Calibrated ADC logic runs on gated ADC clock.
        .clk       (clk_gated_adc),
        .reset_n   (rst_n),
        // Changed: connect conditioner/sample control from FSM.
        .sample_en (sc_en),
        .adc_start (adc_start),
        // Changed: comparator input comes from external analog path.
        .comp_out  (adc_comp_out),
        // Changed: expose ADC analog control signals to top-level outputs.
        .comp_en   (comp_en),
        .ramp_en   (ramp_en),
        .ramp_reset(ramp_reset),
        .adc_done  (adc_done),
        .adc_sel_cal (adc_sel_cal),
        .adc_sel_meas (adc_sel_meas),
        .adc_data  (adc_result),
        .adc_busy  (adc_busy)
    );

    // === UART ===
    uart_module uut_uart (
        // Changed: UART runs on gated UART clock while enabled.
        .clk       (clk_gated_uart),
        .rst_n     (rst_n),
        .tx_start  (tx_start),
        .tx_data   (adc_result),
        .tx        (tx),
        .tx_busy   (uart_busy),
        .tx_done   (uart_done)
    );

    // === Calibration FSM ===
    // Calibration runs on gated clock; active only during startup/calibration phase
    cal_fsm uut_cal_fsm (
        .clk                    (clk_gated_cal),
        .reset_n                (rst_n),
        .compare_result         (cal_comp_out),
        .signal_conditionning_en(sc_en),
        .select_cal             (select_cal),
        .select_sen             (select_sen),
        .sc_en_output           (singnal_conditionning_en),
        .cal_busy               (cal_busy),
        .select                 (select)
    );

endmodule
