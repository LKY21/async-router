`include "macros.v"
`include "leftshift.v"

module leftshift_tb;
  
  parameter width = 11;
  `USES_CHANNEL
  `CHANNEL(in,width) 
  `CHANNEL(out,width)
  
  reg [width-1:0] dataout;
  reg [width-1:0] datain;
  
  leftshift DUT(in, out);
  
  initial
  begin
    
    
    datain = 11'b01010100111;   
    `SEND(in,datain)
    `RECEIVE(out,dataout)
    
    #5;
    datain = 11'b11011100100;   
    `SEND(in,datain)
    `RECEIVE(out,dataout)
    
    
  end

endmodule