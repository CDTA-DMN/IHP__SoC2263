v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N -90 0 -60 0 {lab=A}
N 0 0 40 0 {lab=Y}
N -60 -50 -40 -50 {lab=A}
N -60 0 -60 50 {lab=A}
N -60 50 -40 50 {lab=A}
N 0 0 0 20 {lab=Y}
N 0 -20 0 0 {lab=Y}
N -60 -50 -60 0 {lab=A}
N 0 -50 30 -50 {lab=Pbulk}
N 0 50 30 50 {lab=Nbulk}
N -0 -110 0 -80 {lab=VDP}
N 0 80 0 110 {lab=VSN}
C {sg13g2_pr/sg13_lv_nmos.sym} -20 50 0 0 {name=M1
l=0.13u
w=0.7u
ng=1
m=1
mm_ok=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_pmos.sym} -20 -50 0 0 {name=M2
l=0.13u
w=1.12u
ng=1
m=1
mm_ok=1
model=sg13_lv_pmos
spiceprefix=X
}
C {ipin.sym} -90 0 0 0 {name=p1 lab=A}
C {opin.sym} 40 0 0 0 {name=p2 lab=Y}
C {iopin.sym} 30 -50 0 0 {name=p3 lab=Pbulk}
C {iopin.sym} 30 50 0 0 {name=p4 lab=Nbulk}
C {iopin.sym} 0 -110 0 0 {name=p5 lab=VDP}
C {iopin.sym} 0 110 0 0 {name=p6 lab=VSN}
C {sg13g2_pr/annotate_fet_params.sym} 100 20 0 0 {name=annot1 ref=M1}
C {sg13g2_pr/annotate_fet_params.sym} 100 -150 0 0 {name=annot2 ref=M2}
