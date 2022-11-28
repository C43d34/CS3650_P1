# CS3650_P1
Verilog Implementation of MIPS Processor 
Group Members:
- Cleighton Greer
- Joey Cindass
- Alexandra Flores

# Single Cycle Implementation

What we learned from implentating this single cycle processor:
- This implementation utilizes only 16-bits, so words are only 2bytes. Therefore we end up only needing to shift addresses by 1 bit instead of 2 for instructions and addressing memory. 
    (By 2 addressing instead of by 4)
- The usage of "forever" in creating an infinite loop to simulate the clock changing 
- That the next PC address must cascade through multiple conditionals - such as condition if instruction is a branch, or a jump - before finally being updated
- We can specify certain bits as "x" when trying to match in a case condition - they serve as wild card (or don't cares).
    This is especially useful for ALU Control because there are cases where if the opfield != 00, then the lower order bits from func code are irrelevant.
- How to implement basic instructions:
    Notably: Follow the path of control
    Instruction OP Field Code -> Control Module = ALUOP Code
    ALUOP Code -> Alu Control Module = ALU_Control Code
    ||
    ALUOP Code + Instruction Func Field -> Alu Control Module = ALU_Control Code

- Attached in an image in this file is a waveform file of a short string of instructions which adds 2 from register $3 to register $1 after loading 2 from $3.
    A simple direct register jump instruction is utilized to perform this loop.

    There was a lot of learn when it comes to tracking how each control line affects the program and also figuring out which subsets of the instruction
    the processor is utilizing to do specific things. For example, for the load word instruction, initially there destination register and read register were mixed up which produced unwanted results. 




Following implementations learned from on the net:
- https://www.fpga4student.com/2017/01/verilog-code-for-single-cycle-MIPS-processor.html
- https://www.fpga4student.com/2017/01/basic-digital-blocks-in-verilog.html
