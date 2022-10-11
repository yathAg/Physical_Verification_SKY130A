# Physical_Verification_SKY130A


## About the project


## Index


## Chapter 0 - Getting the tools

To adequetly utilize the opensourse skywater130 pdk and understand the design flow we first require to install all the tools, which are
- open_pdk
- magic
- ngspice
- xschem
- netgen

![toolchains](Resources/Lab1/toolchains.png)

Note: open_pdk has to be installed last so it can correctly associate the xschem and magic directories.

### Magic

Magic is an open source VLSI layout tool.
Install steps
1.  git clone git://opencircuitdesign.com/magic
2.  cd magic
3.	./configure
4.  make
5.  sudo make install

More info can be found at: [http://opencircuitdesign.com/magic/](http://opencircuitdesign.com/magic/)

### Netgen

Netgen is a tool for comparing netlists, a process known as LVS, which stands for "Layout vs. Schematic"

Install steps
1.  git clone git://opencircuitdesign.com/netgen
2.  cd netgen
3.	./configure
4.  make
5.  sudo make install

## Chapter 1 - Understanding the design flow

## Chapter 2 - DRC and LVS

### Design Rule Checking (DRC)
Make sure design layout meets all silicon foundry rules for masks.

### Layout vs. Schematic (LVS)
Make sure design layout matches a simulatable netlist by electrical connectivity and devices.

![LVS](Resources/Lab2/LVS.png)
