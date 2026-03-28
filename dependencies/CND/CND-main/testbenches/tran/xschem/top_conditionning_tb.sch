v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
B 2 -1960 -30 -1160 370 {flags=graph
y1=0
y2=2
ypos1=0.1
ypos2=2.1
divy=5
subdivy=1
unity=1
x1=0
x2=3e-05
divx=5
subdivx=1
xlabmag=1.0
ylabmag=1.0
node="select0
select1
select2
select3
select_cal
select_sen
compare_result
amplifier_en_output
clk
reset_n"
color="4 9 6 5 8 9 15 16 8 15"
dataset=-1
unitx=1
logx=0
logy=0
rainbow=0
digital=1
legend=1}
B 2 -1960 -430 -1160 -30 {flags=graph
y1=0.096996196
y2=0.10353931
ypos1=0
ypos2=2
divy=5
subdivy=1
unity=1
x1=0
x2=3e-05
divx=5
subdivx=1
xlabmag=1.0
ylabmag=1.0
dataset=-1
unitx=1
logx=0
logy=0
color=15
node=x2.vref.t0}
N 670 -330 670 -300 {lab=GND}
N 670 -430 670 -390 {lab=VDD}
N 740 -330 740 -300 {lab=GND}
N 740 -430 740 -390 {lab=VDD_en}
N -280 -420 -280 -310 {lab=VDD}
N -280 -260 -280 -230 {lab=VBIAS}
N -280 -170 -280 -130 {lab=GND}
N -240 -310 -240 -260 {lab=VBIAS}
N -280 -260 -240 -260 {lab=VBIAS}
N -280 -280 -280 -260 {lab=VBIAS}
N 120 -410 190 -410 {lab=VDD}
N 120 -390 190 -390 {lab=VSS}
N 120 -370 190 -370 {lab=clk}
N 120 -350 190 -350 {lab=reset_n}
N 120 -330 190 -330 {lab=compare_result}
N 120 -230 190 -230 {lab=select0}
N 120 -210 190 -210 {lab=select1}
N 120 -190 190 -190 {lab=select2}
N 120 -170 190 -170 {lab=select3}
N 610 430 610 440 {lab=VSS}
N 120 -310 190 -310 {lab=VDD_en}
N 120 -290 190 -290 {lab=select_cal}
N 120 -270 190 -270 {lab=select_sen}
N 120 -250 190 -250 {lab=EN}
N 890 -390 890 -360 {lab=GND}
N 890 -490 890 -450 {lab=VSS}
N 1010 -370 1010 -340 {lab=GND}
N 1010 -470 1010 -430 {lab=IOVDD}
N -480 -430 -480 -320 {lab=IOVDD}
N -480 -270 -480 -240 {lab=VBIASH}
N -480 -180 -480 -140 {lab=GND}
N -440 -320 -440 -270 {lab=VBIASH}
N -480 -270 -440 -270 {lab=VBIASH}
N -480 -290 -480 -270 {lab=VBIASH}
N 1130 -370 1130 -340 {lab=GND}
N 1130 -470 1130 -430 {lab=VBG}
N 600 50 640 50 {lab=VSS}
N 600 70 640 70 {lab=IOVDD}
N 600 90 640 90 {lab=vamp2}
N 600 190 640 190 {lab=select_cal}
N 600 210 640 210 {lab=select_sen}
N 600 230 640 230 {lab=VBG}
N 600 250 640 250 {lab=VBIASH}
N 600 110 640 110 {lab=select0}
N 600 130 640 130 {lab=select1}
N 600 150 640 150 {lab=select2}
N 600 170 640 170 {lab=select3}
N 600 270 640 270 {lab=EN}
N 600 290 640 290 {lab=VBIAS}
N 600 310 640 310 {lab=VDD}
N 610 350 610 370 {lab=SENSOR}
N 600 350 610 350 {lab=SENSOR}
N 610 350 640 350 {lab=SENSOR}
N 600 330 640 330 {lab=compare_result}
C {vsource.sym} 670 -360 0 0 {name=VDD value=1.5 savecurrent=false}
C {lab_pin.sym} 670 -430 0 0 {name=p3 sig_type=std_logic lab=VDD}
C {gnd.sym} 670 -300 0 0 {name=l1 lab=GND}
C {code_shown.sym} 1300 -1020 0 0 {name=LIBS only_toplevel=false value="
.include /foss/designs/ignore/asic_template_new/SG13G2_ASIC-Design-Template/xspice/cal_fsm_board/cal_fsm_board.xspice
.lib cornerMOShv.lib mos_tt_mismatch
.lib cornerMOSlv.lib mos_tt_mismatch
.lib cornerRES.lib res_typ
.lib cornerCAP.lib cap_typ
.model ideal_res R (TC1=0 TC2=0) 
.options itl1=300       ; Increase DC iteration limit (helps convergence)
.options itl4=50        ; Increase transient iteration limit
.options method=gear    ; Sometimes faster than trapezoidal
.options reltol=1e-4    ; Looser tolerance (was likely 1e-6)
.options vntol=1e-5     ; Looser voltage tolerance
.options abstol=1e-10   ; Looser current tolerance
.options method=gear
.option klu
.option noinit               ; Suppress operating point printing

"}
C {vsource.sym} 740 -360 0 0 {name=Venable value=1.2 savecurrent=false}
C {lab_pin.sym} 740 -430 1 0 {name=p6 sig_type=std_logic lab=VDD_en}
C {gnd.sym} 740 -300 0 0 {name=l6 lab=GND}
C {code_shown.sym} 980 -780 0 0 {name=SIM_REF2 only_toplevel=false value="
** Simulate the referance **
.param wx=1u
.option rshunt=1e12
.control
save all
dc rsen 96 120 1
run
plot v96 vtemp vamp
plot vamp
.endc

"
spice_ignore=true}
C {code_shown.sym} -600 -1100 0 0 {name=SIM_REF3 only_toplevel=false value="
** Simulate the referance **
.include two_stage_instrumentation_amp.save
.param wx=1u
.option rshunt=1G
.control
save all
op
write two_stage_instrumentation_amp.raw
.endc

"
spice_ignore=true}
C {lab_pin.sym} -240 -260 0 1 {name=p4 sig_type=std_logic lab=VBIAS}
C {isource.sym} -280 -200 0 0 {name=I1 value=1u}
C {lab_pin.sym} -280 -420 0 0 {name=p7 sig_type=std_logic lab=VDD}
C {gnd.sym} -280 -130 0 1 {name=l2 lab=GND}
C {launcher.sym} 430 -120 0 0 {name=h4
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
C {devices/launcher.sym} 420 -50 0 0 {name=h2
descr="OP annotate" 
tclcommand="xschem annotate_op"
}
C {devices/code_shown.sym} 1960 -700 0 0 {name=NGSPICE_MC only_toplevel=true 
value="
//.param mm_ok=1
//.param mc_ok=1
.param temp=27
.option rshunt=1e12
.control
set ngbehavior=hsa
set ng_nomodcheck
let mc_runs = 100
let run = 0
set curplot=new
set scratch=$curplot
setplot $scratch
let vg=unitvec(mc_runs)
echo "" > mc_results.csv
***************** LOOP *********************
dowhile run < mc_runs
save all
tran 100n 30u
meas tran vmis find v(vamp2) at=1u
meas tran vreg find v(vamp2) at=29u
meas tran vref find v(x2.vref.t0) at=29u
print vmis vreg vref >> mc_results.csv
set run=$&run
set dt=$curplot
setplot $scratch
let out\{$run\}=\{$dt\}.vamp2
let Vg\{$run\}=\{$dt\}.time
setplot $dt
reset
let run=run+1 
end
***************** LOOP *********************

set nolegend
plot \{$scratch\}.allv vs \{$scratch\}.Vg1

.endc
"
}
C {sg13g2_pr/annotate_fet_params.sym} -210 -440 0 0 {name=annot1 ref=M1}
C {res.sym} 610 400 0 0 {name=Rsen
value=120
footprint=1206
device=resistor
m=1}
C {sg13g2_pr/sg13_lv_pmos.sym} -260 -310 0 1 {name=M1
l=0.5u
w=1u
ng=1
m=1
mm_ok=1
model=sg13_lv_pmos
spiceprefix=X
}
C {lab_pin.sym} 120 -410 0 0 {name=p2 lab=VDD}
C {lab_pin.sym} 120 -390 0 0 {name=p25 lab=VSS}
C {lab_pin.sym} 120 -370 0 0 {name=p26 lab=clk}
C {lab_pin.sym} 120 -350 0 0 {name=p27 lab=reset_n}
C {lab_pin.sym} 120 -230 0 0 {name=p28 lab=select0}
C {lab_pin.sym} 120 -210 0 0 {name=p29 lab=select1}
C {lab_pin.sym} 120 -190 0 0 {name=p30 lab=select2}
C {lab_pin.sym} 120 -170 0 0 {name=p31 lab=select3}
C {lab_pin.sym} 610 440 0 0 {name=p40 lab=VSS}
C {/foss/designs/ignore/asic_template_new/SG13G2_ASIC-Design-Template/xspice/cal_fsm_board/cal_fsm.sym} 210 -420 0 0 {name=X1}
C {lab_pin.sym} 120 -310 0 0 {name=p41 lab=VDD_en}
C {lab_pin.sym} 120 -290 0 0 {name=p42 lab=select_cal}
C {lab_pin.sym} 120 -270 0 0 {name=p43 lab=select_sen}
C {lab_pin.sym} 120 -250 0 0 {name=p44 lab=EN}
C {lab_pin.sym} 120 -330 0 0 {name=p48 lab=compare_result}
C {vsource.sym} 890 -420 0 0 {name=VSS value=0 savecurrent=false}
C {lab_pin.sym} 890 -490 0 0 {name=p54 sig_type=std_logic lab=VSS}
C {gnd.sym} 890 -360 0 0 {name=l9 lab=GND}
C {code_shown.sym} 1320 -560 0 0 {name=s2 only_toplevel=false value="

Vclk clk 0 pulse(0 1.5 0 100ns 100ns 0.5u 1u)
Vreset reset_n 0 pulse(1.5 0 1u 10ns 10ns 2u 300u)


"}
C {code_shown.sym} 1310 -440 0 0 {name=SIM_REF1 only_toplevel=false value="
//.include two_stage_instrumentation_amp.save
** Simulate the referance **
.param wx=1u
.option rshunt=1e12
.control
set ngbehavior=hsa
set ng_nomodcheck
//set num_threads=16         ; Match your CPU core count
save all
tran 100n 30u
plot vamp2 x2.vref.t0
plot x2.vamp.t0
//op
write top_conditionning_tb.raw
.endc

"
spice_ignore=true}
C {devices/launcher.sym} 440 -180 0 0 {name=h3
descr="Load waves" 
tclcommand="
xschem raw_read $netlist_dir/[file rootname [file tail [xschem get current_name]]].raw tran
xschem setprop rect 2 0 fullxzoom
"
}
C {vsource.sym} 1010 -400 0 0 {name=VDD1 value=3.3 savecurrent=false}
C {lab_pin.sym} 1010 -470 0 0 {name=p5 sig_type=std_logic lab=IOVDD}
C {gnd.sym} 1010 -340 0 0 {name=l10 lab=GND}
C {lab_pin.sym} -440 -270 0 1 {name=p22 sig_type=std_logic lab=VBIASH}
C {isource.sym} -480 -210 0 0 {name=I2 value=2u}
C {lab_pin.sym} -480 -430 0 0 {name=p52 sig_type=std_logic lab=IOVDD}
C {gnd.sym} -480 -140 0 1 {name=l13 lab=GND}
C {sg13g2_pr/sg13_hv_pmos.sym} -460 -320 0 1 {name=M2
l=0.5u
w=1u
ng=1
m=1
mm_ok=1
model=sg13_hv_pmos
spiceprefix=X
}
C {vsource.sym} 1130 -400 0 0 {name=Vbg value=1 savecurrent=false}
C {lab_pin.sym} 1130 -470 0 0 {name=p62 sig_type=std_logic lab=VBG}
C {gnd.sym} 1130 -340 0 0 {name=l15 lab=GND}
C {code_shown.sym} 680 -240 0 0 {name=s4 only_toplevel=false value="
.include /foss/designs/gdsspices/top_conditionning.spice
"
}
C {/foss/designs/auto_gen_sym/top_conditionning.sym} 660 40 0 0 {name=X2}
C {lab_pin.sym} 600 50 0 0 {name=p1 lab=VSS}
C {lab_pin.sym} 600 70 0 0 {name=p8 lab=IOVDD}
C {lab_pin.sym} 600 90 0 0 {name=p9 lab=vamp2}
C {lab_pin.sym} 600 230 0 0 {name=p16 lab=VBG}
C {lab_pin.sym} 600 250 0 0 {name=p17 lab=VBIASH}
C {lab_pin.sym} 600 110 0 0 {name=p10 lab=select0}
C {lab_pin.sym} 600 130 0 0 {name=p11 lab=select1}
C {lab_pin.sym} 600 150 0 0 {name=p12 lab=select2}
C {lab_pin.sym} 600 170 0 0 {name=p13 lab=select3}
C {lab_pin.sym} 600 270 0 0 {name=p18 lab=EN}
C {lab_pin.sym} 600 290 0 0 {name=p19 lab=VBIAS}
C {lab_pin.sym} 600 310 0 0 {name=p20 lab=VDD}
C {lab_pin.sym} 600 350 0 0 {name=p21 lab=SENSOR}
C {lab_pin.sym} 600 190 0 0 {name=p14 lab=select_cal}
C {lab_pin.sym} 600 210 0 0 {name=p15 lab=select_sen}
C {lab_pin.sym} 600 330 0 0 {name=p23 lab=compare_result}
