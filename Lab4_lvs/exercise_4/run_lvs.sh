#!/bin/sh
netgen -batch lvs "netA.spice test" "netB.spice test" \
sky130A_setup.tcl \
exercise_4_comp.out -json | tee lvs.log
echo ""
../count_lvs.py | tee -a lvs.log
