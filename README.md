# MIPS Microprocessor Design Justification

## 1. Design Overview

The MIPS microprocessor is a VHDL-based design aimed at emulating a simplified version of the MIPS architecture. It comprises various components, including an instruction ROM, a set of registers, an ALU, and control logic.

## 2. Declaration File (MIPS_functions_declarations)

The `MIPS_functions_declarations` file encapsulates the declarations within the `pkg` package. It defines the `alu_result` record and declares the `ALU` function prototype, essential for performing arithmetic and logical operations within the microprocessor.

## 3. Implementations File (MIPS_functions_implementation)

The `MIPS_functions_implementation` file, contained within the package body `pkg`, hosts the implementation of the `ALU` function. This function handles various arithmetic and logical operations based on the provided opcode. It updates the `alu_result` record, indicating the result and carry/zero flags.

## 4. Entity (mips_microprocessor)

The `mips_microprocessor` entity uses a single input called `clk`. When clk changes, it makes the processor run one instruction quickly. When the `reset` signal is activated, it starts the instructions again from the beginning by resting the `program_counter` signal.

## 5. Signals & Variables

Within the `mips_behav` architecture, various signals and variables play crucial roles in controlling the microprocessor's behavior. These include `R` (registers), `MyRom` (instruction ROM), `pc_current`, `pc_next` (program counters), and `instruction_register` (holding fetched instructions), among others. These elements collectively manage instruction execution and control.

## 6. Opcode Switch Case

The `opcode` switch case statement, embedded within the microprocessor's architecture, decodes fetched instructions and directs the processor's behavior accordingly. Based on the opcode, specific operations are executed, utilizing the ALU function, performing arithmetic, logical, and control operations, and managing control flow via conditional branching.

---

The combination of these components creates a functioning MIPS-like microprocessor capable of executing a set of predefined instructions stored in ROM. Refer to the VHDL code for detailed implementation specifics and further insights into each component's functionality.
