# Physical_Verification_SKY130A

This repository contains the documantaion containg the work done during a 5 day workshop on physical verification carried out by VSD.

The workshop describes the physical verification process that takes place during an RTL to GDSII flow using Skywater 130nm Technology, including DRC and LVS tests. This helps the participants get ready for the tape out and is particularly helpful for chip fabrication. The workshop assists in locating and fixing violations made during the physical verification stage.

More information about the workshop can be found [here](https://www.vlsisystemdesign.com/physical-verification-using-sky130/)

A special thanks to Tim, Kunal and Sumanto for creating and helping out during this amazing workshop
- [R. Timothy Edwards](https://github.com/RTimothyEdwards)
- [Kunal Ghosh](https://github.com/kunalg123)
- [VSD-IAT](https://vsdiat.com/)

## Index
* [Chapter 0 - Getting the tools](#Chapter-0---Getting-the-tools)
* [Chapter 1 - Understanding the design flow](#Chapter-1---Understanding-the-design-flow)
* [Chapter 2 - DRC and LVS Fundamentals](#Chapter-2---DRC-and-LVS-Fundamentals)
* [Chapter 3 - DRC Issues](#Chapter-3---DRC-Issues)
* [Chapter 4 - LVS](#Chapter-4---LVS)
* [Additional Content - OpenLANE Design Flow](#Additional-Content---OpenLANE-Design-Flow)

## Chapter 0 - Getting the tools

To adequetly utilize the open source skywater130 pdk and understand the design flow we first require to install all the tools, which are
- open_pdk
- magic
- ngspice
- xschem
- netgen
![toolchains](Resources/Lab1/toolchains.png)

*Note: open_pdk has to be installed last so it can correctly associate the xschem and magic directories.*
*Note:if the configure step fails during any process its most likely due to missing additional packages and they need to be installed (preferably from source) to complete the installation*

### Magic
Magic is an open source VLSI layout tool.<br /><br />
Install steps:
```
$  git clone git://opencircuitdesign.com/magic
$  cd magic
$	 ./configure
$  make
$  sudo make install
```
More info can be found at: [http://opencircuitdesign.com/magic/index.html](http://opencircuitdesign.com/magic/index.html)

### Netgen
Netgen is a tool for comparing netlists, a process known as LVS, which stands for "Layout vs. Schematic" <br /><br />
Install steps:
```
$  git clone git://opencircuitdesign.com/netgen
$  cd netgen
$	./configure
$  make
$  sudo make install
```
More info can be found at: [http://opencircuitdesign.com/netgen/index.html](http://opencircuitdesign.com/netgen/index.html)

### Xschem
Xschem is a schematic capture program <br /><br />
Install steps:
```
$  git clone https://github.com/StefanSchippers/xschem.git xschem_git
$	./configure
$  make
$  sudo make install
```
More info can be found at: [http://repo.hu/projects/xschem/index.html](http://repo.hu/projects/xschem/index.html)

### Ngspice
ngspice is the open source spice simulator for electric and electronic circuits.<br /><br />
Install steps:<br />

After downloading the tar ball from [https://sourceforge.net/projects/ngspice/files/](https://sourceforge.net/projects/ngspice/files/) to a local directory unpack it using:
```
 $ tar -zxvf ngspice-37.tar.gz
 $ cd ngspice-37
 $ mkdir release
 $ cd release
 $ ../configure  --with-x --with-readline=yes --disable-debug
 $ make
 $ sudo make install
```
More info can be found at: [https://ngspice.sourceforge.io/index.html](https://ngspice.sourceforge.io/index.html)

Please note that to view the simulation graphs of ngspice, xterm is required and can be installed using
```
$ sudo apt-get update
$ sudo apt-get install xterm
```

### open_pdk

Open_PDKs is distributed with files that support the Google/SkyWater sky130 open process description [https://github.com/google/skywater-pdk](https://github.com/google/skywater-pdk). Open_PDKs will set up an environment for using the SkyWater sky130 process with open-source EDA tools and tool flows such as magic, qflow, openlane, netgen, klayout, etc.<br /><br />
Install steps:
```
$  git clone git://opencircuitdesign.com/open_pdks
$  open_pdks
$	./configure --enable-sky130-pdk
$  make
$  sudo make install
```

Now that we have all the required tools installed lets get started with understanding the design flow!
## Chapter 1 - Understanding the design flow

### Verifiying the open_pdk installation
An initial working directory can be made by copying the required files as follows:
```
$ mkdir Lab1_and
$ cd Lab1_and
$ mkdir mag
$ mkdir netgen
$ mkdir xschem
$ cd xschem
$ cp /usr/local/share/pdk/sky130A/libs.tech/xschem/xschemrc
$ cp /usr/local/share/pdk/sky130A/libs.tech/ngspice/spinit .spiceinit
$ cd ../mag
$ cp /usr/local/share/pdk/sky130A/libs.tech/magic/sky130A.magicrc .magiccrc
$ cd ../netgen
```
Checking if magic works
![mag_test](Resources/Lab1/mag_test.png)<br />
Checking if xschem works
![xschem_test](Resources/Lab1/xschem_test.png)<br />
Checking if netgen works
![netgen_test](Resources/Lab1/netgen_test.png)<br />
Checking if ngspice works
![spice_test](Resources/Lab1/spice_test.png)<br />
### Creating inverter schematic using xschem
An initial schematic is made by placing components from the open_pdk library<br />
The required changes to the devices properties can be made here and will automatically reflect in the layout
![xshem_inv](Resources/Lab1/xshem_inv.png)<br />
Convert the schematic to a symbol
![xshem_sym](Resources/Lab1/xshem_sym.png)<br />
Using the symbol we can create an independent test bench to simulate the circuit
![xshem_tb](Resources/Lab1/xshem_tb.png)<br />
### Creating and simulating testbench Schematic
The circuit can be simulated in ngspice. *make sure to disable .subckt in the simulation tab for the netlist generated for sim*
![xschem_sim](Resources/Lab1/xschem_sim.png)
### Creating inverter layout in Magic and exporting its netlist
The original schematic can be used to export a netlist, which can be imported into magic to create the layout. <br /><br />

Set the appropiate device properties and route the layout.
![mag_p1](Resources/Lab1/mag_p1.png)<br /><br />
![mag_p1](Resources/Lab1/mag_p1.png)<br /><br />
![mag_net](Resources/Lab1/mag_net.png)<br /><br />
### Performing LVS checks on testbench and layout netlists
The netlist of the layout can be extracted using
```
% export do local
% export all
% ext2spice lvs
% ext2spice
```
The schematic netlist and layout netlist can be compared using LVS by netgen
```
$ netgen -batch lvs "../mag/inverter.spice inverter" "../xschem/inverter.spice inverter"
```
![lvs](Resources/Lab1/lvs.png)
## Chapter 2 - DRC and LVS Fundamentals

### Design Rule Checking (DRC)
Make sure design layout meets all silicon foundry rules for masks.

### Layout vs. Schematic (LVS)
Make sure design layout matches a simulatable netlist by electrical connectivity and devices.

![LVS](Resources/Lab2/LVS.png)

### Reading GDS files

```
$ cp /usr/local/share/pdk/sky130A/libs.tech/magic/sky130A.magicrc ./.magicrc
```

```
% gds read /usr/local/share/pdk/sky130A/libs.ref/sky130_fd_sc_hd/gds/sky130_fd_sc_hd.gds
% load sky130_fd_sc_hd__and2_1
```
![load_cell](Resources/Lab2/load_cell.png)

```
% cif istyle sky130(vendor)
% gds read /usr/local/share/pdk/sky130A/libs.ref/sky130_fd_sc_hd/gds/sky130_fd_sc_hd.gds
```

![change_istyle](Resources/Lab2/change_istyle.png)


### Matching ports to spice netlists

```
% port first
% port 1 name
% port 1 class
% port 1 use
```
![no_metadata](Resources/Lab2/no_metadata.png)

```
% lef read /usr/local/share/pdk/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd.lef
```
![lef_metadata](Resources/Lab2/lef_metadata.png)

```
% readspice /usr/local/share/pdk/sky130A/libs.ref/sky130_fd_sc_hd/spice/sky130_fd_sc_hd.spice
% load sky130_fd_sc_hd__and2_1
```
![spice_metadata](Resources/Lab2/spice_metadata.png)


### Abstract views

Note: difference between load and getcell

The difference is between a cell and an instance of that cell.
If you do load inverter, then you will be editing the cell called inverter.
If you do getcell inverter, then you will place an instance of the cell inverter inside the cell you're currently editing.

```
% lef read /usr/local/share/pdk/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd.lef
% load sky130_fd_sc_hd__and2_1
% readspice /usr/local/share/pdk/sky130A/libs.ref/sky130_fd_sc_hd/spice/sky130_fd_sc_hd.spice
% load test
% getcell sky130_fd_sc_hd__and2_1
% gds write test     
```
![abstract_view](Resources/Lab2/abstract_view.png)


Restart magic to and the cell fails to be loaded properly because the changes were not saved
```
%gds read test
%save test
```
![failed_load](Resources/Lab2/failed_load.png)

When test is reloaded after saving we get the original layout
```
% load test
% gds write test
```
We can edit the cell by making it editable
```
% property
% cellname writeable sky130_fd_sc_hd__and2_1 true
% gds write test
```
![editing](Resources/Lab2/editing.png)

and after restarting magic and reloading it we still get an unchanged cell
```
% gds read test
```
![reload](Resources/Lab2/reload.png)



### Extraction
```
% extract all
% ext2spice lvs
% ext2spice
```
![spice](Resources/Lab2/spice.png)
```
% ext2spice cthresh 0.01
% ext2spice
```
![spice_c](Resources/Lab2/spice_c.png)

```
% ext2sim labels on
% ext2sim

% extresist tolerance 10
% extresist

% ext2spice lvs
% ext2spice cthresh 0.01
% ext2spice extresist on
% ext2spice
```
![spice_rc](Resources/Lab2/spice_rc.png)


### DRC
```
$ /usr/local/share/pdk/sky130A/libs.tech/magic/run_standard_drc.py /usr/local/share/pdk sky130A/libs.ref/sky130_fd_sc_hd/mag/sky130_fd_sc_hd__and2_1.mag
```
```
% drc liastall style
% drc style drc(full)
% drc check
% drc why
% drc find
```
```
% getcell sky130_fd_sc_hd__tapvpwrvgnd_1
```
![drc](Resources/Lab2/drc.png)

### LVS
![gen_spice](Resources/Lab2/gen_spice.png)

```
netgen -batch lvs "../mag/sky130_fd_sc_hd__and2_1.spice sky130_fd_sc_hd__and2_1" "/usr/local/share/pdk/sky130A/libs.ref/sky130_fd_sc_hd/spice/sky130_fd_sc_hd.spice sky130_fd_sc_hd__and2_1"
```
![lvs_2](Resources/Lab2/lvs_2.png)

### XOR
XOR is the process to compare to GDS files by highlighting any differences between the two.
```
% flatten -nolabels xor_test
```
edit the cell
```
% xor -nolables xor_test
% load xor_test
```
![xor_test](Resources/Lab2/xor_test.png)

## Chapter 3 - DRC Issues

Each foundry has its own manufacturing rules and we have to make sure that the layout abides by these. The stackup for the skywater130 process is as folows:
![stack](Resources/Lab3/stack.jpg)

The detailed explaination of all the rules can be found as:
[https://skywater-pdk.readthedocs.io/en/main/rules.html](https://skywater-pdk.readthedocs.io/en/main/rules.html)

### Usefull Magic commands
- b
- s
- ?
- : box width 0.14um
- : stret u 0.14um
- : move e 0.14um
- : box grow c 0.01um
- : paint m1
- drc find
- see no *
- see m1

### Solving sample DRC voilations in Magic
#### width_rule
![ex_1a](Resources/Lab3/ex_1a.png)
#### spaceing_rule
![ex_1b](Resources/Lab3/ex_1b.png)
#### wide_spacing_rule
![ex_1c](Resources/Lab3/ex_1c.png)
#### notch_rule
![ex_1d](Resources/Lab3/ex_1d.png)
#### via_size
![ex_2a](Resources/Lab3/ex_2a.png)
#### multiple_vias
![ex_2b](Resources/Lab3/ex_2b.png)
#### via_overlap
![ex_2c](Resources/Lab3/ex_2c.png)
#### auto_generate_via
![ex_2d](Resources/Lab3/ex_2d.png)
#### minimum_area_rule
![ex_3a](Resources/Lab3/ex_3a.png)
#### minimum_hole_rule
![ex_3b](Resources/Lab3/ex_3b.png)
#### wells
![ex_4a](Resources/Lab3/ex_4a.png)
#### deep_nwell
![ex_4c_1](Resources/Lab3/ex_4c_1.png)
#### automatic_deep_nwell
![ex_4c_2](Resources/Lab3/ex_4c_2.png)
#### derived_layers
![ex_5a](Resources/Lab3/ex_5a.png)
#### derived_layer_high_voltage
![ex_5b](Resources/Lab3/ex_5b.png)
#### derived_layers_automatic_layers
![ex_5c](Resources/Lab3/ex_5c.png)
#### Paramterized Devices
![ex_6a](Resources/Lab3/ex_6a.png)
![ex_6b](Resources/Lab3/ex_6b.png)
![ex_6c](Resources/Lab3/ex_6c.png)
#### Angle errors
![ex_7a](Resources/Lab3/ex_7a.png)
![ex_7b](Resources/Lab3/ex_7b.png)
![ex_7c](Resources/Lab3/ex_7c.png)
#### Overlap Errors
![ex_7d](Resources/Lab3/ex_7d.png)
![ex_7e](Resources/Lab3/ex_7e.png)

## Chapter 4 - LVS

## Additional Content - OpenLANE Design Flow

OpenLANE is an automated RTL to GDSII flow based on several components including OpenROAD, Yosys, Magic, Netgen, Fault, OpenPhySyn, CVC, SPEF-Extractor and custom methodology scripts for design exploration and optimization. The flow performs full ASIC implementation steps from RTL all the way down to GDSII.

### Design Flow
![flow.ong](Resources/OpenLane/flow.png)

1. **Synthesis**
    1. `yosys/abc` - Perform RTL synthesis and technology mapping.
    2. `OpenSTA` - Performs static timing analysis on the resulting netlist to generate timing reports
2. **Floorplaning**
    1. `init_fp` - Defines the core area for the macro as well as the rows (used for placement) and the tracks (used for routing)
    2. `ioplacer` - Places the macro input and output ports
    3. `pdngen` - Generates the power distribution network
    4. `tapcell` - Inserts welltap and decap cells in the floorplan
3. **Placement**
    1. `RePLace` - Performs global placement
    2. `Resizer` - Performs optional optimizations on the design
    3. `OpenDP` - Perfroms detailed placement to legalize the globally placed components
4. **CTS**
    1. `TritonCTS` - Synthesizes the clock distribution network (the clock tree)
5. **Routing**
    1. `FastRoute` - Performs global routing to generate a guide file for the detailed router
    2. `TritonRoute` - Performs detailed routing
    3. `OpenRCX` - Performs SPEF extraction
6. **Tapeout**
    1. `Magic` - Streams out the final GDSII layout file from the routed def
    2. `KLayout` - Streams out the final GDSII layout file from the routed def as a back-up
7. **Signoff**
    1. `Magic` - Performs DRC Checks & Antenna Checks
    2. `KLayout` - Performs DRC Checks
    3. `Netgen` - Performs LVS Checks
    4. `CVC` - Performs Circuit Validity Checks

All the information about the project can be found in the openlANE documentation:
[https://openlane.readthedocs.io/en/latest/index.html](https://openlane.readthedocs.io/en/latest/index.html)

### config.tcl

this file is nessecary for running the openLANE flow and its documentation can be found at:
[https://openlane.readthedocs.io/en/latest/reference/configuration.html](https://openlane.readthedocs.io/en/latest/reference/configuration.html)

### Example - openLANE without interactive run
run the following in the openLANE deirectory
```
export PDK_ROOT=/usr/local/share/pdk
make mount
./flow.tcl -design spm -tag run1
```

This runs the entire openLANE flow and generates the required GDSII and .mag files which can be viewed in magic

### Example - openLANE with interactive run

The interactive flow allows to run each step of the design flow. It can be launched using
```
export PDK_ROOT=/usr/local/share/pdk
make mount
./flow.tcl -interactive
```
Start the Design flow  and synthesis with the following
```
package require openlane
prep -design spm -tag run1
run_synthesis
```
Run the Floorplaning using
```
run_floorplan
```
Run the placement using
```
run_placement
```
Run the clock tree generation and STA using
```
run_cts
```
The clock tree can be optimized using
```
run_resizer_timing
```
Run the routing using
```
run_routing
```
After all the changes that have taken place a new verilog file can be obtained using
```
write_powered_verilog
set_netlist $::env(lvs_result_file_tag).powered.v
```
Generate GDSII file using
```
run_magic
```
An alternate GDSII file is generated using klayout for XOR verification
```
run_klayout
```
Run the XOR test using
```
run_klayout_gds_xor
```
Export spice netlist using
```
run_magic_spice_export
```
Run LVS on exported spice netlist and verilog file
```
run_lvs
```
DRC checks
```
run_magic_drc
```
Antenna Checks
```
run_antenna_check
```
LEF checks
DRC_checks
```
run_lef_cvc
```
Final summary report can be generated using
DRC_checks
```
generate_final_summary_report
```
### Example - Technique to prevant DRC errors
- **Local Interconnect rules**  : Avoid routing large traces on the local interconnect
- **Density Planning** : The utilization ratio can be reduced to form more spaced circuits with lesser errors The FP_CORE_UTIL variable in the .config file
- **Dont use cells** : Avoid using cells that are known to cause errors
- **Manual verification** : For designs with lower number of DRC errors, the can be corrected with the methods disscused in chapter 3
