module adc_logic_cal (
    input  wire       clk,           
    input  wire       reset_n,       
    input  wire       sample_en,     
    input  wire       adc_start,     
    input  wire       comp_out,      
    
    output reg        comp_en,       
    output reg        ramp_en,       
    output reg        ramp_reset,    
    output reg        adc_done,      
    //output reg        mux_sel,       // 0: Vref (1.2V), 1: Vin
    output reg adc_sel_cal,
    output reg adc_sel_meas,
    // Changed: expose mux select as separate outputs for calibration and measurement.
    output reg  [7:0] adc_data,
    output wire       adc_busy
);

    // =========================
    // State Machine Encoding
    // =========================
    localparam CAL_RUN  = 3'b000; 
    localparam CAL_SET  = 3'b001; 
    localparam IDLE     = 3'b010; 
    localparam CONVERT  = 3'b011;
    localparam LATCH    = 3'b100;
    reg mux_sel; // 0: Cal, 1: Measure
    reg [2:0] state;
    reg [8:0] counter;           // Internal 9-bit counter
    reg       counter_enable;
    
    // Calibration Registers (The 4 bits of memory)
    reg [2:0] shift_n;           // Store shift amount (4, 5, 6, 7, 0)
    reg       is_neg;            // 1: Subtract, 0: Add
    
    // =========================
    // Combinational Math Logic
    // This is the "Wire-Based" approach for Synthesis
    // =========================
    wire [8:0] shifted_val = (shift_n == 3'd0) ? 9'd0 : (counter >> shift_n);
    wire [8:0] cal_math    = (is_neg) ? (counter - shifted_val) : (counter + shifted_val);

    // Start Signal Edge Detection
    reg adc_start_sync_1, adc_start_sync_2;
    wire adc_start_edge = adc_start_sync_1 && ~adc_start_sync_2;

    always @(posedge clk or negedge reset_n) begin
        if (!reset_n) {adc_start_sync_1, adc_start_sync_2} <= 2'b0;
        else {adc_start_sync_1, adc_start_sync_2} <= {adc_start, adc_start_sync_1};
    end

    // =========================
    // Main Control State Machine
    // =========================
    always @(posedge clk or negedge reset_n) begin
        if (!reset_n) begin
            state <= CAL_RUN;       
            mux_sel <= 1'b0;        
            shift_n <= 3'd0;
            is_neg <= 1'b0;
            comp_en        <= 1'b0;
            ramp_en        <= 1'b0;
            ramp_reset     <= 1'b1;
            adc_done       <= 1'b0;
            adc_data       <= 8'h00;
            counter_enable <= 1'b0;
        end else begin
            case (state)
                
                CAL_RUN: begin
                    mux_sel    <= 1'b0;
                    ramp_reset <= 1'b0;
                    ramp_en    <= 1'b1;
                    comp_en    <= 1'b1;
                    counter_enable <= 1'b1;
                    if (~comp_out || counter == 9'h1FF) begin
                        state <= CAL_SET;
                        counter_enable <= 1'b0;
                    end
                end

                CAL_SET: begin
                    ramp_reset <= 1'b1;
                    ramp_en    <= 1'b0;
                    is_neg     <= (counter > 9'd255); 
                    
                    if      (counter < 210 || counter > 315) shift_n <= 3'd2; // div 4
                    else if (counter < 235 || counter > 280) shift_n <= 3'd3; // div 8
                    else if (counter < 246 || counter > 278) shift_n <= 3'd4; // div 16
                    else if (counter < 248 || counter > 270) shift_n <= 3'd5; // div 32
                    else if (counter < 252 || counter > 264) shift_n <= 3'd6; // div 64
                    else if (counter < 256 || counter > 260) shift_n <= 3'd7; // div 128
                    else                                     shift_n <= 3'd0; // No change
                    
                    state <= IDLE;
                end

                IDLE: begin
                    adc_done       <= 1'b0;
                    comp_en        <= 1'b0;
                    ramp_en        <= 1'b0;
                    ramp_reset     <= 1'b1;
                    counter_enable <= 1'b0;
                    mux_sel        <= 1'b1;
                    if (adc_start_edge && ~sample_en) begin
                        state <= CONVERT;
                        comp_en <= 1'b1;
                        ramp_en <= 1'b1;
                    end
                end

                CONVERT: begin
                    ramp_reset <= 1'b0;
                    counter_enable <= 1'b1;
                    if (~comp_out || counter == 9'h1FF) begin
                        state <= LATCH;
                        counter_enable <= 1'b0;
                    end
                end

                LATCH: begin
                    // Final Latching with Saturation Logic
                    if (cal_math > 10'd255) 
                        adc_data <= 8'hFF;
                    else
                        adc_data <= cal_math[7:0];

                    adc_done <= 1'b1;
                    ramp_reset <= 1'b1;
                    ramp_en <= 1'b0;
                    state <= IDLE;
                end

                default: state <= IDLE;
            endcase
        end
    end

    // 9-Bit Counter
    always @(posedge clk or negedge reset_n) begin
        if (!reset_n) counter <= 9'h000;
        else if (state == IDLE) counter <= 9'h000;
        else if (counter_enable && comp_out && counter != 9'h1FF) counter <= counter + 1'b1;
    end

    assign adc_busy = (!reset_n) || (!mux_sel);
    assign adc_sel_cal = !mux_sel;
    assign adc_sel_meas = mux_sel;

endmodule