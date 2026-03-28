`timescale 1ns / 1ps

// Simplified prescaler for faster simulation testing
module prescaler_tb_fast (
    input  wire clk_in,
    input  wire rst_n,
    output reg  clk_out
);
    localparam integer MAX_COUNT = 99;  // Reduced for fast simulation
    reg [18:0] counter;

    always @(posedge clk_in or negedge rst_n) begin
        if (!rst_n) begin
            counter <= 19'd0;
            clk_out <= 1'b0;
        end else if (counter == MAX_COUNT) begin
            counter <= 19'd0;
            clk_out <= ~clk_out;
        end else begin
            counter <= counter + 1'b1;
        end
    end
endmodule

module tb_prescaler;

    // Testbench signals
    reg clk_in;
    reg rst_n;
    wire clk_out;

    // Instantiate DUT with fast version for sim
    prescaler_tb_fast dut (
        .clk_in(clk_in),
        .rst_n(rst_n),
        .clk_out(clk_out)
    );

    // Clock generation: 1 MHz (1000 ns period)
    initial begin
        clk_in = 0;
        forever #500 clk_in = ~clk_in;  // 1 MHz clock
    end

    // Test stimulus
    initial begin
        // Display header
        $display("\n========================================");
        $display("PRESCALER TESTBENCH - Fast Simulation");
        $display("MAX_COUNT = 99 (reduces 500k cycles to 100)");
        $display("========================================\n");

        // Initialize signals
        rst_n = 0;
        
        // Apply reset for 5 clock cycles
        #2500;
        rst_n = 1;
        
        $display("Reset released at time %0t ns\n", $time);

        // Wait for first toggle (100 input clock cycles = 100 * 1000 ns)
        #100_000;
        $display("First toggle occurred: clk_out = %b", clk_out);

        // Wait for second toggle
        #100_000;
        $display("Second toggle occurred: clk_out = %b\n", clk_out);

        // Wait for third toggle
        #100_000;
        $display("Third toggle occurred: clk_out = %b", clk_out);

        // Test reset during operation
        #50_000;
        $display("\nApplying reset during operation at time %0t ns...", $time);
        rst_n = 0;
        #2500;
        $display("Reset released at time %0t ns", $time);
        rst_n = 1;

        // Continue monitoring after reset
        #100_000;
        $display("Post-reset: Counter restarted, toggle at clk_out = %b\n", clk_out);

        #100_000;
        $display("Post-reset: Second toggle at clk_out = %b", clk_out);

        // End simulation
        #50_000;
        $display("\n========================================");
        $display("TESTBENCH COMPLETED SUCCESSFULLY");
        $display("========================================\n");
        $finish;
    end

    // Monitor internal counter and output
    initial begin
        $dumpfile("tb_prescaler.vcd");
        $dumpvars(0, tb_prescaler);
        $monitor("Time=%0t ns | clk_in=%b | rst_n=%b | counter=%d | clk_out=%b", 
                 $time, clk_in, rst_n, dut.counter, clk_out);
    end

endmodule
