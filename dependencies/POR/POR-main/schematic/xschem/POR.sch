v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N -260 0 -190 0 {lab=#net1}
N -260 0 -260 30 {lab=#net1}
N -160 -40 -160 -30 {lab=VDD}
N -160 40 -160 50 {lab=VSS}
N -110 0 -80 0 {lab=#net2}
N -310 110 -310 130 {lab=VSS}
N -260 90 -260 130 {lab=VSS}
N -50 -40 -50 -30 {lab=VDD}
N -30 -40 -30 -20 {lab=Pbulk}
N -160 -40 -50 -40 {lab=VDD}
N -160 -50 -160 -40 {lab=VDD}
N -50 30 -50 40 {lab=VSS}
N -30 20 -30 40 {lab=nbulk}
N -160 40 -50 40 {lab=VSS}
N -160 30 -160 40 {lab=VSS}
N 0 0 20 0 {lab=RESET}
N -350 -70 -350 -0 {lab=#net1}
N -310 0 -260 0 {lab=#net1}
N -430 -100 -390 -100 {lab=#net3}
N -430 -100 -430 -50 {lab=#net3}
N -460 -100 -430 -100 {lab=#net3}
N -500 -50 -430 -50 {lab=#net3}
N -500 -70 -500 -50 {lab=#net3}
N -500 -50 -500 10 {lab=#net3}
N -580 40 -540 40 {lab=VBIAS}
N -310 0 -310 50 {lab=#net1}
N -350 -0 -310 0 {lab=#net1}
N -370 80 -350 80 {lab=VDD}
N -500 70 -500 120 {lab=VSS}
N -500 -160 -500 -130 {lab=VDD}
N -350 -160 -350 -130 {lab=VDD}
N -750 -310 -750 -290 {lab=VSS}
N -830 -310 -830 -290 {lab=VDD}
N -520 -100 -500 -100 {lab=Pbulk}
N -350 -100 -330 -100 {lab=Pbulk}
N -830 -230 -830 -200 {lab=Pbulk}
N -750 -230 -750 -200 {lab=nbulk}
N -690 -130 -650 -100 {lab=VDD}
N -690 -70 -650 -100 {lab=VDD}
N -740 -100 -690 -100 {lab=Pbulk}
C {/foss/designs/xschemas/ring_schmitt.sym} -160 0 0 0 {name=XSCHMITT1 nbulk=Nbulk pbulk=Pbulk}
C {sg13g2_pr/cap_cmim.sym} -260 60 2 0 {name=C1
model=cap_cmim
w=40e-6
l=20e-6
m=1
spiceprefix=X}
C {iopin.sym} -160 50 0 1 {name=p1 lab=VSS}
C {iopin.sym} -160 -50 0 1 {name=p2 lab=VDD}
C {opin.sym} 20 0 0 0 {name=p3 lab=RESET}
C {lab_pin.sym} -260 130 0 1 {name=p5 lab=VSS}
C {sg13g2_pr/sg13_lv_pmos.sym} -330 80 0 0 {name=M1
l=0.13u
w=9.96u
ng=12
m=1
mm_ok=1
model=sg13_lv_pmos
spiceprefix=X
}
C {/foss/designs/xschemas/ring_inv.sym} -30 110 0 0 {name=XINV1}
C {sg13g2_pr/sg13_lv_pmos.sym} -370 -100 0 0 {name=M2
l=0.5u
w=0.5u
ng=1
m=2
mm_ok=1
model=sg13_lv_pmos
spiceprefix=X
}
C {ipin.sym} -580 40 0 0 {name=p4 lab=VBIAS}
C {lab_pin.sym} -350 -160 0 1 {name=p8 lab=VDD}
C {lab_pin.sym} -370 80 0 0 {name=p7 lab=VDD}
C {sg13g2_pr/sg13_lv_pmos.sym} -480 -100 0 1 {name=M3
l=0.5u
w=0.5u
ng=1
m=2
mm_ok=1
model=sg13_lv_pmos
spiceprefix=X
}
C {lab_pin.sym} -500 -160 0 1 {name=p9 lab=VDD}
C {sg13g2_pr/sg13_hv_nmos.sym} -520 40 0 0 {name=M4
l=2u
w=0.5u
ng=1
m=1
mm_ok=1
model=sg13_hv_nmos
spiceprefix=X
}
C {lab_pin.sym} -500 120 0 1 {name=p10 lab=VSS}
C {sg13g2_pr/annotate_fet_params.sym} -630 -180 0 0 {name=annot1 ref=M3}
C {sg13g2_pr/annotate_fet_params.sym} -270 -180 0 0 {name=annot2 ref=M2}
C {sg13g2_pr/annotate_fet_params.sym} -630 70 0 0 {name=annot3 ref=M4}
C {sg13g2_pr/annotate_fet_params.sym} -430 120 0 0 {name=annot4 ref=M1}
C {lab_pin.sym} -310 130 0 1 {name=p11 lab=VSS}
C {/foss/designs/xschemas/ntap1_custom.sym} -830 -260 0 0 {name=R1
model=ntap1
spiceprefix=X
w=3e-6
l=3e-6
rw=0.3e-6
A=24.831e-12
P=166.14e-6
}
C {/foss/designs/xschemas/ntap1_custom.sym} -750 -260 0 0 {name=R2
model=ptap1
spiceprefix=X
w=3e-6
l=3e-6
rw=0.3e-6
A=12.969e-12
P=88.26e-6
}
C {lab_pin.sym} -830 -310 0 0 {name=p6 lab=VDD}
C {lab_pin.sym} -750 -310 0 1 {name=p12 lab=VSS}
C {lab_pin.sym} -830 -200 0 0 {name=p13 lab=Pbulk}
C {iopin.sym} -750 -200 0 0 {name=p14 lab=nbulk}
C {lab_pin.sym} -520 -100 0 0 {name=p15 lab=Pbulk}
C {lab_pin.sym} -340 -100 0 1 {name=p16 lab=Pbulk}
C {lab_pin.sym} -310 80 0 1 {name=p17 lab=Pbulk}
C {lab_pin.sym} -500 40 0 1 {name=p18 lab=nbulk}
C {lab_pin.sym} -30 40 0 1 {name=p19 lab=nbulk}
C {lab_pin.sym} -30 -40 0 1 {name=p20 lab=Pbulk}
C {sg13g2_pr/sg13_lv_pmos.sym} -670 -100 0 1 {name=M5
l=0.5u
w=0.5u
ng=1
m=4
mm_ok=1
model=sg13_lv_pmos
spiceprefix=X
}
C {lab_pin.sym} -690 -130 0 1 {name=p21 lab=VDD}
C {lab_pin.sym} -740 -100 0 0 {name=p22 lab=Pbulk}
