module sync_ram(
input clk,we,
input [1:0] addr,
input [15:0] din,
output reg[15:0]dout);

reg [15:0] mem[3:0];

always @(posedge clk)begin
    if(we)
    mem[addr]<=din;
    dout<=mem[addr];
    end

endmodule
