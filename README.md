# UART Transmitter — RTL to GDSII using OpenLane and Sky130

## Overview

This project implements a UART transmitter (UART TX) as a sequential digital design in Verilog and takes the design through a complete RTL-to-GDSII physical-design flow using OpenLane v1.0.2 and the Sky130 technology.

Unlike a purely combinational design, the UART transmitter is a clocked sequential circuit, making clock-aware timing analysis and CTS-related physical-design stages applicable.

## Function

The UART transmitter converts parallel data into a serial UART data stream.

The transmitter uses a clock-driven sequential process to control the transmission of data through the TX output.

The UART transmission frame includes the required serial data sequencing and returns the transmitter to its idle condition after transmission.

## Design

Main design elements:

- Clock input
- Reset/control logic
- Parallel data input
- Transmission control
- Serial TX output

The UART transmitter is a sequential and clocked design.

## RTL-to-GDSII Flow

Verilog RTL → RTL Simulation → Synthesis → Floorplanning → IO Placement → Power Planning → Placement → Clock/CTS Analysis → Routing → Timing → DRC/LVS → GDSII

## Verification

RTL simulation was performed using the Verilog testbench.

The UART transmitter functionality was verified through simulation and the generated waveform was inspected using GTKWave.

The project includes:

- UART RTL source
- Verilog testbench
- Simulation results
- Generated VCD waveform
- GTKWave waveform verification

The final RTL simulation and waveform evidence are stored in the `screenshots/` directory.

## Physical Design Results

| Metric | Result |
|---|---:|
| Standard cells | 182 |
| Total cell area | 1923.094400 µm² |
| TNS | 0.00 |
| WNS | 0.00 |
| Worst setup slack | 6.63 |
| Worst hold slack | 0.31 |
| Total power | 5.00 × 10⁻⁴ W |
| Internal power | 3.57 × 10⁻⁴ W |
| Switching power | 1.43 × 10⁻⁴ W |
| Leakage power | 1.64 × 10⁻⁹ W |
| DRC violations | 0 |
| LVS errors | 0 |
| XOR differences | 0 |

## Static Timing Analysis

Static Timing Analysis was performed for the clocked UART transmitter.

Detailed timing reports were generated for multiple operating corners.

The project contains:

- Maximum-corner STA reports
- Minimum-corner STA reports
- Nominal-corner STA reports
- Detailed RC-extracted timing reports
- Setup and hold timing reports
- Combined all-corner STA report

The complete combined STA report is available as:

`results/sta/STA_report_all_corners.rpt`

Additional STA reports are available in `results/sta/`.

The final recorded timing results are:

- TNS: 0.00
- WNS: 0.00
- Worst setup slack: 6.63
- Worst hold slack: 0.31

## Clocking

This UART transmitter is a sequential clocked design.

Therefore:

- A clock is used by the design.
- Clock-aware timing analysis is applicable.
- CTS/clock-related implementation is applicable.
- Setup and hold timing are analyzed.

This is different from the 4-bit ALU project, which was purely combinational.

## Signoff

The final design successfully completed physical signoff and generated GDSII.

- DRC: 0 violations
- LVS: 0 errors
- XOR: 0 differences
- Antenna: no listed violations
- Final GDSII: generated successfully
- KLayout GDS: generated
- Final LEF: generated
- Final SPICE: generated
- Final SDF: generated
- Final Liberty: generated
- Final MAG: generated

## Final Files

Important physical-design outputs are available in `results/final/`:

- uart_tx.gds
- uart_tx.klayout.gds
- uart_tx.lef
- uart_tx.lib
- uart_tx.spice
- uart_tx.sdf
- uart_tx.mag
- uart_tx.rpt

Important signoff reports are available in `results/signoff/`.

Important STA reports are available in `results/sta/`:

- rcx_max_sta.checks.rpt
- rcx_max_sta.max.rpt
- rcx_max_sta.min.rpt
- rcx_max_sta.power.rpt
- rcx_max_sta.skew.rpt
- rcx_max_sta.summary.rpt
- rcx_min_sta.checks.rpt
- rcx_min_sta.max.rpt
- rcx_min_sta.min.rpt
- rcx_min_sta.power.rpt
- rcx_min_sta.skew.rpt
- rcx_min_sta.summary.rpt
- rcx_nom_sta.checks.rpt
- rcx_nom_sta.max.rpt
- rcx_nom_sta.min.rpt
- rcx_nom_sta.power.rpt
- rcx_nom_sta.skew.rpt
- rcx_nom_sta.summary.rpt
- STA_report_all_corners.rpt

## Repository Structure

UART-TX-RTL-to-GDSII/
- README.md
- rtl/
- simulation/
- openlane/
- results/
- screenshots/
- docs/

## Screenshots

The `screenshots/` directory contains the main project evidence:

- `uart_rtl.png`
- `uart_simulation.png`
- `uart_waveforms.png`
- `uart_layouts.png`

These provide evidence of the RTL design, simulation, waveform verification and final physical layout.

## Tools

- Verilog HDL
- OpenLane v1.0.2
- Sky130 PDK
- Sky130 HD standard-cell library
- GTKWave
- KLayout
- Ubuntu Linux

## Key Learning Outcomes

- Sequential RTL design using Verilog
- UART transmitter architecture
- Clocked digital design
- RTL simulation and waveform analysis
- Logic synthesis
- Floorplanning
- IO placement
- Power planning
- Standard-cell placement
- Clock/CTS-related implementation
- Global and detailed routing
- Static timing analysis
- Multi-corner timing analysis
- DRC verification
- LVS verification
- XOR/layout comparison
- GDSII generation
- Physical-design signoff

## Conclusion

The UART transmitter successfully completed the RTL-to-GDSII physical-design flow using OpenLane and the Sky130 technology.

The project demonstrates a complete sequential VLSI implementation starting from Verilog RTL and RTL simulation and progressing through synthesis, floorplanning, placement, clock-related implementation, routing, detailed multi-corner static timing analysis and physical signoff.

The final implementation generated GDSII and achieved zero DRC violations, zero LVS errors and zero XOR differences, with positive recorded setup and hold timing slack.

The project provides a complete portfolio example of a clocked RTL-to-GDSII implementation using an open-source VLSI flow.
