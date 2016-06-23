`include "macros.v"
`include "buffer.v"

module BUF_TB;
  
  
  `USES_CHANNEL
  `CHANNEL(in,11) 
  `CHANNEL(out,11)
  
  reg [10:0] dataout;
  reg [10:0] datain;
  
  BUF buf_tb(in, out);
  
  initial
  begin
    
    datain = 11'b01010100101;   
    `SEND(in,datain)
    `RECEIVE(out,dataout)
    
    #10;
    
    datain = 9'b000011001110;   
    `SEND(in,datain)
    `RECEIVE(out,dataout)
    
    #10;
    
    datain = 9'b111111001101;   
    `SEND(in,datain)
    `RECEIVE(out,dataout)
    
    #10;
    
    datain = 9'b011110001000;   
    `SEND(in,datain)
    `RECEIVE(out,dataout)
    
  end

endmodule