# FPGA-Based Traffic Light Controller with Emergency Priority

## Overview
This educational RTL project models a traffic-light controller with three states:
RED, GREEN, and YELLOW. An active-high emergency input requests RED priority.
The normal sequence is RED -> GREEN -> YELLOW -> RED.

## Features
- Synthesizable-style Verilog RTL
- Finite-state-machine (FSM) control
- Configurable state durations through parameters
- Emergency input forces the RED output while asserted
- Testbench creates a clock, reset, and emergency event

## Files
- `traffic_light.v` — controller design
- `traffic_light_tb.v` — simulation testbench
- `block_diagram.png` — high-level design diagram

## How to simulate
Use a Verilog simulator such as Icarus Verilog, or a browser simulator such as EDA Playground.

With Icarus Verilog installed:
```bash
iverilog -g2012 -o traffic_sim traffic_light.v traffic_light_tb.v
vvp traffic_sim
```

The testbench also writes a VCD waveform file named `traffic_light.vcd`.
Open it in GTKWave if available.

## Expected checks
1. During reset, RED should be active.
2. During normal operation, the controller should cycle RED -> GREEN -> YELLOW -> RED.
3. While `emergency` is high, RED should be active and YELLOW/GREEN should be inactive.
4. After `emergency` goes low, the normal sequence restarts from RED.

## Limitations
This is an educational RTL simulation project. It has not been demonstrated on physical FPGA hardware by the author unless separate hardware implementation and testing are performed. Before submission, run the simulation and include genuine output logs or waveform screenshots.

## Author
Add your name, college, and internship details here before submission.
