module  baud_generator#(
  parameter CLK_FREQ=50_000_000,
  parameter BAUD_RATE = 9600)(
  input clk,
  input rst, 
  output reg baud_tick
);
 

 localparam BAUD_DIV = CLK_FREQ / BAUD_RATE ;
reg [$clog2(BAUD_DIV)-1:0]count;
 always@(posedge clk)begin
 if(rst)begin
 count<=0;
 baud_tick <=0;
 end
 else begin 
  if(count==(BAUD_DIV-1))begin
  count<= 0;
  baud_tick <=1;
  end
  else begin
  count <= count + 1;
  baud_tick <= 0;
  end
 end
 end
endmodule