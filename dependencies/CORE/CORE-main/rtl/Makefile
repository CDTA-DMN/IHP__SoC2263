# Makefile for Temperature Sensor Node Digital Testbenches
# Compiler: Icarus Verilog (iverilog/vvp)

.PHONY: all clean sim_fsm sim_cal_fsm sim_full_top sim_uart sim_timer sim_timer_ce sim_prescaler sim_counter sim_cal_counter sim_adc sim_adc_cal sim_clk_gating help

# Compiler and simulator
IVERILOG = iverilog
VVP = vvp
GTKWAVE = gtkwave

# Compiler flags
VFLAGS = -g2012

# Output directory
BUILD_DIR = build
VCD_DIR = vcd

# Create directories if they don't exist
$(shell mkdir -p $(BUILD_DIR) $(VCD_DIR))

# ============================================================
# Default target
# ============================================================
all: help

help:
	@echo "Temperature Sensor Node - Digital Testbenches"
	@echo "=============================================="
	@echo ""
	@echo "Available targets:"
	@echo "  make sim_fsm          - Run FSM testbench"
	@echo "  make sim_cal_fsm      - Run calibration FSM testbench"
	@echo "  make sim_uart         - Run UART module testbench"
	@echo "  make sim_timer        - Run timer top testbench"
	@echo "  make sim_timer_ce     - Run timer_top_ce testbench"
	@echo "  make sim_prescaler    - Run prescaler testbench"
	@echo "  make sim_counter      - Run 10-bit counter testbench"
	@echo "  make sim_cal_counter  - Run cal_fsm_counter testbench (tb/counter_tb.v)"
	@echo "  make sim_adc          - Run ADC logic testbench"
	@echo "  make sim_adc_cal      - Run calibrated ADC logic testbench"
	@echo "  make sim_clk_gating   - Run clock gating testbench"
	@echo "  make sim_full_top     - Run full system top-level testbench"
	@echo "  make sim_all          - Run all testbenches"
	@echo "  make clean            - Clean build and VCD files"
	@echo "  make help             - Show this help message"
	@echo ""

# ============================================================
# FSM Testbench
# ============================================================
sim_fsm: $(BUILD_DIR)/fsm_tb
	@echo "[FSM] Running testbench..."
	$(VVP) $< -vcd
	@if [ -f fsm.vcd ]; then mv fsm.vcd $(VCD_DIR)/; echo "[FSM] VCD saved: $(VCD_DIR)/fsm.vcd"; fi
	@echo "[FSM] Done!"
	@echo ""

$(BUILD_DIR)/fsm_tb: fsm.v tb/fsm_tb.v
	@echo "[FSM] Compiling..."
	$(IVERILOG) $(VFLAGS) -o $@ $^

# ============================================================
# Calibration FSM Testbench
# ============================================================
sim_cal_fsm: $(BUILD_DIR)/cal_fsm_tb
	@echo "[CAL_FSM] Running testbench..."
	$(VVP) $< -vcd
	@if [ -f cal_fsm_tb.vcd ]; then mv cal_fsm_tb.vcd $(VCD_DIR)/; echo "[CAL_FSM] VCD saved: $(VCD_DIR)/cal_fsm_tb.vcd"; fi
	@echo "[CAL_FSM] Done!"
	@echo ""

$(BUILD_DIR)/cal_fsm_tb: cal_fsm_board.v cal_fsm_counter.v tb/cal_fsm_tb.v
	@echo "[CAL_FSM] Compiling..."
	$(IVERILOG) $(VFLAGS) -o $@ $^

# ============================================================
# Full System Top-Level Testbench
# ============================================================
sim_full_top: $(BUILD_DIR)/tb_full_system_top
	@echo "[TOP] Running testbench..."
	$(VVP) $< 
	@if [ -f full_system_top.vcd ]; then mv full_system_top.vcd $(VCD_DIR)/; fi
	@if [ -f tb_full_system_top.vcd ]; then mv tb_full_system_top.vcd $(VCD_DIR)/; fi
	@if [ -f $(VCD_DIR)/tb_full_system_top.vcd ]; then echo "[TOP] VCD saved: $(VCD_DIR)/tb_full_system_top.vcd"; fi
	@if [ -f $(VCD_DIR)/full_system_top.vcd ]; then echo "[TOP] VCD saved: $(VCD_DIR)/full_system_top.vcd"; fi
	@echo "[TOP] Done!"
	@echo ""

$(BUILD_DIR)/tb_full_system_top: full_system_top.v fsm.v timer_top_ce.v timer_top.v prescaler.v counter_10bits.v \
								 cal_fsm_board.v cal_fsm_counter.v \
								 Clock_gating_Top_level.v clock_gating_ADC.v Clock_gating_UART.v clock_gating_Cond.v \
                                 adc_logic_calibrated.v uart_module.v tb/tb_full_system_top.v
	@echo "[TOP] Compiling..."
	$(IVERILOG) $(VFLAGS) -o $@ $^

