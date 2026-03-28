v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 270 -160 270 -150 {lab=vo}
N 270 -280 270 -240 {lab=vdd}
N 270 -90 270 -50 {lab=gnd}
N 200 -210 230 -210 {lab=vi}
N 200 -160 200 -120 {lab=vi}
N 200 -120 230 -120 {lab=vi}
N 270 -160 370 -160 {lab=vo}
N 270 -180 270 -160 {lab=vo}
N 170 -160 200 -160 {lab=vi}
N 200 -210 200 -160 {lab=vi}
N 270 -120 350 -120 {lab=Nbulk}
N 270 -210 340 -210 {lab=PbulK}
C {sg13g2_pr/sg13_lv_pmos.sym} 250 -210 0 0 {name=M5
l=130n
w=1200n
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} 250 -120 0 0 {name=M7
l=130n
w=780n
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {iopin.sym} 170 -160 0 1 {name=p1 lab=vi}
C {iopin.sym} 370 -160 0 0 {name=p2 lab=vo}
C {iopin.sym} 270 -50 0 0 {name=p3 lab=gnd}
C {iopin.sym} 270 -280 0 0 {name=p4 lab=vdd}
C {iopin.sym} 340 -210 0 0 {name=p5 sig_type=std_logic lab=Pbulk}
C {iopin.sym} 350 -120 0 0 {name=p6 sig_type=std_logic lab=Nbulk}
