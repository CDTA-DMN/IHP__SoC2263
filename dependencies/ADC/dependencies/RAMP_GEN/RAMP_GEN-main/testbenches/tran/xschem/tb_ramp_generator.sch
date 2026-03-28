v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 590 -170 590 -140 {lab=GND}
N 590 -270 590 -230 {lab=vdd}
N 290 -210 290 -180 {lab=GND}
N 1010 185 1010 215 {lab=GND}
N 290 -310 290 -270 {lab=Reset}
N 520 -30 520 0 {lab=GND}
N 520 -130 520 -90 {lab=ramp_en}
N 670 145 710 145 {lab=ramp_en}
N 1010 105 1010 145 {lab=vdd}
N 1010 165 1107.5 165 {lab=vramp}
N 660 165 710 165 {lab=Reset}
C {vsource.sym} 590 -200 0 0 {name=vdd value=1.5 savecurrent=false}
C {lab_pin.sym} 590 -270 0 0 {name=vdd1 sig_type=std_logic lab=vdd}
C {gnd.sym} 590 -140 0 0 {name=vdd2 lab=GND}
C {gnd.sym} 290 -180 0 0 {name=vdd3 lab=GND}
C {gnd.sym} 1010 215 0 0 {name=vdd4 lab=GND}
C {lab_pin.sym} 290 -310 0 0 {name=vdd5 sig_type=std_logic lab=Reset}
C {ipin.sym} 670 145 0 0 {name=p4 lab=ramp_en}
C {vsource.sym} 520 -60 0 0 {name=V2 value="pwl(0 0 4u 0 4.01u 1.5  300u 1.5)" savecurrent=false}
C {gnd.sym} 520 0 0 0 {name=vdd6 lab=GND}
C {lab_pin.sym} 520 -130 0 0 {name=vdd7 sig_type=std_logic lab=ramp_en}
C {vsource.sym} 290 -240 0 0 {name=V3 value="pulse(0 1.5 270u 10n 10n 2u 300u)" savecurrent=false
}
C {simulator_commands_shown.sym} -100 -140 0 0 {
name=Libs_Ngspice
simulator=ngspice
only_toplevel=false
value="

.lib cornerMOSlv.lib mos_tt
.lib cornerCAP.lib cap_typ

"
      }
C {code_shown.sym} 130 40 0 0 {name=SIM
simulator = NGSPICE
only_toplevel=false 
value="
.control
save all
tran 10n 300u
plot vramp reset ramp_en
.endc

"
}
C {designs/single_slope_adc/ramp_generator/ramp_generator.sym} 860 165 0 0 {name=x1}
C {lab_pin.sym} 1010 105 0 0 {name=vdd8 sig_type=std_logic lab=vdd}
C {lab_pin.sym} 1107.5 165 0 1 {name=p1 sig_type=std_logic lab=vramp}
C {lab_pin.sym} 660 165 0 0 {name=p3 sig_type=std_logic lab=Reset}