# ============================================================
# UART Module Testbench
# ============================================================
sim_uart: $(BUILD_DIR)/uart_module_tb
	@echo "[UART] Running testbench..."
	$(VVP) $< -vcd
	@if [ -f uart_module_tb.vcd ]; then mv uart_module_tb.vcd $(VCD_DIR)/; echo "[UART] VCD saved: $(VCD_DIR)/uart_module_tb.vcd"; fi
	@echo "[UART] Done!"
	@echo ""

$(BUILD_DIR)/uart_module_tb: uart_module.v tb/uart_module_tb.v
	@echo "[UART] Compiling..."
	$(IVERILOG) $(VFLAGS) -o $@ $^

# ============================================================
# Timer Top Testbench
# ============================================================
sim_timer: $(BUILD_DIR)/tb_timer_top
	@echo "[TIMER] Running testbench..."
	$(VVP) $< -vcd
	@if [ -f tb_timer_top.vcd ]; then mv tb_timer_top.vcd $(VCD_DIR)/; echo "[TIMER] VCD saved: $(VCD_DIR)/tb_timer_top.vcd"; fi
	@echo "[TIMER] Done!"
	@echo ""

$(BUILD_DIR)/tb_timer_top: timer_top.v prescaler.v counter_10bits.v tb/tb_timer_top.v
	@echo "[TIMER] Compiling..."
	$(IVERILOG) $(VFLAGS) -o $@ $^

# ============================================================
# Timer Top CE Testbench
# ============================================================
sim_timer_ce: $(BUILD_DIR)/tb_timer_top_ce
	@echo "[TIMER_CE] Running testbench..."
	$(VVP) $< -vcd
	@if [ -f tb_timer_top_ce.vcd ]; then mv tb_timer_top_ce.vcd $(VCD_DIR)/; echo "[TIMER_CE] VCD saved: $(VCD_DIR)/tb_timer_top_ce.vcd"; fi
	@echo "[TIMER_CE] Done!"
	@echo ""

$(BUILD_DIR)/tb_timer_top_ce: timer_top_ce.v tb/tb_timer_top_ce.v
	@echo "[TIMER_CE] Compiling..."
	$(IVERILOG) $(VFLAGS) -o $@ $^

# ============================================================
# ADC Logic Testbench
# ============================================================
sim_adc: $(BUILD_DIR)/tb_adc_logic
	@echo "[ADC] Running testbench..."
	$(VVP) $< -vcd
	@if [ -f tb_adc_logic.vcd ]; then mv tb_adc_logic.vcd $(VCD_DIR)/; echo "[ADC] VCD saved: $(VCD_DIR)/tb_adc_logic.vcd"; fi
	@echo "[ADC] Done!"
	@echo ""

$(BUILD_DIR)/tb_adc_logic: adc_logic.v tb/tb_adc_logic.v
	@echo "[ADC] Compiling..."
	$(IVERILOG) $(VFLAGS) -o $@ $^

# ============================================================
# Calibrated ADC Logic Testbench
# ============================================================
sim_adc_cal: $(BUILD_DIR)/tb_adc_logic_calibrated
	@echo "[ADC_CAL] Running testbench..."
	$(VVP) $< -vcd
	@if [ -f tb_adc_logic_calibrated.vcd ]; then mv tb_adc_logic_calibrated.vcd $(VCD_DIR)/; echo "[ADC_CAL] VCD saved: $(VCD_DIR)/tb_adc_logic_calibrated.vcd"; fi
	@echo "[ADC_CAL] Done!"
	@echo ""

$(BUILD_DIR)/tb_adc_logic_calibrated: adc_logic_calibrated.v tb/tb_adc_logic_calibrated.v
	@echo "[ADC_CAL] Compiling..."
	$(IVERILOG) $(VFLAGS) -o $@ $^

# ============================================================
# Clock Gating Testbenches
# ============================================================
sim_clk_gating: $(BUILD_DIR)/Clock_gating_TB $(BUILD_DIR)/clock_gating_adc_TB $(BUILD_DIR)/clock_gating_uart_TB
	@echo "[CLK_GATING_TOP] Running testbench..."
	$(VVP) $(BUILD_DIR)/Clock_gating_TB -vcd
	@if [ -f Clock_gating_TB.vcd ]; then mv Clock_gating_TB.vcd $(VCD_DIR)/; echo "[CLK_GATING_TOP] VCD saved: $(VCD_DIR)/Clock_gating_TB.vcd"; fi
	@echo "[CLK_GATING_TOP] Done!"
	@echo ""
	@echo "[CLK_GATING_ADC] Running testbench..."
	$(VVP) $(BUILD_DIR)/clock_gating_adc_TB -vcd
	@if [ -f clock_gating_adc_TB.vcd ]; then mv clock_gating_adc_TB.vcd $(VCD_DIR)/; echo "[CLK_GATING_ADC] VCD saved: $(VCD_DIR)/clock_gating_adc_TB.vcd"; fi
	@echo "[CLK_GATING_ADC] Done!"
	@echo ""
	@echo "[CLK_GATING_UART] Running testbench..."
	$(VVP) $(BUILD_DIR)/clock_gating_uart_TB -vcd
	@if [ -f clock_gating_uart_TB.vcd ]; then mv clock_gating_uart_TB.vcd $(VCD_DIR)/; echo "[CLK_GATING_UART] VCD saved: $(VCD_DIR)/clock_gating_uart_TB.vcd"; fi
	@echo "[CLK_GATING_UART] Done!"
	@echo ""

