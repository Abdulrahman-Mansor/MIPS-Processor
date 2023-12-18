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
```The whole instructions table dispalyed in `lap manual V2.pdf` file```
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

### Program 2:
This microprogram is designed to Check if the number entered in `r7` is prime or not. The number is prime if the `r5` flage is 0 and not prime otherwise. Since there no instruction that perfrom arithmetic `mod` (&) We used instead integer division `/` and multiplication `*`. For Example Assume that `x = 10` and `y = 4` when divide `z = x / y` then multiply `w = z * y` then compare `w == x` if true then `x` is divisble by `y` otherwise is false, in this case it is false because `10 != (10 / 4) * 4` => `10 != 2 * 4` => `10 != 8`.
|    Machine Code    | Instruction Diagram  |                     Description                        |
|--------------------|----------------------|------------------------------------------------------- |
| x"7C02"            | r6 <- 2              | Load a 2 to r6 to perfrom as a counter                 |
| x"7E63"            | r7 <- num=17         | Load the number to be checked into r7                  |
| x"1F93"            | r2 <- r6 / r7        | Division of two values to get a boundary               |
| x"1F9B"            | loop: r3 <- r7 / r6  | Division of number by the boundary                     |
| x"17A2"            | r4 <- r3 * r6        | Multiplication for comparison                          |
| x"A9CE"            | if r4 == r7          | Branch if the number is not prime to raise r5 flag to 1|
| x"2D81"            | r6 <- r6 + 1         | Increment to move to the next divisor                  |
| x"CC83"            | if r6 < r2           | Check if the divisor is within the boundary            |
| x"2B40"            | r5 <- r5 + 0         | Add r5 with 0 to display it in the simulation          |
| x"7A01"            | r5 <- 1              | if the number is divisble by any number r5 flag = 1 to mark it as non prime|
| x"F008"            | BR : x"8"            | Branch back end of the program                         |

