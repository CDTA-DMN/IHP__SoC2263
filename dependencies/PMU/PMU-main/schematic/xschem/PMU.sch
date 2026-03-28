v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N -170 -220 -70 -220 {lab=Nbulk}
N -70 -220 -70 -50 {lab=Nbulk}
N -130 -50 -70 -50 {lab=Nbulk}
N -70 -50 -70 50 {lab=Nbulk}
N -150 50 -70 50 {lab=Nbulk}
C {/foss/designs/xschemas/Ali/bgr.sym} -280 -60 0 0 {name=x1}
C {/foss/designs/xschemas/ldo_1v5_y.sym} -300 70 0 0 {name=x2}
C {/foss/designs/xschemas/ldo_1v2_a.sym} -320 -200 0 0 {name=x3}
C {iopin.sym} -170 -240 0 0 {name=p1 lab=IOVDD}
C {iopin.sym} -170 -200 0 0 {name=p2 lab=VDD1v2}
C {opin.sym} -170 -180 0 0 {name=p3 lab=VBG}
C {iopin.sym} -170 -160 0 0 {name=p4 lab=VSS}
C {lab_pin.sym} -150 30 0 1 {name=p9 lab=IOVDD}
C {iopin.sym} -150 70 0 0 {name=p10 lab=VDD1v5}
C {lab_pin.sym} -150 90 0 1 {name=p11 lab=VBG}
C {lab_pin.sym} -150 110 0 1 {name=p12 lab=VSS}
C {lab_pin.sym} -130 -90 0 1 {name=p5 lab=IOVDD}
C {lab_pin.sym} -130 -70 0 1 {name=p6 lab=VSS}
C {lab_pin.sym} -130 -30 0 1 {name=p7 lab=VBG}
C {iopin.sym} -70 -140 0 0 {name=p8 lab=Nbulk}