$(BUILD_DIR)/Clock_gating_TB: Clock_gating_Top_level.v clock_gating_ADC.v Clock_gating_UART.v clock_gating_Cond.v tb/Clock_gating_TB.v
	@echo "[CLK_GATING_TOP] Compiling..."
	$(IVERILOG) $(VFLAGS) -o $@ $^

$(BUILD_DIR)/clock_gating_adc_TB: clock_gating_ADC.v tb/clock_gating_adc_TB.v
	@echo "[CLK_GATING_ADC] Compiling..."
	$(IVERILOG) $(VFLAGS) -o $@ $^

$(BUILD_DIR)/clock_gating_uart_TB: Clock_gating_UART.v tb/clock_gating_uart_TB.v
	@echo "[CLK_GATING_UART] Compiling..."
	$(IVERILOG) $(VFLAGS) -o $@ $^

# ============================================================
# Counter 10-Bit Testbench
# ============================================================
sim_counter: $(BUILD_DIR)/tb_counter_test
	@echo "[COUNTER] Running testbench..."
	$(VVP) $< -vcd
	@if [ -f tb_counter_test.vcd ]; then mv tb_counter_test.vcd $(VCD_DIR)/; echo "[COUNTER] VCD saved: $(VCD_DIR)/tb_counter_test.vcd"; fi
	@echo "[COUNTER] Done!"
	@echo ""

$(BUILD_DIR)/tb_counter_test: counter_10bits.v tb/tb_counter_test.v
	@echo "[COUNTER] Compiling..."
	$(IVERILOG) $(VFLAGS) -o $@ $^

# ============================================================
# Calibration FSM Counter Testbench
# ============================================================
sim_cal_counter: $(BUILD_DIR)/counter_tb
	@echo "[CAL_COUNTER] Running testbench..."
	$(VVP) $< -vcd
	@if [ -f counter_tb.vcd ]; then mv counter_tb.vcd $(VCD_DIR)/; echo "[CAL_COUNTER] VCD saved: $(VCD_DIR)/counter_tb.vcd"; fi
	@echo "[CAL_COUNTER] Done!"
	@echo ""

$(BUILD_DIR)/counter_tb: cal_fsm_counter.v tb/counter_tb.v
	@echo "[CAL_COUNTER] Compiling..."
	$(IVERILOG) $(VFLAGS) -o $@ $^

# ============================================================
# Prescaler Testbench
# ============================================================
sim_prescaler: $(BUILD_DIR)/tb_prescaler
	@echo "[PRESCALER] Running testbench..."
	$(VVP) $< -vcd
	@if [ -f tb_prescaler.vcd ]; then mv tb_prescaler.vcd $(VCD_DIR)/; echo "[PRESCALER] VCD saved: $(VCD_DIR)/tb_prescaler.vcd"; fi
	@echo "[PRESCALER] Done!"
	@echo ""

$(BUILD_DIR)/tb_prescaler: prescaler.v tb/tb_prescaler.v
	@echo "[PRESCALER] Compiling..."
	$(IVERILOG) $(VFLAGS) -o $@ $^

# ============================================================
# Run all testbenches
# ============================================================
sim_all: sim_fsm sim_cal_fsm sim_uart sim_timer sim_timer_ce sim_prescaler sim_counter sim_adc sim_adc_cal sim_clk_gating sim_full_top
	@echo "=========================================="
	@echo "All testbenches completed!"
	@echo "VCD files saved in: $(VCD_DIR)/"
	@echo "=========================================="

# ============================================================
# Clean up
# ============================================================
clean:
	@echo "Cleaning build and VCD files..."
	rm -rf $(BUILD_DIR)
	rm -rf $(VCD_DIR)
	rm -f *.vcd
	@echo "Done!"


.PHONY: all clean sim_fsm sim_cal_fsm sim_full_top sim_uart sim_timer sim_timer_ce sim_prescaler sim_adc sim_adc_cal sim_clk_gating sim_counter sim_cal_counter help
