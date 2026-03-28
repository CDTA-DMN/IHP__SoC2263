v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 30 -250 30 -220 {lab=GND}
N 30 -350 30 -310 {lab=vdd}
N -270 -290 -270 -260 {lab=GND}
N 450 105 450 135 {lab=GND}
N -270 -390 -270 -350 {lab=Reset}
N -40 -110 -40 -80 {lab=GND}
N -40 -210 -40 -170 {lab=ramp_en}
N 110 65 150 65 {lab=ramp_en}
N 450 25 450 65 {lab=vdd}
N 450 85 547.5 85 {lab=vramp}
N 100 85 150 85 {lab=Reset}
C {vsource.sym} 30 -280 0 0 {name=vdd value=1.5 savecurrent=false}
C {lab_pin.sym} 30 -350 0 0 {name=vdd1 sig_type=std_logic lab=vdd}
C {gnd.sym} 30 -220 0 0 {name=vdd2 lab=GND}
C {gnd.sym} -270 -260 0 0 {name=vdd3 lab=GND}
C {gnd.sym} 450 135 0 0 {name=vdd4 lab=GND}
C {lab_pin.sym} -270 -390 0 0 {name=vdd5 sig_type=std_logic lab=Reset}
C {ipin.sym} 110 65 0 0 {name=p4 lab=ramp_en}
C {gnd.sym} -40 -80 0 0 {name=vdd6 lab=GND}
C {lab_pin.sym} -40 -210 0 0 {name=vdd7 sig_type=std_logic lab=ramp_en}
C {vsource.sym} -270 -320 0 0 {name=V3 value="pulse(0 1.5 6u 10n 10n 2u 500u)" savecurrent=false
}
C {/foss/designs/xschemas/aymen/ramp_generator.sym} 300 85 0 0 {name=x1}
C {lab_pin.sym} 450 25 0 0 {name=vdd8 sig_type=std_logic lab=vdd}
C {lab_pin.sym} 547.5 85 0 1 {name=p1 sig_type=std_logic lab=vramp}
C {lab_pin.sym} 100 85 0 0 {name=p3 sig_type=std_logic lab=Reset}
C {code_shown.sym} -580 -145 0 0 {name=NGSPICE1 only_toplevel=false value=
"
.lib cornerCAP.lib cap_typ
.lib cornerMOSlv.lib mos_tt_mismatch
.lib cornerMOShv.lib mos_tt_mismatch
.param temp=27
.option rshunt=1e12
.control
  let mc_runs = 100
  let run = 0
  set curplot=new
  set scratch=$curplot
  setplot $scratch
  let vg=unitvec(mc_runs)
  echo "" > mc_ramp_results.csv
  save all
  //tran 100n 360u
  //plot vramp reset ramp_en
  //reset
  dowhile run <= mc_runs
    save all
    tran 100n 360u
    meas tran maxa WHEN vramp=1.2 rise=1
    let vmax = maxa*1e6 - 9
    print vmax >> mc_ramp_results.csv
    set run=$&run
    set dt=$curplot
    setplot $scratch
    let out\{$run\}=\{$dt\}.vramp
    let Vg\{$run\}=\{$dt\}.time
    setplot $dt
    reset
    let run = run + 1
  end
  set nolegend
  plot \{$scratch\}.allv vs \{$scratch\}.Vg1
.endc

"}
C {vsource.sym} -40 -140 0 0 {name=V1 value="pulse(1.5 0 6u 10n 10n 2u 500u)" savecurrent=false
}
C {lab_pin.sym} 120 110 0 0 {name=p10 lab=RAMP_REF}
