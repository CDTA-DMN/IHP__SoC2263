`timescale 1ns / 1ps
module uart_module (
    input  wire clk,
    input  wire rst_n,            // Changed: asynchronous active-low reset
    input  wire tx_start,
    input  wire [7:0] tx_data,
    output reg tx,
    output reg tx_busy,
    output reg tx_done
);

    localparam integer CLK_FREQ  = 1000000; // 1 MHz
    localparam integer BAUD_RATE = 9600;
    localparam integer BIT_PERIOD = CLK_FREQ / BAUD_RATE; // = 104

    localparam [1:0] IDLE      = 2'b00;
    localparam [1:0] START_BIT = 2'b01;
    localparam [1:0] DATA_BITS = 2'b10;
    localparam [1:0] STOP_BIT  = 2'b11;

    reg [1:0] state;
    reg [6:0] baud_counter;
    reg [2:0] bit_index;
    reg [7:0] data_reg;
    reg tx_start_sync_1;
    reg tx_start_sync_2;
    wire tx_start_edge;

    // tx_start synchronization into UART clock domain
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            tx_start_sync_1 <= 1'b0;
            tx_start_sync_2 <= 1'b0;
        end else begin
            tx_start_sync_1 <= tx_start;
            tx_start_sync_2 <= tx_start_sync_1;
        end
    end

    assign tx_start_edge = tx_start_sync_1 && !tx_start_sync_2;

    // Data latch on start event
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            data_reg <= 8'b0;
        else if (tx_start_edge && !tx_busy)
            data_reg <= tx_data;
    end

    // UART TX FSM
    // Changed: add async reset path.
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            state <= IDLE;
            tx <= 1'b1;
            tx_busy <= 1'b0;
            tx_done <= 1'b0;
            bit_index <= 0;
            baud_counter <= 0;
        end else begin
            case (state)
                IDLE: begin
                    tx <= 1'b1;
                    tx_busy <= 1'b0;
                    tx_done <= 1'b0;
                    if (tx_start_edge) begin
                        state <= START_BIT;
                        baud_counter <= 0;
                        tx_busy <= 1'b1;
                    end
                end

                START_BIT: begin
                    tx <= 1'b0;
                    if (baud_counter == BIT_PERIOD - 1) begin
                        baud_counter <= 0;
                        bit_index <= 0;
                        state <= DATA_BITS;
                    end else
                        baud_counter <= baud_counter + 1;
                end

                DATA_BITS: begin
                    tx <= data_reg[bit_index];
                    if (baud_counter == BIT_PERIOD - 1) begin
                        baud_counter <= 0;
                        if (bit_index == 7)
                            state <= STOP_BIT;
                        else
                            bit_index <= bit_index + 1;
                    end else
                        baud_counter <= baud_counter + 1;
                end

                STOP_BIT: begin
                    tx <= 1'b1;
                    if (baud_counter == BIT_PERIOD - 1) begin
                        baud_counter <= 0;
                        tx_busy <= 1'b0;
                        tx_done <= 1'b1;
                        state <= IDLE;
                    end else
                        baud_counter <= baud_counter + 1;
                end

                default: begin
                    state <= IDLE;
                end
            endcase
        end
    end

endmodule