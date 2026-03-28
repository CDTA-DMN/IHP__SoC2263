# Temperature Sensor Node - Digital Testbenches

## Quick Start

### Run all testbenches:
```bash
make sim_all
```

### Run individual testbenches:
```bash
make sim_fsm          # FSM state machine
make sim_uart         # UART module
make sim_timer        # 10-minute timer
make sim_adc          # ADC logic (single-slope converter)
make sim_clk_gating   # Clock gating logic
make sim_full_top     # Complete system integration
```

### Clean build files:
```bash
make clean
```

### View help:
```bash
make help
```

## Requirements

- **Icarus Verilog** (`iverilog` and `vvp`)
  - Ubuntu/Debian: `sudo apt-get install iverilog`
  - macOS: `brew install iverilog`
  - Or download from: http://iverilog.icarus.com/

- **GTKWave** (optional, for waveform viewing)
  - Ubuntu/Debian: `sudo apt-get install gtkwave`
  - macOS: `brew install gtkwave`

## Testbench Details

### FSM Testbench (`make sim_fsm`)
- **Duration**: ~150 µs
- **Coverage**: 
  - Wake-up trigger
  - 2-cycle conditioner wait
  - ADC conversion initiation
  - UART transmission
  - Return to IDLE
  - Second cycle verification
- **Output**: `vcd/fsm_tb.vcd`

### UART Testbench (`make sim_uart`)
- **Duration**: ~2.2 ms
- **Coverage**: 
  - Active-low reset
  - Single byte transmission (0x8E)
  - Baud rate verification (9600 baud)
  - TX completion detection
- **Output**: `vcd/uart_module_tb.vcd`

### Timer Testbench (`make sim_timer`)
- **Duration**: ~25 µs
- **Coverage**: 
  - Correct 1 MHz clock input
  - Prescaler (1 MHz → 1 Hz)
  - Counter reset
  - External trigger response
  - Wakeup signal assertion
- **Output**: `vcd/tb_timer_top.vcd`

### ADC Logic Testbench (`make sim_adc`)
- **Duration**: ~5.8 ms (simulated)
- **Coverage**: 
  - Complete wake-up sequence
  - FSM state machine
  - ADC logic integration
  - UART transmission
  - Clock gating behavior
  - Two full cycles
- **Output**: `vcd/tb_full_system_top.vcd`
- **Duration**: Variable (depends on comparator input)
- **Coverage**: 
  - IDLE state
  - CONVERT state (counter increment)
  - LATCH state (result capture)
  - Comparator output handling
  - Sample enable control
- **Output**: `vcd/tb_adc_logic.vcd`
- **Note**: Tests single-slope ADC state machine with external comparator stimulus

### Clock Gating Testbench (`make sim_clk_gating`)
- **Duration**: Variable
- **Coverage**: 
  - ADC clock gate enable/disable
  - UART clock gate enable/disable
  - Async active-low reset
  - Latch behavior
  - AND-gate output (clock quality)
- **Output**: `vcd/Clock_gating_TB.vcd`
- **Note**: Verifies proper clock gating to reduce power consumption

## Viewing Waveforms

After running any testbench, open the generated VCD file:

```bash
gtkwave vcd/fsm_tb.vcd &
gtkwave vcd/tb_full_system_top.vcd &
```

## Directory Structure

```
top_level_digital_files/
├── Makefile                    # This file
├── README.md                   # Documentation
├── build/                      # Compiled executables
├── vcd/                        # Generated waveform files
├── fsm.v
├── uart_module.v
├── timer_top.v
├── adc_logic.v
├── full_system_top.v
└── tb/
    ├── fsm_tb.v
    ├── uart_module_tb.v
    ├── tb_full_system_top.v
    └── ...
```

## Troubleshooting

### "command not found: iverilog"
Install Icarus Verilog (see Requirements section)

### VCD files not generated
- Check that `-vcd` flag is present in testbench code
- Verify `$dumpfile` and `$dumpvars` statements exist
- Check file permissions in the directory

### Simulation crashes
- Check for syntax errors in modified files
- Verify port connections in testbenches
- Review error messages from `iverilog`

## CI/CD Integration

To use in automated testing:

```bash
#!/bin/bash
cd top_level_digital_files
make clean
make sim_all
if [ $? -eq 0 ]; then
  echo "All testbenches passed!"
  exit 0
else
  echo "Testbench failures detected!"
  exit 1
fi
```

## Notes

- All simulations use **asynchronous active-low reset** 
- Clock frequency: **1 MHz** for all modules
- UART baud rate: **9600** at 1 MHz clock
- Timer wakeup: **10 minutes** (600 seconds)
- All timing in **nanoseconds**

## Performance Tips

- Run `make sim_fsm` first for quick validation
- Use `make sim_uart` and `make sim_timer` for unit testing
- Use `make sim_full_top` for integration testing
- Check VCD files only for failing tests (reduces file I/O)

---
Last updated: March 15, 2026
