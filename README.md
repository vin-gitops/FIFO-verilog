# FIFO-verilog
OVERVIEW
This project implements parameterised FIFO (First In First Out) memory using verilog
FIFO is like a queue in coffee shop
Data Written at the back, read from the front
FIFO is a fundamental data structure used in digital circuits, communication interfaces, and processor archintecture for buffering data between modules operating at different speeds.
The design supports configurable data width and memory depth, making it reusable across different hardware designs.
# MY FIFO SPECIFICATIONS
- Parameterized DATA_WIDTH
- Parameterized FIFO_DEPTH
- Synchronized
- Separate read and write pointers
- Full and empty flag detection
- testbench for simulation and verification

# DESGIN ARCHITECTURE
FIFO consists of the following major components:
1. Memory Array
   -stores incoming data
   -implement using register
2. Write Pointer
   -Points to the next location where data will be written
3. Read Pointer
   -Points to the next location where data will be read
4. Control Logic
   -Generates Full and Empty flags

# FIFO OPERATION
1. Write Operation
   -Data is written when write enable (wr_en) is asserted
   -Write pointer increments
   -FIFO becomes full when memory is completely filled
2. Read Operation
   -Data is written when write enable (wr_en) is asserted
   -Write pointer increment
   -FIFO becomes full when memory is completely filled

3. Read Operation
   -Data is read when read enable (rd_en) is asserted
   -Read pointer increments
   -FIFO becomes empty when all data is read

# SIMULATION
The design is verified using a testbench which performs:
- FIFO reset
- Multiple write operations
- Multiple read operations
- Full condition check
- Empty condition check

# TOOLS USED
- Verilog
- EDA Playground

# APPLICATIONS
FIFO buffers are usually used in:
- UART communication
- Network pcket buffering
- processor pipelines
- data streaming systems

# FUTURE IMPROVEMNTS
- conecting thsi with previously coded ALU so FIFO store the output values of ALU
- Intergration with communication protocols

# AUTHOR
RTL Design & verification enthusiast 
