v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N -90 0 -60 0 {lab=A}
N 0 0 140 -0 {lab=Y}
N -60 -50 -40 -50 {lab=A}
N -60 0 -60 50 {lab=A}
N -60 50 -40 50 {lab=A}
N 0 0 0 20 {lab=Y}
N 0 -20 0 0 {lab=Y}
N -60 -50 -60 0 {lab=A}
N 0 -50 30 -50 {lab=pbulk}
N 0 50 30 50 {lab=nbulk}
N 0 100 0 110 {lab=VSPL}
N 0 140 30 140 {lab=nbulk}
N 0 170 0 200 {lab=VSS}
N 0 -130 30 -130 {lab=pbulk}
N 0 -190 0 -160 {lab=VDD}
N -0 -90 -0 -80 {lab=#net1}
N -60 -130 -40 -130 {lab=A}
N -60 -130 -60 -50 {lab=A}
N -60 140 -40 140 {lab=A}
N -60 50 -60 140 {lab=A}
N -0 -90 110 -90 {lab=#net1}
N -0 -100 -0 -90 {lab=#net1}
N 170 -90 220 -90 {lab=VSS}
N 140 -100 140 -90 {lab=pbulk}
N 140 -0 140 60 {lab=Y}
N 0 100 110 100 {lab=VSPL}
N 0 80 0 100 {lab=VSPL}
N 140 -0 190 -0 {lab=Y}
N 140 -50 140 -0 {lab=Y}
N 140 100 140 120 {lab=nbulk}
N 170 100 220 100 {lab=VDD}
C {sg13g2_pr/sg13_lv_nmos.sym} -20 50 0 0 {name=M1
l=0.13u
w=10u
ng=5
m=1
mm_ok=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_pmos.sym} -20 -50 0 0 {name=M2
l=0.13u
w=6.25u
ng=5
m=1
mm_ok=1
model=sg13_lv_pmos
spiceprefix=X
}
C {ipin.sym} -90 0 0 0 {name=p1 lab=A}
C {opin.sym} 190 0 0 0 {name=p2 lab=Y}
C {iopin.sym} 290 -240 0 0 {name=p3 lab=VDD}
C {iopin.sym} 380 -240 0 0 {name=p4 lab=VSS}
C {sg13g2_pr/sg13_lv_nmos.sym} -20 140 0 0 {name=M3
l=0.5u
w=0.155u
ng=1
m=1
mm_ok=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_pmos.sym} -20 -130 0 0 {name=M4
l=0.5u
w=0.5u
ng=1
m=1
mm_ok=1
model=sg13_lv_pmos
spiceprefix=X
}
C {lab_pin.sym} 0 -190 0 1 {name=p7 sig_type=std_logic lab=VDD}
C {lab_pin.sym} 0 200 0 1 {name=p10 sig_type=std_logic lab=VSS}
C {sg13g2_pr/sg13_lv_pmos.sym} 140 -70 3 0 {name=M5
l=1u
w=2.5u
ng=1
m=1
mm_ok=1
model=sg13_lv_pmos
spiceprefix=X
}
C {lab_pin.sym} 220 -90 0 1 {name=p12 sig_type=std_logic lab=VSS}
C {sg13g2_pr/sg13_lv_nmos.sym} 140 80 1 0 {name=M6
l=0.5u
w=2.945u
ng=19
m=1
mm_ok=1
model=sg13_lv_nmos
spiceprefix=X
}
C {lab_pin.sym} 220 100 0 1 {name=p14 sig_type=std_logic lab=VDD}
C {sg13g2_pr/annotate_fet_params.sym} -220 -250 0 0 {name=annot1 ref=M4}
C {sg13g2_pr/annotate_fet_params.sym} -220 -120 0 0 {name=annot2 ref=M2}
C {sg13g2_pr/annotate_fet_params.sym} -220 10 0 0 {name=annot3 ref=M1}
C {sg13g2_pr/annotate_fet_params.sym} -220 140 0 0 {name=annot4 ref=M3}
C {sg13g2_pr/annotate_fet_params.sym} 300 -170 0 0 {name=annot5 ref=M5}
C {sg13g2_pr/annotate_fet_params.sym} 300 -10 0 0 {name=annot6 ref=M6}
C {lab_pin.sym} 90 100 1 1 {name=p15 sig_type=std_logic lab=VSPL}
C {lab_pin.sym} 140 120 0 1 {name=p16 sig_type=std_logic lab=nbulk}
C {lab_pin.sym} 30 140 0 1 {name=p9 sig_type=std_logic lab=nbulk}
C {lab_pin.sym} 30 50 0 1 {name=p8 sig_type=std_logic lab=nbulk}
C {lab_pin.sym} 30 -130 0 1 {name=p5 sig_type=std_logic lab=pbulk}
C {lab_pin.sym} 30 -50 0 1 {name=p6 sig_type=std_logic lab=pbulk}
C {lab_pin.sym} 140 -100 0 1 {name=p11 sig_type=std_logic lab=pbulk}
