v {xschem version=3.1.0 file_version=1.2
}
G {}
K {}
V {}
S {}
E {}
N 1810 -1260 2210 -1260 {
lab=GND}
N 1810 -1320 1900 -1320 {
lab=in}
N 2200 -1320 2320 -1320 {
lab=#net1}
N 2200 -1280 2210 -1280 {
lab=GND}
N 2210 -1280 2210 -1260 {
lab=GND}
N 2210 -1260 2320 -1260 {
lab=GND}
N 2200 -1300 2250 -1300 {
lab=out}
N 2250 -1300 2250 -1290 {
lab=out}
N 1860 -1350 1860 -1320 {
lab=in}
C {devices/vsource.sym} 1810 -1290 0 0 {name=V1 value="PWL(0 0 20n 0.0 900n 1.8)"}
C {devices/vsource.sym} 2320 -1290 0 0 {name=V2 value=1.8}
C {devices/gnd.sym} 2090 -1260 0 0 {name=l1 lab=GND}
C {devices/code_shown.sym} 1970 -1480 0 0 {name=s1 only_toplevel=false value=".lib /usr/local/share/pdk/sky130A/libs.tech/ngspice/sky130.lib.spice tt"}
C {devices/code_shown.sym} 2070 -1180 0 0 {name=s2 only_toplevel=false value=".control
save all
tran 1n 1u
plot v(in) v(out)
.endc"}
C {inverter.sym} 2050 -1300 0 0 {name=x1}
C {devices/opin.sym} 1860 -1350 0 0 {name=p1 lab=in}
C {devices/opin.sym} 2250 -1290 0 0 {name=p1 lab=out}
