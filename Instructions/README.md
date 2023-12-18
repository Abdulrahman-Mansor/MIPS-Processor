## Introduction

The table below outlines the MIPS assembly instructions categorized by their type and functionality. These instructions are classified into three main types: R (Register), I (Immediate), and J (Jump). Each instruction type is characterized by specific fields and functions that enable operations within the MIPS architecture.

### Instruction Set Overview

The MIPS assembly language consists of various instructions, each represented by a combination of opcode and functional fields, operating on registers or immediate values. The instruction format and size vary based on their type, whether they manipulate registers, perform immediate operations, or handle jumps and branches.

### Instruction Types Summary

| Instruction Type | Description        | Number of Instructions |
|------------------|--------------------|------------------------|
| R (Register)     | Arithmetic commands |            8           |
| I (Immediate)    | Immediate commands |            9           |
| J (Jump)         | Jump & Branch      |            7           |

### Program 1:
This microprogram is designed to multiply two numbers using loops and then verify the result by dividing the obtained product by the second number. It performs arithmetic operations using the MIPS assembly instructions represented in machine code.

| Machine Code | Description                            |
|--------------|----------------------------------------|
| x"7003"      | Load Immediate $r0 with 3              |
| x"720A"      | Load Immediate $r1 with 10             |
| x"7400"      | Load Immediate $r2 with 0              |
| x"7E00"      | Load Immediate $r7 with 0              |
| x"1290"      | $r2 = $r2 + $r1                        |
| x"3001"      | $r0 = $r0 - 1                          |
| x"B1C4"      | Branch to 4 if $r0 > $r7 (x"1290")     |
| x"145B"      | $r3 = $r2 / $r1                        |
