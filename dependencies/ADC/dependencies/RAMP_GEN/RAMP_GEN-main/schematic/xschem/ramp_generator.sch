v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 120 -210 250 -210 {lab=vdd}
N 150 120 250 120 {lab=vramp}
N 290 170 340 170 {lab=Reset}
N 120 -230 120 -210 {lab=vdd}
N 150 240 250 240 {lab=VSS}
N 120 240 120 270 {lab=VSS}
N 150 190 150 240 {lab=VSS}
N 120 240 150 240 {lab=VSS}
N -20 -210 120 -210 {lab=vdd}
N 120 -130 120 -110 {lab=#net1}
N -120 130 -60 130 {lab=RAMP_REF}
N -120 80 -120 130 {lab=RAMP_REF}
N -180 130 -120 130 {lab=RAMP_REF}
N -220 80 -220 100 {lab=RAMP_REF}
N -220 80 -120 80 {lab=RAMP_REF}
N -20 160 -20 240 {lab=VSS}
N -20 130 40 130 {lab=VSS}
N -20 240 120 240 {lab=VSS}
N 150 120 150 130 {lab=vramp}
N 250 120 250 140 {lab=vramp}
N 250 25 310 25 {lab=vramp}
N 120 -110 210 -110 {lab=#net1}
N 50 -110 120 -110 {lab=#net1}
N -220 240 -20 240 {lab=VSS}
N -20 -30 -20 100 {lab=#net1}
N 250 -80 250 25 {lab=vramp}
N 50 -110 50 -30 {lab=#net1}
N 20 -110 50 -110 {lab=#net1}
N -20 -30 50 -30 {lab=#net1}
N -20 -80 -20 -30 {lab=#net1}
N -220 20 -220 80 {lab=RAMP_REF}
N 250 -210 250 -140 {lab=vdd}
N -20 -210 -20 -140 {lab=vdd}
N 60 -160 80 -160 {lab=ramp_en}
N 120 -210 120 -190 {lab=vdd}
N -40 -110 -20 -110 {lab=pbulk}
N 250 -110 280 -110 {lab=pbulk}
N 120 -160 130 -160 {lab=pbulk}
N -220 160 -220 240 {lab=VSS}
N -250 130 -220 130 {lab=VSS}
N 250 200 250 240 {lab=VSS}
N 250 25 250 120 {lab=vramp}
N -240 -160 -200 -130 {lab=vdd}
N -240 -100 -200 -130 {lab=vdd}
N -310 -130 -240 -130 {lab=Pbulk}
N -360 -10 -320 20 {lab=VSS}
N -360 50 -320 20 {lab=VSS}
N -400 20 -360 20 {lab=VSS}
C {sg13g2_pr/sg13_lv_nmos.sym} 270 170 0 1 {name=M5
l=0.13u
w=52.8u
ng=10
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_pmos.sym} 230 -110 0 0 {name=M6
l=10u
w=0.15u
ng=1
m=2
model=sg13_lv_pmos
spiceprefix=X
mm_ok=1}
C {sg13g2_pr/sg13_lv_pmos.sym} 0 -110 0 1 {name=M1
l=10u
w=0.15u
ng=1
m=30
model=sg13_lv_pmos
spiceprefix=X
mm_ok=1}
C {lab_pin.sym} 120 -230 0 0 {name=p1 sig_type=std_logic lab=vdd}
C {sg13g2_pr/sg13_lv_pmos.sym} 100 -160 0 0 {name=M2
l=0.13u
w=40u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {ipin.sym} 60 -160 0 0 {name=p4 lab=ramp_en}
C {sg13g2_pr/sg13_lv_pmos.sym} -40 130 0 0 {name=M3
l=10u
w=0.3u
ng=1
m=2
mm_ok=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_pmos.sym} -200 130 0 1 {name=M4
l=10u
w=0.3u
ng=1
m=6
mm_ok=1
model=sg13_lv_nmos
spiceprefix=X
}
C {iopin.sym} 120 270 0 0 {name=p7 lab=VSS}
C {iopin.sym} -40 -260 0 0 {name=p8 lab=vdd}
C {ipin.sym} 340 170 0 1 {name=p9 lab=Reset}
C {opin.sym} 310 25 0 0 {name=p3 lab=vramp}
C {sg13g2_pr/cap_cmim.sym} 150 160 2 1 {name=C2
model=cap_cmim
w=40e-6
l=40e-6
m=2
spiceprefix=X}
C {ipin.sym} -220 20 0 1 {name=p14 lab=RAMP_REF}
C {lab_pin.sym} 130 -160 0 1 {name=p11 lab=pbulk}
C {lab_pin.sym} 280 -110 0 1 {name=p12 lab=pbulk}
C {lab_pin.sym} -40 -110 0 0 {name=p13 lab=pbulk}
C {lab_pin.sym} -250 130 0 0 {name=p15 lab=VSS}
C {lab_pin.sym} 30 130 0 1 {name=p16 lab=VSS}
C {lab_pin.sym} 250 170 0 0 {name=p17 lab=VSS}
C {sg13g2_pr/sg13_lv_pmos.sym} -220 -130 0 1 {name=M7
l=5u
w=0.15u
ng=1
m=16
model=sg13_lv_pmos
spiceprefix=X
mm_ok=1}
C {lab_pin.sym} -310 -130 0 0 {name=p2 lab=Pbulk}
C {lab_pin.sym} -200 -130 0 1 {name=p5 sig_type=std_logic lab=vdd}
C {sg13g2_pr/sg13_lv_pmos.sym} -340 20 0 1 {name=M8
l=10u
w=0.3u
ng=1
m=8
mm_ok=1
model=sg13_lv_nmos
spiceprefix=X
}
C {lab_pin.sym} -320 20 0 1 {name=p6 sig_type=std_logic lab=VSS}
C {lab_pin.sym} -400 20 0 0 {name=p10 lab=VSS}
