v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N -0 -60 -0 -30 {lab=VDD}
N -10 30 -10 60 {lab=CLK_BIAS}
N -30 60 -10 60 {lab=CLK_BIAS}
N -0 30 -0 90 {lab=VSS}
N 10 30 10 60 {lab=clk}
N 10 60 30 60 {lab=clk}
N -290 -260 -290 -230 {lab=VDD}
N -200 -260 -200 -230 {lab=VSS}
N -200 -170 -200 -130 {lab=0}
N -290 -170 -290 -130 {lab=0}
N 270 30 310 30 {lab=CLK_BIAS}
N 270 50 310 50 {lab=RAMP_REF}
N 270 70 310 70 {lab=VBIAS_ADC_CMP}
N 270 90 310 90 {lab=IOVDD}
N 270 110 310 110 {lab=VBIASH}
N 270 130 310 130 {lab=VBIAS}
N 270 150 310 150 {lab=VDD}
N 270 170 310 170 {lab=VSS}
N 270 190 310 190 {lab=VBIAS_POR}
N -440 -270 -440 -240 {lab=IOVDD}
N -440 -180 -440 -140 {lab=0}
C {simulator_commands_shown.sym} 350 -400 0 0 {
name=Libs_Ngspice
simulator=ngspice
only_toplevel=true
value="
.include sg13g2_stdcell.spice

.lib cornerMOSlv.lib mos_tt_mismatch
.lib cornerMOShv.lib mos_tt
.lib cornerHBT.lib hbt_typ
.lib cornerRES.lib res_typ
.lib cornerCAP.lib cap_typ
"
      }
C {code_shown.sym} -940 -270 0 0 {name=SIM
simulator = NGSPICE
only_toplevel=true 
value="
.include clk_1MHz_tb.save
.control
save all
//op
//write clk_1MHz_tb.raw
tran 10n 16u
meas tran t1 when v(clk)=0.6 rise=5
meas tran t2 when v(clk)=0.6 rise=6
print 1/(t2-t1)
plot clk
.endc

"
}
C {lab_pin.sym} 0 -60 0 0 {name=p2 sig_type=std_logic lab=VDD}
C {lab_pin.sym} 0 90 0 0 {name=p6 sig_type=std_logic lab=VSS}
C {lab_pin.sym} 30 60 0 1 {name=p7 sig_type=std_logic lab=clk}
C {vsource.sym} -290 -200 0 0 {name=V1 value=1.2 savecurrent=false}
C {vsource.sym} -200 -200 0 0 {name=V2 value=0 savecurrent=false}
C {lab_pin.sym} -290 -260 0 0 {name=p8 sig_type=std_logic lab=VDD}
C {lab_pin.sym} -200 -260 0 0 {name=p9 sig_type=std_logic lab=VSS}
C {lab_pin.sym} -200 -130 0 0 {name=p10 sig_type=std_logic lab=0}
C {lab_pin.sym} -290 -130 0 0 {name=p11 sig_type=std_logic lab=0}
C {launcher.sym} -40 -360 0 0 {name=h4
descr=SimulateNGSPICE
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
simulate
"}
C {devices/launcher.sym} -40 -310 0 0 {name=h2
descr="OP annotate" 
tclcommand="xschem annotate_op"
}
C {/foss/designs/xschemas/clk_1MHz_gds.sym} 0 0 0 0 {name=XCLK1
}
C {/foss/designs/xschemas/clk_1MHz.sym} 250 -90 0 0 {name=XCLK2
spice_ignore=true}
C {simulator_commands_shown.sym} 410 -120 0 0 {
name=Libs_Ngspice1
simulator=ngspice
only_toplevel=true
value="
.include /foss/designs/gdsspices/clk_1MHz.spice
.include /foss/designs/gdsspices/Current_Bank.spice
"
      }
C {simulator_commands_shown.sym} -1450 -310 0 0 {name=Simulator2
simulator=ngspice
only_toplevel=false 
value=".param mm_ok=1
.param mc_ok=1
.param temp=27

.control

let mc_runs = 5
let run = 0
set curplot=new
set scratch=$curplot
setplot $scratch
let time=unitvec(mc_runs)
let out=unitvec(mc_runs)
//let tempv=0
***************** LOOP *********************
dowhile run < mc_runs
save all
tran 100n 20u
meas tran t1 when v(clk)=0.6 rise=5
meas tran t2 when v(clk)=0.6 rise=6
let tempv = 1/(t2 - t1)
set run=$&run
set dt=$curplot
setplot $scratch
setplot $dt
print tempv
let out[run] = \{$dt\}.clk
let time[run] = \{$run\}
reset
let run=run+1 
end
***************** LOOP *********************

.endc
"
spice_ignore=true}
C {code_shown.sym} -750 -570 0 0 {name=SIM1
simulator = NGSPICE
only_toplevel=true 
value="
.param pwr=1.08
.option rshunt=1e12

"
}
C {devices/code_shown.sym} -2040 -380 0 0 {name=NGSPICE_MC only_toplevel=true 
value="
//.param mm_ok=1
//.param mc_ok=1
.param temp=27

.control
let mc_runs = 50
let run = 0
set noprint
set curplot=new
set scratch=$curplot
setplot $scratch
let allplots = unitvec(mc_runs)
let runs_vec = unitvec(mc_runs)

***************** LOOP *********************
dowhile run < mc_runs
let progress = $&run/$&mc_runs*100
echo progress: $&progress %
save clk
tran 12n 16u
meas tran t1 when v(clk)=0.6 rise=13
meas tran t2 when v(clk)=0.6 rise=14
set run=$&run
set dt=$curplot
setplot $scratch
let runs_vec[run] = run
let allplots[run] = 1 / (\{$dt\}.t2 - \{$dt\}.t1)
setplot $dt
reset
let run=run+1 
end
***************** LOOP *********************

set nolegend
let filtred = unitvec(mc_runs)
let curvec = \{$scratch\}.allplots
let i=0
let j=0

while i < $&mc_runs
  if curvec[i] ne 1
    let filtred[j]=curvec[i]
    let j = j+1
  end
 let i = i+1
end
     
plot filtred[0,j-1] vs \{$scratch\}.runs_vec

.endc
"
spice_ignore=true}
C {lab_pin.sym} 270 30 0 0 {name=p1 lab=CLK_BIAS}
C {lab_pin.sym} 270 50 0 0 {name=p3 lab=RAMP_REF}
C {lab_pin.sym} 270 70 0 0 {name=p5 lab=VBIAS_ADC_CMP}
C {lab_pin.sym} 270 90 0 0 {name=p12 lab=IOVDD}
C {lab_pin.sym} 270 110 0 0 {name=p13 lab=VBIASH}
C {lab_pin.sym} 270 130 0 0 {name=p14 lab=VBIAS}
C {lab_pin.sym} 270 150 0 0 {name=p15 lab=VDD}
C {lab_pin.sym} 270 170 0 0 {name=p16 lab=VSS}
C {lab_pin.sym} 270 190 0 0 {name=p17 lab=VBIAS_POR}
C {/foss/designs/auto_gen_sym/Current_Bank.sym} 330 20 0 0 {name=X1}
C {lab_pin.sym} -30 60 0 0 {name=p4 lab=CLK_BIAS}
C {vsource.sym} -440 -210 0 0 {name=V3 value=3.3 savecurrent=false}
C {lab_pin.sym} -440 -270 0 0 {name=p18 sig_type=std_logic lab=IOVDD}
C {lab_pin.sym} -440 -140 0 0 {name=p19 sig_type=std_logic lab=0}
