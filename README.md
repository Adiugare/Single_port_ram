# Single_port_ram
This project implements a 4x16 Synchronous Single-Port RAM in Verilog along with its testbench. 
The RAM is synchronous, meaning all operations (read and write) are triggered on the positive edge of the clock.

Module: sync_ram

Features:
Memory Size: 4 locations × 16 bits each (4x16).
Synchronous Operation: Both read and write occur on the rising edge of the clock.
Single-Port Design: A single port is used for both reading and writing.
Write Enable (we): Controls whether data is written into memory.
Read Mechanism: Data at the given address is always available on dout after the clock edge.

Port Description:

Port	Direction	Width	Description
clk	Input	1 bit	System clock (positive edge triggered).
we	Input	1 bit	Write enable. If high, data is written to memory.
addr	Input	2 bits	Address line to select one of the 4 memory locations.
din	Input	16 bits	Data input to be written when we=1.
dout	Output	16 bits	Data output from the selected memory location.

Internal Working:

The memory is modeled as a reg [15:0] mem[3:0]; array.
On every positive edge of the clock:
If we=1, the input data din is stored at the memory location addr.
Regardless of we, the content of mem[addr] is driven onto dout.

📌 Testbench: sync_ram_tb

Features:

Generates a clock with a period of 10 ns.
Provides tasks for initialization, delay, write, and read.
Performs the following sequence:
Write 1001 at address 10 and read it back.
Write 1101 at address 11 and read it back.

Displays all operations in the simulation console using $monitor.

Clock Generation:
always begin
    #5 clk = 1'b0;
    #5 clk = 1'b1;
end

This generates a 10ns clock period.

Write Task:

task write(input [1:0] a, input [15:0] d);
begin
    @(negedge clk);
    we = 1;
    addr = a;
    din = d;
    @(negedge clk);
    we = 0;
end
endtask

Writes data to memory at the falling edge of the clock, so it is available on the next rising edge.

Read Task:

task read(input [1:0] a);
begin
    @(negedge clk);
    addr = a;
end
endtask

Reads data from the selected address.

📊 Simulation Output (Example)

When simulated, the monitor will print:

Time=20 | we=1 addr=10 din=0000_0000_0000_1001 dout=0000_0000_0000_0000
Time=40 | we=0 addr=10 din=0000_0000_0000_1001 dout=0000_0000_0000_1001
Time=60 | we=1 addr=11 din=0000_0000_0000_1101 dout=0000_0000_0000_1001
Time=80 | we=0 addr=11 din=0000_0000_0000_1101 dout=0000_0000_0000_1101

This confirms that:

Data was successfully written to addresses 10 and 11.
Reads return the correct stored data.

✅ Conclusion

This design demonstrates a simple synchronous single-port RAM.
The testbench validates both write and read operations.
Useful as a building block for larger memory modules, register files, and FPGA-based designs.

🚀 Future Improvements

Parameterize the RAM size (ADDR_WIDTH and DATA_WIDTH).
Add asynchronous reset for clearing memory.
Extend design for dual-port RAM.
