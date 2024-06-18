**Synchronous FIFO 8-bit**
- This project contains the Verilog implementation of an 8-bit Synchronous FIFO (First-In-First-Out) memory module. The design includes a testbench to simulate and verify the functionality of the FIFO.

**Features**

- 8-bit data width
- Synchronous read and write operations
- Full and empty flags
- Simulation using Xilinx Vivado
  
**Files**
- sync_fifo.v: Verilog module for the 8-bit Synchronous FIFO.
- tb.v: Testbench for the FIFO module.
- tb.tcl: TCL script for running the simulation.
- Snapshot of xsim simulation.

**Usage**
- The FIFO module can be instantiated in other Verilog designs to handle buffering and data flow control. The testbench demonstrates basic read and write operations.
