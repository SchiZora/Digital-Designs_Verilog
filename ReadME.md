# Digital Designs in Verilog

A collection of digital design circuits and experiments written in Verilog HDL as part of my journey into Digital Design, Computer Architecture, FPGA Development, and eventually VLSI Design.

This repository serves as:

* A personal learning journal
* A reference for other beginners learning Verilog
* A collection of basic digital circuits built from scratch

---

## About This Repository

I started this repository while learning Digital Design and Verilog HDL after which i eventually moved to system verilog.

While studying theory, I simultaneously implemented every basic concept myself, simulated it, verified the outputs, and understand how digital hardware and circuitry is actually built.

Every module in this repository was written as part of that learning process.

The goal is not just to make circuits work, but to understand:

* How digital logic operates
* How hardware is described using Verilog
* How larger systems are built from smaller building blocks
* How computer processors and digital chips are designed

---

Topics Covered:

This repository covers the fundamental concepts of digital design through hands-on implementation of various circuits in Verilog HDL. The basic designs are divided, allowing a gradual understanding of how complex digital systems are built using the basic building blocks.

Combinational Logic

Combinational logic circuits produce outputs that depend solely on the current inputs. Eg: Full Adder, Full Subtractor, Multiplexers (MUX), Demultiplexers (DEMUX), Encoders, Decoders.

Sequential Logic

Combinational logic circuits produce outputs that depend on both, current input and previous state. This requires memory like elements like flip-flops,registers or Counters. This Also requires Clock, (CLK) on many elements.

Arithmetic Ciruit

Arithmetic circuits are essential components of processors and Arithmetic Logic Units (ALUs). a great example of this would be of 2's complement Subtractor i built, it can be used as both an adder and a subtractor making it useful in Building ALUs.

---

### Simulation

For every design I have:

1. Created the modules
2. Created testbench
3. Applied test cases in testbench modules
4. Ran simulations
5. Verifed outputs using waveforms

This helped me understand how real Digital Logic works

---

## Tools Used

* Verilog HDL
* Xilinx Vivado
* Xilinx ISE
* Icarus Verilog
* GTKWave
* FPGA Development Board: Numato Mimas Spartan6 FPGA

---

## Why This Repository Exists

Many tutorials show the final complex designs immediately, not the logical understanding behind it.

This repository focuses on learning by building.

Each design is implemented from basic principles to help understand:

* Why the circuit works
* How Verilog describes hardware
* How basic digital systems are constructed

Think of this as Lego Buidling blocks, Single blocks don't make anything but millions and billions of these basic blocks makeup Modern ALUs, cores, GPU, CPU, NPU.

If you are a beginner, I encourage you to:

1. Read the theory
2. Write the module yourself
3. Create your own testbench
4. Simulate the design
5. Verify every output

You will learn far more than by simply copying code.

---

## Future Goals

This repository is the starting point toward learning:

* Digital Design
* Computer Architecture
* FPGA Development
* RTL Design
* VLSI Engineering

---

## Author

Zorain Kalu

Computer Engineering Student

Currently learning:

* Verilog/Systemverilog HDL
* Digital Design
* Computer Architecture
* Linux
* Embedded Systems
* VLSI Fundamentals

---

## License

This repository is open for learning and educational purposes.

Feel free to explore, study, modify, and experiment with the code.
