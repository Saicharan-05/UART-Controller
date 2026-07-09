`timescale 1ns/1ps
module uart_tx_tb;
  reg tx_start;
  reg clk;
  reg rst;
  reg [7:0]tx_data;
  wire baud_tick;
  wire tx;
  wire tx_busy;
  wire tx_done;
  baud_generator baud_gen(.clk(clk),
  .rst(rst),
  .baud_tick(baud_tick)
  );
  uart_tx dut(.tx_start(tx_start),
  .rst(rst),
  .clk(clk),
  .baud_tick(baud_tick),
  .tx_data(tx_data),
  .tx(tx),
  .tx_busy(tx_busy),
  .tx_done(tx_done)
  );
  initial begin
    clk = 0;
    forever #10 clk = ~clk;
  end
  initial begin
    $dumpfile("sim/uart_tx.vcd");
    $dumpvars(0,uart_tx_tb);
    rst=1;
    tx_start = 0;
    tx_data = 8'h00;
    #40 rst =0;
    tx_data = 8'hA5;
    #40 tx_start = 1;
    #20 tx_start = 0;
    #2000000 $finish;
  end
  
endmodule