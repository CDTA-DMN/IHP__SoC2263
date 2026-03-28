`timescale 1ns/1ps
module soc_digital_top_with_io (
     `ifdef USE_POWER_PINS
    inout wire IOVDD, // PAD IOVDD
    inout wire VSS, // PAD VSS
    inout wire VDD, // PAD VDD
    inout wire IOVSS, // PAD IOVSS
    `endif
    inout wire VDD1v5, // PAD Analog
    // Clock and Reset Inputs (from pads)
    inout wire clk_PAD, // INPUT Digital pad
    inout wire reset_n_PAD, // INPUT Digital pad
    
    // Trigger and SC Enable Inputs (from pads)
    inout wire trigger_PAD, // INPUT Digital pad
    inout wire sc_enable_PAD, // Input Digital pad
    
    // Analog block feedback and control signals
    // input wire analog_reset_n_PIN,  // Active-low reset from analog block
    // input wire adc_comp_out_PIN,
    // input wire cal_comp_out_PIN,
    
    // UART Output (to pad)
    inout wire tx_PAD, // OUTPUT Digital 16mA pad
    
    // FSM State Outputs (to pads)
    inout wire state_out_0_PAD, // OUTPUT Digital 16mA pad
    inout wire state_out_1_PAD, // OUTPUT Digital 16mA pad
    inout wire state_out_2_PAD, // OUTPUT Digital 16mA pad
    
    // ADC Done Output (to pad)
    inout wire adc_done_PAD, // OUTPUT Digital 16mA pad

    // Analog conditionning pads
    inout wire sc_vout_PAD,
    inout wire sc_vref_PAD,
    
    // Analog control signals (to analog wrapper via pads in klayout)
    // output wire ramp_en_PIN,         // Ramp enable
    // output wire ramp_reset_PIN,      // Ramp reset
    // output wire adc_sel_cal_PIN,     // ADC select calibration
    // output wire adc_sel_meas_PIN,    // ADC select measurement
    // output wire sc_select_cal_PIN,   // SC select calibration
    // output wire sc_select_sen_PIN,   // SC select sensor
    // output wire singnal_conditionning_en_PIN, // Signal conditioning enable (SC enable)
    // output wire [3:0] sc_cal_ref_select,    // 4-bit SC selection
    
    // Sensor INOUT (to pad)
    inout wire sensor_PAD, // Analog pad
    inout wire vbg_PAD, // Analog pad
    inout wire vramp_PAD // Analog pad
);

    //----------- macro connections -----------
    //l signals (to analog wrapper via pads in klayout)
    wire ramp_en_PIN;         // Ramp enable
    wire ramp_reset_PIN;      // Ramp reset
    wire adc_sel_cal_PIN;     // ADC select calibration
    wire adc_sel_meas_PIN;    // ADC select measurement
    wire sc_select_cal_PIN;   // SC select calibration
    wire sc_select_sen_PIN;   // SC select sensor
    wire singnal_conditionning_en_PIN; // Signal conditioning enable (SC enable)

    // // to digital from analog wrapper
    wire analog_reset_n_PIN;  // Active-low reset from analog block
    wire adc_comp_out_PIN;
    wire cal_comp_out_PIN;
    ///------------------ End of macro connections -----------
    // ========== Internal signal definitions ==========
    wire clk;                   // Clock from pad (direct pass-through to modules)
    wire reset_n;               // Active-low reset: ORed combination of pad and analog reset
    wire reset_n_pad_sg;
    wire trigger;               // Trigger from pad
    //wire sc_enable;             // Switch capacitor enable: ORed combination of pad and analog enable
    wire sc_enable_pad_sg;
    
    // Digital module outputs
    wire tx;                        // UART TX output
    wire [2:0] state_out;           // FSM state outputs
    wire adc_done;                  // ADC done signal
    
    // Analog control signals from digital FSM
    wire comp_en;                   // Comparator enable to analog block
    wire ramp_en;                   // Ramp enable to analog block
    wire ramp_reset;                // Ramp reset to analog block
    wire adc_sel_cal;               // ADC select calibration to analog block
    wire adc_sel_meas;              // ADC select measurement to analog block
    wire select_cal;                // SC select calibration to analog block
    wire select_sen;                // SC select sensor to analog block
    wire [3:0] sc_cal_ref_select;              // 4-bit SC selection signal
    wire sc_enable_digital;
    // ========== OR Gate Logic for Combined Signals ==========
    // Combine pad signals with analog block signals using OR logic
    assign reset_n = reset_n_pad_sg | analog_reset_n_PIN;      // OR gate: pad reset OR analog reset
    assign singnal_conditionning_en_PIN = sc_enable_pad_sg | sc_enable_digital; // OR gate: pad sc_enable OR digital sc_enable
    
    // ========== Instantiate the I/O pads ==========
    
    // Clock Input Pad
    (* keep *) sg13g2_IOPadOut16mA sg13g2_IOPadIn_clk (
        `ifdef USE_POWER_PINS
        .iovdd  (IOVDD),
        .iovss  (IOVSS),
        .vdd    (VDD),
        .vss    (VSS),
        `endif
        .c2p(clk),
        .pad(clk_PAD)
    );

    // Reset Input Pad (active-low)
    (* keep *) sg13g2_IOPadIn sg13g2_IOPadIn_reset_n (
        `ifdef USE_POWER_PINS
        .iovdd  (IOVDD),
        .iovss  (IOVSS),
        .vdd    (VDD),
        .vss    (VSS),
        `endif
        .p2c(reset_n_pad_sg),
        .pad(reset_n_PAD)
    );

    // Trigger Input Pad
    (* keep *) sg13g2_IOPadIn sg13g2_IOPadIn_trigger (
        `ifdef USE_POWER_PINS
        .iovdd  (IOVDD),
        .iovss  (IOVSS),
        .vdd    (VDD),
        .vss    (VSS),
        `endif
        .p2c(trigger),
        .pad(trigger_PAD)
    );

    // SC Enable Input Pad
    (* keep *) sg13g2_IOPadIn sg13g2_IOPadIn_sc_enable (
        `ifdef USE_POWER_PINS
        .iovdd  (IOVDD),
        .iovss  (IOVSS),
        .vdd    (VDD),
        .vss    (VSS),
        `endif  
        .p2c(sc_enable_pad_sg),
        .pad(sc_enable_PAD)
    );

    // UART TX Output Pad
    (* keep *) sg13g2_IOPadOut16mA sg13g2_IOPadOut_tx (
        `ifdef USE_POWER_PINS
        .iovdd  (IOVDD),
        .iovss  (IOVSS),
        .vdd    (VDD),
        .vss    (VSS),
        `endif
        .c2p(tx),
        .pad(tx_PAD)
    );

    // FSM State Output Pads
    (* keep *) sg13g2_IOPadOut16mA sg13g2_IOPadOut_state_out_0 (
        `ifdef USE_POWER_PINS
        .iovdd  (IOVDD),
        .iovss  (IOVSS),
        .vdd    (VDD),
        .vss    (VSS),
        `endif
        .c2p(state_out[0]),
        .pad(state_out_0_PAD)
    );

    (* keep *) sg13g2_IOPadOut16mA sg13g2_IOPadOut_state_out_1 (
        `ifdef USE_POWER_PINS
        .iovdd  (IOVDD),
        .iovss  (IOVSS),
        .vdd    (VDD),
        .vss    (VSS),
        `endif
        .c2p(state_out[1]),
        .pad(state_out_1_PAD)
    );

    (* keep *) sg13g2_IOPadOut16mA sg13g2_IOPadOut_state_out_2 (
        `ifdef USE_POWER_PINS
        .iovdd  (IOVDD),
        .iovss  (IOVSS),
        .vdd    (VDD),
        .vss    (VSS),
        `endif
        .c2p(state_out[2]),
        .pad(state_out_2_PAD)
    );

    // ADC Done Output Pad
    (* keep *) sg13g2_IOPadOut16mA sg13g2_IOPadOut_adc_done (
        `ifdef USE_POWER_PINS
        .iovdd  (IOVDD),
        .iovss  (IOVSS),
        .vdd    (VDD),
        .vss    (VSS),
        `endif
        .c2p(adc_done),
        .pad(adc_done_PAD)
    );

    // Sensor INOUT Pad
    (* keep *) sg13g2_IOPadAnalog sg13g2_IOPadAnalog_sensor (
        `ifdef USE_POWER_PINS
        .iovdd  (IOVDD),
        .iovss  (IOVSS),
        .vdd    (VDD),
        .vss    (VSS),
        `endif
        .pad(sensor_PAD),
        .padres(sensor_PAD)
    );

    // VBG Analog Output Pad
    (* keep *) sg13g2_IOPadAnalog sg13g2_IOPadAnalog_vbg (
        `ifdef USE_POWER_PINS
        .iovdd  (IOVDD),
        .iovss  (IOVSS),
        .vdd    (VDD),
        .vss    (VSS),
        `endif
        .padres(vbg_PAD),
        .pad(vbg_PAD)
    );

    // VRAMP Analog Output Pad
    (* keep *) sg13g2_IOPadAnalog sg13g2_IOPadAnalog_vramp (
        `ifdef USE_POWER_PINS
        .iovdd  (IOVDD),
        .iovss  (IOVSS),
        .vdd    (VDD),
        .vss    (VSS),
        `endif
        .pad(vramp_PAD),
        .padres(vramp_PAD)
    );

    // Power/Ground Pads
    (* keep *) sg13g2_IOPadVdd sg13g2_IOPadVdd_core (
        `ifdef USE_POWER_PINS
        .iovdd  (IOVDD),
        .iovss  (IOVSS),
        .vdd    (VDD),
        .vss    (VSS)
        `endif
    );

    (* keep *) sg13g2_IOPadAnalog sg13g2_IOPadAnalog_vdd1v5 (
        `ifdef USE_POWER_PINS
        .iovdd  (IOVDD),
        .iovss  (IOVSS),
        .vdd    (VDD),
        .vss    (VSS),
        `endif
        .pad    (VDD1v5),
        .padres (VDD1v5)
    );
    (* keep *) sg13g2_IOPadAnalog sg13g2_IOPadAnalog_sc_vout (
        `ifdef USE_POWER_PINS
        .iovdd  (IOVDD),
        .iovss  (IOVSS),
        .vdd    (VDD),
        .vss    (VSS),
        `endif
        .pad    (sc_vout_PAD),
        .padres (sc_vout_PAD)
    );
    (* keep *) sg13g2_IOPadAnalog sg13g2_IOPadAnalog_sc_vref (
        `ifdef USE_POWER_PINS
        .iovdd  (IOVDD),
        .iovss  (IOVSS),
        .vdd    (VDD),
        .vss    (VSS),
        `endif
        .pad    (sc_vref_PAD),
        .padres (sc_vref_PAD)
    );

    (* keep *) sg13g2_IOPadVss sg13g2_IOPadVss_core (
        `ifdef USE_POWER_PINS
        .iovdd  (IOVDD),
        .iovss  (IOVSS),
        .vdd    (VDD),
        .vss    (VSS)
        `endif
    );

    (* keep *) sg13g2_IOPadIOVdd sg13g2_IOPadIOVdd_io (
        `ifdef USE_POWER_PINS
        .iovdd  (IOVDD),
        .iovss  (IOVSS),
        .vdd    (VDD),
        .vss    (VSS)
        `endif
    );

    (* keep *) sg13g2_IOPadIOVss sg13g2_IOPadIOVss_io (
        `ifdef USE_POWER_PINS
        .iovdd  (IOVDD),
        .iovss  (IOVSS),
        .vdd    (VDD),
        .vss    (VSS)
        `endif
    );

    (* keep *) sg13g2_IOPadIOVss sg13g2_IOPadIOVSS_io_dummy (
        `ifdef USE_POWER_PINS
        .iovdd  (IOVDD),
        .iovss  (IOVSS),
        .vdd    (VDD),
        .vss    (VSS)
        `endif
    );
    wire cmp_en;
    // ========== Instantiate the Digital System Top Module ==========
    (* keep *) full_system_top uut_full_system_top (
        // Clock and Reset
        .clk(clk),
        .rst_n(reset_n),
        
        // Analog feedback inputs
        .adc_comp_out(adc_comp_out_PIN),
        .cal_comp_out(cal_comp_out_PIN),
        
        // Digital control inputs
        .trigger(trigger),
        
        // UART transmit output
        .tx(tx),
        
        // FSM state outputs
        .state_out(state_out),
        
        // ADC control and completion signals
        .comp_en(cmp_en),
        .ramp_en(ramp_en_PIN),
        .ramp_reset(ramp_reset_PIN),
        .adc_done(adc_done),
        .adc_sel_cal(adc_sel_cal_PIN),
        .adc_sel_meas(adc_sel_meas_PIN),
        
        // Calibration and SC control outputs
        .select_cal(sc_select_cal_PIN),
        .select_sen(sc_select_sen_PIN),
        .singnal_conditionning_en(sc_enable_digital),
        .select(sc_cal_ref_select)
    );


    (* keep *)SoC_Analog_Top uut_soc_analog_top_wrapper (
        `ifdef USE_POWER_PINS
         .VDD    (VDD),
         .VSS    (VSS),
         `endif
        // Digital control signals from FSM
        .RAMP_EN(ramp_en_PIN),
        .RAMP_RESET(ramp_reset_PIN),
        .ADC_SEL_CAL(adc_sel_cal_PIN),
        .ADC_SEL_MEAS(adc_sel_meas_PIN),
        .SC_SEL_CAL(sc_select_cal_PIN),
        .SC_SEL_SENSOR(sc_select_sen_PIN),
        .SC_EN(sc_enable_digital),
        .SC_S0(sc_cal_ref_select[0]),
        .SC_S1(sc_cal_ref_select[1]),
        .SC_S2(sc_cal_ref_select[2]),
        .SC_S3(sc_cal_ref_select[3]),
        
        // Analog outputs to pads
        .CLK(clk), // to pad and digital logic
        .VRAMP(vramp_PAD), // to pad (pad analog)
        .SC_VOUT(sc_vout_PAD), // to pad (pad analog)
        .SC_VREF(sc_vref_PAD), // to pad (pad analog)
        .VBG(vbg_PAD), // to pad (pad analog)
        .RESET(analog_reset_n_PIN), // to digital logic 
        .ADC_CMP_OUT(adc_comp_out_PIN), // to digital ADC logic
        .SC_CMP_RESULT(cal_comp_out_PIN), // to digital calibration FSM
        .SENSOR(sensor_PAD),
        .VDD1v5(VDD1v5) // to pad (pad analog)
    );

endmodule
