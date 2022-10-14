#!/bin/sh
# SPDX-FileCopyrightText: 2020 Efabless Corporation
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# SPDX-License-Identifier: Apache-2.0

#--------------------------------------------------------------------------------
# Run LVS on the user_analog_project_wrapper layout, comparing against the
# top-level xschem subcircuit from the wrapper testbench.
#
#--------------------------------------------------------------------------------
export MAGIC_EXT_USE_GDS=1
netgen -batch lvs "../mag/mgmt_protect.spice mgmt_protect" "../verilog/mgmt_protect.v mgmt_protect" /usr/share/pdk/sky130A/libs.tech/netgen/sky130A_setup.tcl exercise_7_comp.out -json | tee lvs.log
echo ""
../../count_lvs.py exercise_7_comp.json | tee -a lvs.log
