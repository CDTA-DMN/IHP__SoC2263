v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 150 -40 200 -40 {lab=VDD}
N 150 -20 200 -20 {lab=VSS}
N 150 0 200 0 {lab=VRAMP}
N 150 20 200 20 {lab=VMEAS}
N 150 40 200 40 {lab=VCMP}
N 150 60 200 60 {lab=VDD1v2}
N -200 -40 -150 -40 {lab=RAMP_EN}
N -200 -20 -150 -20 {lab=RAMP_REF}
N -200 0 -150 0 {lab=RESET}
N -200 20 -150 20 {lab=SEL_MEAS}
N -200 40 -150 40 {lab=VBIAS_ADC_CMP}
N -200 60 -150 60 {lab=SEL_CAL}
N -190 -270 -150 -270 {lab=RAMP_REF}
N -190 -250 -150 -250 {lab=VBIAS_ADC_CMP}
N -190 -230 -150 -230 {lab=IOVDD}
N -190 -210 -150 -210 {lab=VBIASH}
N -190 -190 -150 -190 {lab=VBIAS}
N -190 -170 -150 -170 {lab=VDD}
N -190 -150 -150 -150 {lab=VSS}
C {/foss/designs/xschemas/aymen/adc_top_analog.sym} 0 10 0 0 {name=x1}
C {lab_pin.sym} 200 -40 0 1 {name=p1 lab=VDD}
C {lab_pin.sym} 200 -20 0 1 {name=p2 lab=VSS}
C {lab_pin.sym} 200 0 0 1 {name=p3 lab=VRAMP}
C {lab_pin.sym} -200 -40 0 0 {name=p4 lab=RAMP_EN}
C {lab_pin.sym} -200 -20 0 0 {name=p5 lab=RAMP_REF}
C {lab_pin.sym} -200 0 0 0 {name=p6 lab=RESET}
C {lab_pin.sym} -200 20 0 0 {name=p7 lab=SEL_MEAS}
C {lab_pin.sym} 200 20 0 1 {name=p8 lab=VMEAS}
C {lab_pin.sym} 200 40 0 1 {name=p9 lab=VCMP}
C {lab_pin.sym} 200 60 0 1 {name=p10 lab=VDD1v2}
C {lab_pin.sym} -200 60 0 0 {name=p12 lab=SEL_CAL}
C {/foss/designs/auto_gen_sym/Current_Bank.sym} -130 -280 0 0 {name=X2}
C {code_shown.sym} 220 -250 0 0 {name=s1 only_toplevel=false value="
VDDIO IOVDD 0 3.3
VDD VDD 0 1.5
VSS VSS 0 0 
Vreset RESET 0 pulse(0 1.5 6u 10n 10n 2u 500u)
Ven ramp_en 0 pulse(1.5 0 6u 10n 10n 2u 500u)
VSEL_CAL SEL_CAL 0 1.2
VSEL_SEN SEL_MEAS 0 0
Vmeas VMEAS 0 0.5
VDD1v2 VDD1v2 0 1.2
"}
C {simulator_commands_shown.sym} -995 -355 0 0 {name=MC_SIM
simulator=ngspice
only_toplevel=false 
value="
.option klu
.control
//set num_threads 8
save all
tran 100n 360u
meas tran maxa WHEN vramp=1.2 rise=1
//print maxa >> simulations/mc_ramp_res_cur.csv
let vmax = maxa*1e6 - 9
echo results_save_begin
print vmax
echo results_save_end

.endc
"
}
C {code_shown.sym} -1010 0 0 0 {name=MC_SETTINGS
only_toplevel=false
value="
**nr_workers=4
**nr_mc_sims=100

**results_plot_begin
**vmax
**results_plot_end
"
}
C {launcher.sym} -900 245 0 0 {name=h1
descr=SimulatePARALLEL
tclcommand="
# Setup the default simulation commands if not already set up
# for example by already launched simulations.
set_sim_defaults
puts $sim(spice,1,cmd) 

# Change the Xyce command. In the spice category there are currently
# 5 commands (0, 1, 2, 3, 4). Command 3 is the Xyce batch
# you can get the number by querying $sim(spice,n)
set sim(spice,1,cmd) \{ngspice  \\"$N\\" -a\}

# change the simulator to be used (Xyce)
set sim(spice,default) 0

# Create FET and BIP .save file
exec mkdir -p $netlist_dir
write_data [save_params] $netlist_dir/[file rootname [file tail [xschem get current_name]]].save

# run netlist and simulation
xschem netlist
exec python3 $\{PDK_ROOT\}/$\{PDK\}/libs.tech/xschem/sg13g2_tests/ngspice_parallel_mc.py [file tail [xschem get current_name]]
"
spice_ignore=true}
C {code_shown.sym} -360 -440 0 0 {name=s3 only_toplevel=false value="
.include /foss/designs/gdsspices/Current_Bank.spice
.include /foss/designs/gdsspices/ota_lv_gmid_comparator.spice
.include /foss/designs/gdsspices/ramp_generator.spice

"}
C {launcher.sym} -1270 -50 0 0 {name=h4
descr=SimulateNGSPICE
tclcommand="
# Setup the default simulation commands if not already set up
# for example by already launched simulations.
set_sim_defaults
puts $sim(spice,1,cmd) 

# Change the Xyce command. In the spice category there are currently
# 5 commands (0, 1, 2, 3, 4). Command 3 is the Xyce batch
# you can get the number by querying $sim(spice,n)
set sim(spice,1,cmd) \{ngspice -j 8  \\"$N\\" -a\}

# change the simulator to be used (Xyce)
set sim(spice,default) 0

# Create FET and BIP .save file
exec mkdir -p $netlist_dir
write_data [save_params] $netlist_dir/[file rootname [file tail [xschem get current_name]]].save

# run netlist and simulation
xschem netlist
simulate
"}
C {devices/launcher.sym} -1280 20 0 0 {name=h2
descr="OP annotate" 
tclcommand="xschem annotate_op"
}
C {devices/launcher.sym} -1260 -110 0 0 {name=h3
descr="Load waves" 
tclcommand="
xschem raw_read $netlist_dir/[file rootname [file tail [xschem get current_name]]].raw tran
xschem setprop rect 2 0 fullxzoom
"
}
C {simulator_commands_shown.sym} -1440 -400 0 0 {
name=Libs_Ngspice
simulator=ngspice
only_toplevel=false
value="
.lib cornerMOSlv.lib mos_tt_mismatch
.lib cornerMOShv.lib mos_tt_mismatch
.lib cornerHBT.lib hbt_typ
.lib cornerRES.lib res_typ
.lib cornerCAP.lib cap_typ
"
      }
C {lab_pin.sym} -190 -270 0 0 {name=p13 lab=RAMP_REF}
C {lab_pin.sym} -190 -250 0 0 {name=p14 lab=VBIAS_ADC_CMP}
C {lab_pin.sym} -190 -230 0 0 {name=p15 lab=IOVDD}
C {lab_pin.sym} -190 -210 0 0 {name=p16 lab=VBIASH}
C {lab_pin.sym} -190 -190 0 0 {name=p17 lab=VBIAS}
C {lab_pin.sym} -190 -170 0 0 {name=p18 lab=VDD}
C {lab_pin.sym} -190 -150 0 0 {name=p19 lab=VSS}
C {lab_pin.sym} -200 40 0 0 {name=p11 lab=VBIAS_ADC_CMP}
