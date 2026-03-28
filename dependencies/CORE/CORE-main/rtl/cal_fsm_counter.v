`timescale 1ps/1ps
module cal_fsm_counter (
    input wire clk,
    input wire reset_n,
    input wire en,
    output reg [3:0] select
);



always @(posedge clk or negedge reset_n)
begin
    if (!reset_n) select <= 4'b1111;
    else if(en) select <= select-1;
end


endmodule