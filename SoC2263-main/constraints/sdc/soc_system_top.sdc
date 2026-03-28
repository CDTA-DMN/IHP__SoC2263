###############################################################################
# Created by write_sdc
###############################################################################
current_design soc_system_top
###############################################################################
# Timing Constraints
###############################################################################
create_clock -name clk_PAD -period 20.0000 [get_ports {clk_PAD}]
set_clock_transition 0.1500 [get_clocks {clk_PAD}]
set_clock_uncertainty 0.2500 clk_PAD
set_propagated_clock [get_clocks {clk_PAD}]
set_input_delay 0.0000 -clock [get_clocks {clk_PAD}] -min -add_delay [get_ports {adc_done_PAD}]
set_input_delay 4.0000 -clock [get_clocks {clk_PAD}] -max -add_delay [get_ports {adc_done_PAD}]
set_output_delay 4.0000 -clock [get_clocks {clk_PAD}] -add_delay [get_ports {state_out_0_PAD}]
set_output_delay 4.0000 -clock [get_clocks {clk_PAD}] -add_delay [get_ports {state_out_1_PAD}]
set_output_delay 4.0000 -clock [get_clocks {clk_PAD}] -add_delay [get_ports {state_out_2_PAD}]
set_output_delay 4.0000 -clock [get_clocks {clk_PAD}] -add_delay [get_ports {tx_PAD}]
###############################################################################
# Environment
###############################################################################
set_load -pin_load 0.0060 [get_ports {VDD1v5}]
set_load -pin_load 0.0060 [get_ports {adc_done_PAD}]
set_load -pin_load 0.0060 [get_ports {clk_PAD}]
set_load -pin_load 0.0060 [get_ports {reset_n_PAD}]
set_load -pin_load 0.0060 [get_ports {sc_enable_PAD}]
set_load -pin_load 0.0060 [get_ports {sc_vout_PAD}]
set_load -pin_load 0.0060 [get_ports {sc_vref_PAD}]
set_load -pin_load 0.0060 [get_ports {sensor_PAD}]
set_load -pin_load 0.0060 [get_ports {state_out_0_PAD}]
set_load -pin_load 0.0060 [get_ports {state_out_1_PAD}]
set_load -pin_load 0.0060 [get_ports {state_out_2_PAD}]
set_load -pin_load 0.0060 [get_ports {trigger_PAD}]
set_load -pin_load 0.0060 [get_ports {tx_PAD}]
set_load -pin_load 0.0060 [get_ports {vbg_PAD}]
set_load -pin_load 0.0060 [get_ports {vramp_PAD}]
###############################################################################
# Design Rules
###############################################################################
set_max_fanout 10.0000 [current_design]
