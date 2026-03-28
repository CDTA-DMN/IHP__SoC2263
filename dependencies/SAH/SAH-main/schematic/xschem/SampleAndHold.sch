v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N -300 200 -300 250 {lab=Vout}
N -300 300 -300 330 {lab=VSS}
N -300 200 -250 200 {lab=Vout}
N -530 50 -460 50 {lab=#net1}
N -460 50 -460 120 {lab=#net1}
N -740 50 -710 50 {lab=en}
N -380 200 -300 200 {lab=Vout}
N -740 50 -740 290 {lab=en}
N -770 50 -740 50 {lab=en}
N -740 290 -460 290 {lab=en}
N -460 280 -460 290 {lab=en}
N -400 -40 -400 -20 {lab=vdd}
N -280 40 -280 60 {lab=Nbulk}
N -400 40 -400 60 {lab=Pbulk}
N -280 -40 -280 -20 {lab=VSS}
C {opin.sym} -250 200 0 0 {name=p1 lab=Vout}
C {ipin.sym} -540 200 0 0 {name=p2 lab=Vin}
C {ipin.sym} -770 50 0 0 {name=p3 lab=en}
C {lab_pin.sym} -670 -10 0 0 {name=p5 sig_type=std_logic lab=vdd}
C {gnd.sym} -670 110 0 0 {name=D1 lab=VSS}
C {lab_pin.sym} -540 160 0 0 {name=p6 sig_type=std_logic lab=Pbulk}
C {ipin.sym} -520 -30 0 0 {name=p4 lab=vdd}
C {/foss/designs/xschemas/aymen/inverter.sym} -690 50 0 0 {name=x2}
C {/foss/designs/xschemas/aymen/T_gate.sym} -460 200 0 0 {name=x1}
C {sg13g2_pr/cap_cmim.sym} -300 270 0 0 {name=C1
model=cap_cmim
w=40e-6
l=120e-6
m=1
spiceprefix=X}
C {/foss/designs/xschemas/ntap1_custom.sym} -400 10 0 0 {name=R1
model=ntap1
spiceprefix=X
w=3e-6
l=3e-6
rw=0.3e-6
A=7.635e-12
P=52.1e-6
}
C {/foss/designs/xschemas/ntap1_custom.sym} -280 10 0 0 {name=R2
model=ptap1
spiceprefix=X
w=3e-6
l=3e-6
rw=0.3e-6
A=5.499e-12
P=37.86e-6
}
C {lab_pin.sym} -650 -10 0 1 {name=p7 lab=Pbulk}
C {iopin.sym} -650 110 0 0 {name=p8 lab=Nbulk}
C {lab_pin.sym} -400 60 0 1 {name=p9 lab=Pbulk}
C {lab_pin.sym} -280 60 0 1 {name=p10 lab=Nbulk}
C {lab_pin.sym} -400 -40 0 0 {name=p11 sig_type=std_logic lab=vdd}
C {lab_pin.sym} -280 -40 0 0 {name=p12 sig_type=std_logic lab=VSS}
C {lab_pin.sym} -540 250 0 0 {name=p13 sig_type=std_logic lab=Nbulk}
C {iopin.sym} -300 330 0 0 {name=p14 sig_type=std_logic lab=VSS}
