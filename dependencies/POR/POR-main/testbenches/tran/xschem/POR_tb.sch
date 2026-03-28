v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 0 -60 0 -40 {lab=VDD1v2}
N 0 40 0 60 {lab=VSS}
N 100 0 130 0 {lab=RESET}
N -130 0 -100 0 {lab=VBIAS_POR}
N 360 -240 400 -240 {lab=RAMP_REF}
N 360 -220 400 -220 {lab=VBIAS_ADC_CMP}
N 360 -200 400 -200 {lab=IOVDD}
N 360 -180 400 -180 {lab=VBIASH}
N 360 -160 400 -160 {lab=VBIAS}
N 360 -140 400 -140 {lab=VDD}
N 360 -120 400 -120 {lab=VSS}
N 360 -100 400 -100 {lab=VBIAS_POR}
C {/foss/designs/xschemas/POR.sym} 0 0 0 0 {name=XPOR1}
C {lab_pin.sym} 0 -60 0 1 {name=p1 lab=VDD1v2}
C {lab_pin.sym} 130 0 0 1 {name=p2 lab=RESET}
C {lab_pin.sym} 0 60 0 1 {name=p4 lab=VSS}
C {code_shown.sym} -590 -220 0 0 {name=s1 only_toplevel=false value="
VDDIO IOVDD 0 3.3
VDD VDD 0 1.5
VDD1v2 VDD1v2 0 pulse(0 1.2 1u 10n 3u 5u 7u)
VSS VSS 0 0 
"}
C {/foss/designs/auto_gen_sym/Current_Bank.sym} 420 -250 0 0 {name=X2}
C {lab_pin.sym} 360 -240 0 0 {name=p5 lab=RAMP_REF}
C {lab_pin.sym} 360 -220 0 0 {name=p6 lab=VBIAS_ADC_CMP}
C {lab_pin.sym} 360 -200 0 0 {name=p7 lab=IOVDD}
C {lab_pin.sym} 360 -180 0 0 {name=p8 lab=VBIASH}
C {lab_pin.sym} 360 -160 0 0 {name=p9 lab=VBIAS}
C {lab_pin.sym} 360 -140 0 0 {name=p10 lab=VDD}
C {lab_pin.sym} 360 -120 0 0 {name=p11 lab=VSS}
C {lab_pin.sym} 360 -100 0 0 {name=p12 lab=VBIAS_POR}
C {lab_pin.sym} -130 0 0 0 {name=p3 lab=VBIAS_POR}
C {simulator_commands_shown.sym} -220 -330 0 0 {
name=Libs_Ngspice
simulator=ngspice
only_toplevel=false
value="
.lib cornerMOSlv.lib mos_tt
.lib cornerMOShv.lib mos_tt
.lib cornerHBT.lib hbt_typ
.lib cornerRES.lib res_typ
.lib cornerCAP.lib cap_typ
"
      }
C {code_shown.sym} -590 120 0 0 {name=s2 only_toplevel=false value="
.option rshunt=1e12
.control
save all
tran 1n 20u

plot VDD1v2 xpor1.net1 RESET
plot @n.xpor1.xm1.nsg13_lv_pmos[ids]

.endc

"
}
C {code_shown.sym} 260 -30 0 0 {name=s3 only_toplevel=false value="
.include /foss/designs/gdsspices/Current_Bank.spice
.include POR_tb.save

"}
C {launcher.sym} -830 -160 0 0 {name=h4
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
C {devices/launcher.sym} -830 -90 0 0 {name=h2
descr="OP annotate" 
tclcommand="xschem annotate_op"
}
C {devices/launcher.sym} -810 -220 0 0 {name=h3
descr="Load waves" 
tclcommand="
xschem raw_read $netlist_dir/[file rootname [file tail [xschem get current_name]]].raw tran
xschem setprop rect 2 0 fullxzoom
"
}
C {code_shown.sym} -180 130 0 0 {name=s4 only_toplevel=false value="
.option rshunt=1e12
.control
save all
op
write POR_tb.raw

.endc

"
spice_ignore=true}
