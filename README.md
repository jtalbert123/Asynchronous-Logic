# Asynchronous Logic
A place for my asynchronous logic code. My initial goal is to build an asynchronous MIPS microprocessor. I'll be using Modelsim PE Student Edition for the simulation. I'm running windows, so I may use batch files.

I am using Null Convention Logic (see NCL.pdf for a paper that really helped me). The basic premise is to break data into `state present` and `state not present`. Only one state can be present at a time for a given signal, but it is possible to have no state (`Null`), indicating that the circuit hasn't finished yet. To be able to tell when the circuit is finished, the whole thing is cleared (`state not present` on all lines) between each operation (like a clock edge). The difference between this and a clock edge is that the circuit tells when it's done and signals the reset itself, running as fast as it can given current conditions (like temperature and such). The circuit is also garuanteed to always complete, where as a clock could run too fast and cause problems.

I have begun doing some tests with Vivado using Xilinx FPGAs (the Zynq-7000 on the ZedBoard for now). This puts some constraints on the VHDL files:

 1. Vivado does not seem to allow for pre-declaring components in packages for RTL modules in a block design.
     - This means that the 'ncl.vhd' file I have been using will not be included in the Vivado setup, and would become inconsistent, so it is removed.
 2. Vivado does not allow for record types as ports in a block diagram, so the blocks will be transitioned using std_logic.
     - For multi-bit signals, there will be separate vectors for DATA0 and DATA1 rails of each group.
 3. Different entities have to be defined in different files (I don't fully understand the details of the error Vivado gives, but moving things to different files fixes it).
 
 - These changes will invalidate existing components and tests. These will be updated as they are used and some may be broken indefinitely (or removed entirely). 
