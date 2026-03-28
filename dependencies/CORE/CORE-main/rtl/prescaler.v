module prescaler (
    input  wire clk_in,      // 1 MHz clock
    input  wire rst_n,
    output reg  clk_out      // 1 Hz clock
);

    localparam integer MAX_COUNT = 499_999; // generate 1 Hz from 1 MHz use 499 for fast simulation

    reg [18:0] counter;

    always @(posedge clk_in or negedge rst_n) begin
        if (!rst_n) begin
            counter <= 19'd0;
            clk_out <= 1'b0;
        end 
        else if (counter == MAX_COUNT) begin
            counter <= 19'd0;
            clk_out <= ~clk_out;
        end 
        else begin
            counter <= counter + 1'b1;
        end
    end

endmodule