v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 200 70 200 80 {lab=Pbulk}
N 200 120 200 130 {lab=Nbulk}
N 180 40 180 70 {lab=VDD}
N 180 130 180 150 {lab=VSS}
N 130 100 150 100 {lab=#net1}
N 80 40 80 70 {lab=VDD}
N 80 130 80 150 {lab=VSS}
N -180 70 -180 80 {lab=Pbulk}
N -180 120 -180 130 {lab=Nbulk}
N -200 130 -200 170 {lab=cpy_n}
N -250 100 -230 100 {lab=VOUT2}
N -200 10 -200 70 {lab=#net2}
N -380 150 -380 170 {lab=ref_n}
N -340 -20 -240 -20 {lab=I1u}
N -340 200 -290 200 {lab=ref_n}
N -290 150 -290 200 {lab=ref_n}
N -380 150 -290 150 {lab=ref_n}
N -290 200 -240 200 {lab=ref_n}
N -50 100 50 100 {lab=#net3}
N 230 100 280 100 {lab=VOUT2}
N 330 70 330 80 {lab=Pbulk}
N 330 120 330 130 {lab=Nbulk}
N 310 40 310 70 {lab=VDD}
N 310 130 310 150 {lab=VSS}
N 360 100 390 100 {lab=VOUT}
N -50 100 -50 170 {lab=#net3}
N -150 100 -50 100 {lab=#net3}
N -50 230 -50 250 {lab=VSS}
N -260 -340 -260 -300 {lab=#net4}
N -360 -340 -360 -300 {lab=VDD}
N -260 -240 -260 -220 {lab=Nbulk}
N -360 -240 -360 -220 {lab=Pbulk}
N -380 230 -380 250 {lab=VSS}
N -200 230 -200 250 {lab=VSS}
N -380 10 -380 150 {lab=ref_n}
N -380 -80 -380 -50 {lab=VDD}
N -200 -80 -200 -50 {lab=VDD}
N -390 -20 -380 -20 {lab=Pbulk}
N -200 -20 -190 -20 {lab=Pbulk}
N -200 200 -190 200 {lab=Nbulk}
N -400 200 -380 200 {lab=Nbulk}
N -600 150 -560 120 {lab=VSS}
N -600 150 -560 180 {lab=VSS}
N -640 180 -600 180 {lab=Nbulk}
N -640 120 -600 120 {lab=Nbulk}
N -640 120 -640 180 {lab=Nbulk}
N -600 60 -600 90 {lab=ref_n}
N -600 210 -600 240 {lab=cpy_n}
N -640 -60 -600 -30 {lab=VDD}
N -640 -0 -600 -30 {lab=VDD}
N -670 -30 -640 -30 {lab=Pbulk}
C {simulator_commands_shown.sym} 710 -270 0 0 {
name=Libs_Ngspice
simulator=ngspice
only_toplevel=true
value="
.include sg13g2_stdcell.spice
.lib cornerMOSlv.lib mos_ss
.lib cornerMOShv.lib mos_tt
.lib cornerHBT.lib hbt_typ
.lib cornerRES.lib res_typ
.lib cornerCAP.lib cap_typ
"
      spice_ignore=true}
C {code_shown.sym} 450 10 0 0 {name=SIM
simulator = NGSPICE
only_toplevel=true 
value="
.include test_gate.save
.param pwr=1.08
.option rshunt=1e9
.control
save all
op
write test_gate.raw
tran 10n 3u
plot vout
plot i(vmeas)
plot @n.xm3.nsg13_lv_nmos[ids]
plot @n.xm3.nsg13_lv_nmos[vds] @n.xm5.nsg13_lv_nmos[vds] 
.endc

"
spice_ignore=true}
C {/foss/designs/xschemas/ring_inv.sym} 200 210 0 0 {name=XINV1}
C {lab_pin.sym} 180 40 0 0 {name=p4 sig_type=std_logic lab=VDD}
C {lab_pin.sym} 180 150 0 0 {name=p5 sig_type=std_logic lab=VSS}
C {lab_pin.sym} 80 40 0 0 {name=p8 sig_type=std_logic lab=VDD}
C {lab_pin.sym} 80 150 0 0 {name=p9 sig_type=std_logic lab=VSS}
C {/foss/designs/xschemas/ring_inv.sym} -180 210 0 0 {name=XINV3}
C {lab_pin.sym} -250 100 0 0 {name=p12 sig_type=std_logic lab=VOUT2}
C {lab_pin.sym} 260 100 3 1 {name=p6 sig_type=std_logic lab=VOUT2}
C {/foss/designs/xschemas/ring_schmitt.sym} 80 100 0 0 {name=XSCHMITT1 nbulk=Nbulk pbulk=VDD}
C {sg13g2_pr/sg13_lv_pmos.sym} -220 -20 0 0 {name=M2
l=3u
w=3u
ng=6
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} -220 200 0 0 {name=M3
l=0.5u
w=0.75u
ng=1
m=3
mm_ok=1
model=sg13_lv_nmos
spiceprefix=X
}
C {lab_pin.sym} -200 250 0 0 {name=p13 sig_type=std_logic lab=VSS}
C {lab_pin.sym} -200 -80 0 0 {name=p14 sig_type=std_logic lab=VDD}
C {sg13g2_pr/sg13_lv_pmos.sym} -360 -20 0 1 {name=M4
l=3u
w=1u
ng=2
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {lab_pin.sym} -380 -80 0 0 {name=p15 sig_type=std_logic lab=VDD}
C {lab_pin.sym} -290 -20 1 1 {name=p18 sig_type=std_logic lab=I1u}
C {sg13g2_pr/sg13_lv_nmos.sym} -360 200 0 1 {name=M5
l=0.5u
w=0.75u
ng=1
m=1
mm_ok=1
model=sg13_lv_nmos
spiceprefix=X
}
C {lab_pin.sym} -380 250 0 0 {name=p19 sig_type=std_logic lab=VSS}
C {lab_pin.sym} -50 250 0 0 {name=p20 sig_type=std_logic lab=VSS}
C {sg13g2_pr/annotate_fet_params.sym} -140 -100 0 0 {name=annot1 ref=M2}
C {sg13g2_pr/annotate_fet_params.sym} -170 250 0 0 {name=annot2 ref=M3}
C {sg13g2_pr/annotate_fet_params.sym} -550 210 0 0 {name=annot4 ref=M5}
C {sg13g2_pr/annotate_fet_params.sym} -540 -90 0 0 {name=annot5 ref=M4}
C {simulator_commands_shown.sym} -1230 -270 0 0 {name=Simulator2
simulator=ngspice
only_toplevel=false 
value=".param mm_ok=1
.param mc_ok=1
.param temp=27

.control

let mc_runs = 50
let run = 0
set curplot=new
set scratch=$curplot
setplot $scratch
let vg=unitvec(mc_runs)

***************** LOOP *********************
dowhile run < mc_runs
save all
tran 10n 10u

set run=$&run
set dt=$curplot
setplot $scratch
let out\{$run\}=\{$dt\}.vout
let time\{$run\}=\{$dt\}.time
setplot $dt
reset
let run=run+1 
end
***************** LOOP *********************

set nolegend
plot \{$scratch\}.all vs \{$scratch\}.time0

.endc
"
spice_ignore=true}
C {iopin.sym} 50 -200 0 0 {name=p1 lab=VDD}
C {iopin.sym} 50 -170 0 0 {name=p2 lab=VSS}
C {opin.sym} 50 -150 0 0 {name=p3 lab=VOUT}
C {ipin.sym} 70 -130 0 0 {name=p7 lab=I1u}
C {/foss/designs/xschemas/ring_inv.sym} 330 210 0 0 {name=XINV2}
C {lab_pin.sym} 310 40 0 0 {name=p16 sig_type=std_logic lab=VDD}
C {lab_pin.sym} 310 150 0 0 {name=p17 sig_type=std_logic lab=VSS}
C {lab_pin.sym} 390 100 3 1 {name=p21 sig_type=std_logic lab=VOUT}
C {sg13g2_pr/cap_cmim.sym} -50 200 0 0 {name=C1
model=cap_cmim
w=42e-6
l=42e-6
m=1
spiceprefix=X}
C {/foss/designs/xschemas/ntap1_custom.sym} -260 -270 0 0 {name=R1
model=ptap1
spiceprefix=X
w=3e-6
l=3e-6
rw=0.3e-6
A=16.9974e-12
P=106.74e-6
}
C {/foss/designs/xschemas/ntap1_custom.sym} -360 -270 0 0 {name=R2
model=ntap1
spiceprefix=X
w=3e-6
l=3e-6
rw=0.3e-6
A=17.115e-12
P=115.9e-6
}
C {lab_pin.sym} -360 -340 0 0 {name=p22 sig_type=std_logic lab=VDD}
C {lab_pin.sym} -260 -340 0 1 {name=p23 sig_type=std_logic lab=VSS}
C {lab_pin.sym} -360 -220 0 1 {name=p24 sig_type=std_logic lab=Pbulk}
C {lab_pin.sym} -260 -220 0 1 {name=p25 sig_type=std_logic lab=Nbulk}
C {lab_pin.sym} -190 -20 0 1 {name=p26 sig_type=std_logic lab=Pbulk}
C {lab_pin.sym} -390 -20 0 0 {name=p27 sig_type=std_logic lab=Pbulk}
C {lab_pin.sym} -190 200 0 1 {name=p28 sig_type=std_logic lab=Nbulk}
C {lab_pin.sym} -400 200 0 0 {name=p29 sig_type=std_logic lab=Nbulk}
C {lab_pin.sym} 200 130 0 1 {name=p30 sig_type=std_logic lab=Nbulk}
C {lab_pin.sym} 330 130 0 1 {name=p31 sig_type=std_logic lab=Nbulk}
C {lab_pin.sym} 200 70 0 1 {name=p32 sig_type=std_logic lab=Pbulk}
C {lab_pin.sym} 330 70 0 1 {name=p33 sig_type=std_logic lab=Pbulk}
C {lab_pin.sym} -180 70 0 1 {name=p10 sig_type=std_logic lab=Pbulk}
C {lab_pin.sym} -180 130 0 1 {name=p11 sig_type=std_logic lab=Nbulk}
C {sg13g2_pr/sg13_lv_nmos.sym} -580 120 0 1 {name=M1
l=0.5u
w=0.75u
ng=1
m=1
mm_ok=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} -580 180 0 1 {name=M6
l=0.5u
w=0.75u
ng=1
m=1
mm_ok=1
model=sg13_lv_nmos
spiceprefix=X
}
C {lab_pin.sym} -600 150 0 1 {name=p34 sig_type=std_logic lab=VSS}
C {lab_pin.sym} -640 150 0 0 {name=p35 sig_type=std_logic lab=Nbulk}
C {lab_pin.sym} -600 60 0 0 {name=p36 sig_type=std_logic lab=ref_n}
C {lab_pin.sym} -380 130 0 0 {name=p37 sig_type=std_logic lab=ref_n}
C {lab_pin.sym} -600 240 0 0 {name=p38 sig_type=std_logic lab=cpy_n}
C {lab_pin.sym} -200 150 0 0 {name=p39 sig_type=std_logic lab=cpy_n}
C {sg13g2_pr/sg13_lv_pmos.sym} -620 -30 0 1 {name=M7
l=1u
w=1.68u
ng=1
m=2
model=sg13_lv_pmos
spiceprefix=X
}
C {lab_pin.sym} -670 -30 0 0 {name=p40 sig_type=std_logic lab=Pbulk}
C {lab_pin.sym} -640 -60 0 0 {name=p41 sig_type=std_logic lab=VDD}
