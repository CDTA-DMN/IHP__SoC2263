`timescale 1ps/1ps
module cal_fsm (
    input wire clk,
    input wire reset_n,
    input wire compare_result,
    input wire signal_conditionning_en,

    output reg select_cal,
    output reg select_sen,
    output reg sc_en_output,
    output wire cal_busy,
    output reg[3:0] select
);

localparam [1:0]
    GEN_VMIN    = 2'd0,
    SEL_CAL     = 2'd1,
    TEST_CMP    = 2'd2,
    IDLE        = 2'd3;

reg [1:0] state;
reg amplifier_enable;
wire counter_en;


assign counter_en = (state == TEST_CMP) && !(compare_result || select == 4'b0001);

always @(posedge clk or negedge reset_n)
begin
    if (!reset_n)
    begin
        state <= GEN_VMIN;
        select_cal <= 0;
        amplifier_enable <= 0;
    end
    else begin
        case (state)
            GEN_VMIN: begin
                amplifier_enable <= 1;
                state <= SEL_CAL;
            end
            SEL_CAL: begin
                select_cal <= 1;
                state <= TEST_CMP;
            end
            TEST_CMP: begin
                if (compare_result || select == 4'b0001) begin
                    state <= IDLE;
                end
            end
            IDLE: begin
                select_cal <= 0;
                amplifier_enable <= 0;
            end 
            default: state <= IDLE;
        endcase
    end

end

cal_fsm_counter uut_cal_fsm__counter(
    .clk(clk),
    .reset_n(reset_n),
    .en(counter_en),
    .select(select)
);

assign select_sen = !select_cal;
assign sc_en_output = signal_conditionning_en || amplifier_enable;
assign cal_busy = (!reset_n) || amplifier_enable || (state != IDLE);
    
endmodule