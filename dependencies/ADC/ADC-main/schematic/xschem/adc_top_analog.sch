v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N -170 140 -170 180 {lab=VSS}
N -150 130 -150 170 {lab=VBIAS}
N -170 -20 -170 20 {lab=VDD}
N -150 -10 -150 30 {lab=RAMP_EN}
N -280 50 -240 50 {lab=VRAMP}
N -60 80 -20 80 {lab=VCMP}
N 90 -180 130 -180 {lab=VDD}
N 90 -140 130 -140 {lab=VSS}
N 90 -160 130 -160 {lab=VRAMP}
N -250 -180 -210 -180 {lab=RAMP_EN}
N -250 -160 -210 -160 {lab=RAMP_RESET}
N -250 -140 -210 -140 {lab=RAMP_REF}
N -500 50 -460 50 {lab=#net1}
N -460 110 -460 160 {lab=#net1}
N -500 160 -460 160 {lab=#net1}
N -460 110 -240 110 {lab=#net1}
N -460 50 -460 110 {lab=#net1}
N -530 100 -530 160 {lab=VSS}
N -630 50 -560 50 {lab=VMEAS}
N -630 160 -560 160 {lab=VDD1v2}
N -530 200 -530 240 {lab=SEL_CAL}
N -530 -50 -530 10 {lab=SEL_MEAS}
N -570 100 -530 100 {lab=VSS}
N -530 50 -530 100 {lab=VSS}
N -680 -150 -680 -110 {lab=Pbulk}
N -680 -240 -680 -210 {lab=VDD}
N -780 -150 -780 -110 {lab=VSS}
N -780 -240 -780 -210 {lab=VSS}
C {/foss/designs/xschemas/aymen/ramp_generator.sym} -60 -160 0 0 {name=x1 Nbulk=VSS}
C {/foss/designs/xschemas/ota_lv_gmid_comparator.sym} -160 80 0 0 {name=XCOMP1 nbulk=Nbulk}
C {lab_pin.sym} -170 180 0 0 {name=p1 lab=VSS}
C {lab_pin.sym} -170 -20 0 0 {name=p2 lab=VDD}
C {opin.sym} -20 80 0 0 {name=p3 lab=VCMP}
C {lab_pin.sym} -280 50 0 0 {name=p6 lab=VRAMP}
C {lab_pin.sym} -150 -10 0 1 {name=p7 lab=RAMP_EN}
C {ipin.sym} -150 170 0 1 {name=p4 lab=VBIAS}
C {iopin.sym} 130 -180 0 0 {name=p8 lab=VDD}
C {iopin.sym} 130 -140 0 0 {name=p9 lab=VSS}
C {opin.sym} 130 -160 0 0 {name=p10 lab=VRAMP}
C {ipin.sym} -250 -180 0 0 {name=p11 lab=RAMP_EN}
C {ipin.sym} -250 -140 0 0 {name=p12 lab=RAMP_REF}
C {ipin.sym} -250 -160 0 0 {name=p13 lab=RAMP_RESET}
C {sg13g2_pr/sg13_lv_nmos.sym} -530 30 1 0 {name=M1
l=0.13u
w=20u
ng=20
m=1
mm_ok=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} -530 180 3 0 {name=M2
l=0.13u
w=20u
ng=20
m=1
mm_ok=1
model=sg13_lv_nmos
spiceprefix=X
}
C {iopin.sym} -630 160 0 1 {name=p5 lab=VDD1v2}
C {iopin.sym} -630 50 0 1 {name=p14 lab=VMEAS}
C {ipin.sym} -530 -50 0 0 {name=p16 lab=SEL_MEAS}
C {ipin.sym} -530 240 0 0 {name=p17 lab=SEL_CAL}
C {/foss/designs/xschemas/ntap1_custom.sym} -680 -180 0 0 {name=R1
model=ntap1
spiceprefix=X
w=3e-6
l=3e-6
rw=0.3e-6
A=55.716e-12
P=371.44e-6
}
C {lab_pin.sym} -680 -110 0 1 {name=p20 lab=Pbulk}
C {lab_pin.sym} -680 -240 0 1 {name=p21 lab=VDD}
C {lab_pin.sym} -570 100 0 0 {name=p15 lab=VSS}
C {/foss/designs/xschemas/ntap1_custom.sym} -780 -180 0 0 {name=R2
model=ptap1
spiceprefix=X
w=3e-6
l=3e-6
rw=0.3e-6
A=59.4709e-12
P=318.23e-6
}
C {lab_pin.sym} -780 -110 0 1 {name=p18 lab=VSS}
C {lab_pin.sym} -780 -240 0 1 {name=p19 lab=VSS}
