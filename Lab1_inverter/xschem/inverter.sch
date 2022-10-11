v {xschem version=3.1.0 file_version=1.2
}
G {}
K {}
V {}
S {}
E {}
N 1920 -1220 1920 -1180 {
lab=vss}
N 1920 -1320 1920 -1280 {
lab=vout}
N 1920 -1410 1920 -1380 {
lab=vdd}
N 1880 -1350 1880 -1250 {
lab=vin}
N 1860 -1300 1880 -1300 {
lab=vin}
N 1920 -1300 1980 -1300 {
lab=vout}
N 1920 -1250 1940 -1250 {
lab=vss}
N 1940 -1250 1940 -1200 {
lab=vss}
N 1920 -1200 1940 -1200 {
lab=vss}
C {sky130_fd_pr/nfet_01v8.sym} 1900 -1250 0 0 {name=M1
L=0.18
W=4.5
nf=3 
mult=1
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=nfet_01v8
spiceprefix=X
}
C {devices/ipin.sym} 1860 -1300 0 0 {name=p1 lab=vin}
C {devices/iopin.sym} 1920 -1180 0 0 {name=p1 lab=vss
}
C {devices/iopin.sym} 1920 -1410 0 0 {name=p1 lab=vdd}
C {devices/opin.sym} 1980 -1300 0 0 {name=p1 lab=vout}
C {sky130_fd_pr/pfet3_01v8.sym} 1900 -1350 0 0 {name=M2
L=0.18
W=3
body=vdd
nf=3
mult=1
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=pfet_01v8
spiceprefix=X
}
