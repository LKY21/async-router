`include "macros.v"
`include "cbuf.v"

module cBUF_TB;
  
  
  `USES_CHANNEL
  `CHANNEL(in,11) 
  `CHANNEL(out,11)
  `CHANNEL(req,1)
  
  reg [10:0] dataout;
  reg [10:0] datain;
  reg r;
  
  cBUF DUT(in, out, req);
  
  initial
  begin
    
    datain = 9'b01010100100;   
    `SEND(in,datain)
    fork
    `RECEIVE(out,dataout)
    `RECEIVE(req,r)    
    join
    #10;
    
    datain = 9'b00001100111;   
    `SEND(in,datain)
    fork
    `RECEIVE(out,dataout)
     `RECEIVE(req,r)    
    join
    #10;
    
    datain = 9'b11111100101;   
    `SEND(in,datain)
    
    `RECEIVE(req,r)
    `RECEIVE(out,dataout)
         
    #10;
    
    datain = 9'b01111000110;   
    `SEND(in,datain)
    `RECEIVE(req,r) 
    `RECEIVE(out,dataout)
  end

endmodule