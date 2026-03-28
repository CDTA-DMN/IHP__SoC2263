`timescale 1ns/1ps

module SoC_Analog_Top (
    `ifdef USE_POWER_PINS
    inout wire VDD,
    inout wire VSS,
    `endif
    inout wire VDD1v5,
    // Digital control signals from FSM
    // Inputs
    input wire RAMP_EN,
    input wire RAMP_RESET,
    input wire ADC_SEL_CAL,
    input wire ADC_SEL_MEAS,
    input wire SC_S0,
    input wire SC_S1,
    input wire SC_S2,
    input wire SC_S3,
    input wire SC_SEL_CAL,
    input wire SC_SEL_SENSOR,
    input wire SC_EN,
    
    // Outputs
    output wire CLK, // to pad and digital logic
    output wire VRAMP, // to pad (pad analog)
    output wire SC_VOUT, // to pad (pad analog)
    output wire SC_VREF, // to pad (pad analog)
    output wire VBG, // to pad (pad analog)
    output wire RESET, // to digital logic 
    output wire ADC_CMP_OUT, // to digital ADC logic
    output wire SC_CMP_RESULT, // to digital calibration FSM

    // INOUTS
    inout wire SENSOR // to pad
);

endmodule