`timescale 1ns/1ps

module baud_gen_tb;
reg clk;
reg rst;
wire baud_tick;
baud_generator dut(.clk(clk),.rst(rst),.baud_tick(baud_tick));
initial begin
clk=0;
forever #10 clk = ~clk;
end
initial begin
  $dumpfile("baud_gen.vcd");
  $dumpvars(0,baud_gen_tb);
  
  rst =1;
  
  #40 rst = 0;
  #250000 $finish;
end
always@(posedge baud_tick)
$display("Baud tick at time = %0t",$time);
endmodule

