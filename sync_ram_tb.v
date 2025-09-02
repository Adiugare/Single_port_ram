
module sync_ram_tb();
reg clk,we;
reg [1:0] addr;
reg [15:0] din;
wire [15:0] dout;

sync_ram dut(.clk(clk),.we(we),.addr(addr),.din(din),.dout(dout));

always begin
#5;
clk=1'b0;
#5; clk=1'b1;
end

task initialize();
begin
we=1'b0; din=1'b0; addr=1'b0;
end
endtask

task delay();
begin
#10;
end
endtask

task write(input[1:0] a, input [15:0] d);
begin
@(negedge clk);
we=1;
addr=a;din=d;
@(negedge clk);
we=0;
end
endtask

task read(input [1:0] a);
begin
@(negedge clk);
addr=a;
end
endtask

initial begin
initialize;
write(2'b10,16'b1001);
read(2'b10);
delay;
write(2'b11,16'b1101);
read(2'b11);
#20 $finish;
end

initial
$monitor("Time=%0t | we=%b addr=%b din=%b dout=%b",$time,we,addr,din,dout);
endmodule
