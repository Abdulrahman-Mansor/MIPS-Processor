# MIPS Microprocessor Implementation

This VHDL code implements a MIPS-like microprocessor architecture capable of executing a set of instructions stored in ROM.

## Design Overview

The `mips_microprocessor` entity defines a MIPS-like microprocessor with the following key components:
- Inputs: `clk` (clock), `reset` (reset signal).
- Outputs: `program_counter` (current program counter), `destination_register` (output register).

The microprocessor comprises an instruction ROM (`MyRom`) and a set of registers (`R`). Each instruction in the ROM is 16 bits wide and corresponds to various operations performed by the processor.

## Architecture Description

### Signals and Variables
- `R`: Array of registers used for storing data.
- `MyRom`: Instruction ROM holding the program instructions.
- Various signals ( `alu_func`, `instruction_register`, `memory_rw`, `CF`, `ZF`, etc.) used for internal processing and control.

### Processes
- `clk` Process: Driven by the clock signal, it handles instruction fetching, decoding, execution, and control flow.
- Instructions are fetched from `MyRom`, decoded, and executed based on the opcode.
- Execution results update the registers and control signals (`ZF`, `CF`).
- Control flow instructions (`BUN`, `BR`) alter the program counter (`pc_next`).

### Execution Units
- Arithmetic Logic Unit (ALU): Executes arithmetic and logical operations specified by instructions.

## Justification and Functionality

The design implements a basic MIPS-like microprocessor capable of executing a limited set of instructions stored in ROM. It handles arithmetic, logical, and control flow operations as per the provided instructions. The program counter (`program_counter`) reflects the current instruction being executed.

Each instruction is fetched, decoded, and executed sequentially based on the opcode. The ALU performs various operations such as addition, subtraction, logical AND, OR, XOR, etc. Branching instructions alter the program flow based on specific conditions.

## Notes
- This implementation is simplified and serves as a starting point for a MIPS-like microprocessor.
- Additional instructions and functionalities can be added for a more comprehensive processor.

---

Please refer to the VHDL code for detailed comments and implementation specifics.
