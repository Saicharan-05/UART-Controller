module uart_tx  (
  input tx_start,
  input clk,
  input rst,
  input [7:0]tx_data,
  input baud_tick,
  output reg tx,
  output reg tx_busy,
  output reg tx_done
);
reg [2:0]bit_count;
reg [7:0]shift_register;
reg [1:0]state;


//state encoding
localparam IDLE = 2'b00,
           START = 2'b01,
           DATA = 2'b10,
           STOP = 2'b11;
always @(posedge clk or 
           posedge rst) begin
    if(rst)begin
        state <= IDLE;
        bit_count <= 3'b0;
        shift_register <= 8'b0;
      end
    else begin
      tx_done<=1'b0;
      case (state)
        IDLE:begin
          tx <= 1'b1;
          tx_busy <= 1'b0;
           if(tx_start)begin
            shift_register <= tx_data;
            bit_count<=3'd0;
            state<=START;
           end
         end 
        START:begin
         tx_busy <= 1'b1;
         tx <= 1'b0;
         if(baud_tick)
          state <= DATA;
        end
        DATA:begin
          tx_busy<=1'b1;
          tx <= shift_register[0];
         if(baud_tick)begin
           shift_register <= shift_register>>1;
          if(bit_count==3'd7)
           state <= STOP;
          else 
            bit_count <= bit_count+1;
          end
          end
        STOP:begin
          tx <= 1'b1;
          tx_busy <= 1'b1;       
          if(baud_tick)begin
            tx_done <= 1'b1;
            state <= IDLE;
          end
        end
        endcase
        end
     end 
          
endmodule

