# 10G_Ethernet_Mac_UVM
Development of an Ethernet MAC design and verification environment using Verilog/SystemVerilog and Universal Verification Methodology (UVM). Focuses on packet handling, CRC-32 error detection, constrained-random stimulus, scoreboard-based checking, functional coverage, and verification planning for high-speed networking hardware.


[README.md](https://github.com/user-attachments/files/33396894/README.md)
# 10G Ethernet MAC with UVM Verification — Architecture/Verification Pack

## What is included
- MAC/PCS/PMA boundary and frame-processing architecture notes.
- Ethernet CRC-32 byte-update reference function.
- UVM sequence-item example for randomized packet scenarios.
- Functional coverage example.
- Scoreboard integration scaffold.

## What is not included
This is not a complete, synthesizable 10G Ethernet TX/RX MAC. The CV states that a MAC was implemented and a UVM testbench used, but does not include the original RTL, exact client interface, or implementation boundary. The package avoids falsely claiming that the CRC and UVM scaffolds alone constitute a full MAC.

## Minimum full MAC repository deliverables
1. TX datapath FSM, byte-lane steering, preamble/SFD, padding, FCS, IFG.
2. RX frame detector, lane alignment at the selected MAC boundary, FCS checker, length/error policy.
3. Explicit 64-bit/8-control-bit XGMII or selected streaming interface.
4. Backpressure and reset policy.
5. Directed tests for empty/minimum/maximum/jumbo frames, CRC vectors, lane boundaries, IFG, reset, backpressure, and malformed frames.
6. UVM agent: sequencer, sequence, driver, monitor, config, env, scoreboard, coverage, tests.
7. Independent CRC golden model and known-good protocol vectors.
8. Synthesis/timing report and clear statement of whether PCS/PMA are outside the design.

