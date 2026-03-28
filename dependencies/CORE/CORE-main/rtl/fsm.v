`timescale 1ns / 1ps
module fsm (
    input  wire clk,
    input  wire rst_n,
    input  wire wake_up_sg,
    input  wire adc_done,
    input  wire uart_done,
    input  wire uart_busy,
    output reg  adc_en,
    output reg  uart_en,
    output reg  sc_en,
    output reg  adc_start,
    output reg  tx_start,
    output wire [2:0] state_out
);

    
    localparam [2:0]
        IDLE       = 3'd0,
        WAKE_UP    = 3'd1,
        SC_WAIT    = 3'd2,
        START_ADC  = 3'd3,
        ADC_WAIT   = 3'd4,
        UART_START = 3'd5,
        UART_WAIT  = 3'd6;

    reg [2:0] state, next_state;

    reg adc_s0,  adc_s1;
    reg uart_s0, uart_s1;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            adc_s0  <= 1'b0;
            adc_s1  <= 1'b0;
            uart_s0 <= 1'b0;
            uart_s1 <= 1'b0;
        end else begin
            adc_s0  <= adc_done;
            adc_s1  <= adc_s0;
            uart_s0 <= uart_done;
            uart_s1 <= uart_s0;
        end
    end

    wire adc_done_sync  = adc_s1;
    wire uart_done_sync = uart_s1;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            state <= IDLE;
        else
            state <= next_state;
    end

    
    always @(*) begin
        // Safe defaults
        adc_en     = 1'b0;
        uart_en    = 1'b0;
        sc_en      = 1'b0;
        tx_start   = 1'b0;
        adc_start  = 1'b0;
        next_state = state;

        case (state)
            IDLE: begin
                if (wake_up_sg)
                    next_state = WAKE_UP;
            end

            WAKE_UP: begin
                sc_en      = 1'b1;
                adc_en     = 1'b1;
                next_state = SC_WAIT;
            end

            SC_WAIT: begin
                sc_en      = 1'b1;
                adc_en     = 1'b1;
                next_state = START_ADC;
            end

            START_ADC: begin
                adc_en     = 1'b1;
                adc_start  = 1'b1;
                next_state = ADC_WAIT;
            end

            ADC_WAIT: begin
                adc_en  = 1'b1;
                uart_en = 1'b1;
                if (adc_done_sync)          
                    next_state = UART_START;
            end

            UART_START: begin
                uart_en = 1'b1;
                if (!uart_busy)
                    next_state = UART_WAIT;
            end

            UART_WAIT: begin
                uart_en  = 1'b1;
                tx_start = 1'b1;
                if (uart_done_sync)         
                    next_state = IDLE;
            end

            default: next_state = IDLE;
        endcase
    end

    assign state_out = state;

endmodule