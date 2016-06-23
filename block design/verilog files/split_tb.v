`include "macros.v"
`include "split.v"

module SPL_TB;
  
  parameter width = 11;
  `USES_CHANNEL
  `CHANNEL(in,width) 
  `CHANNEL(out1,width)
  `CHANNEL(out2,width)

  reg [10:0] datain;
  reg [10:0] dataout1;
  reg [10:0] dataout2;
  
  SPL split_tb(in, out1, out2);
  
  initial
  begin
    
    datain = 11'b10111000111;   
    `SEND(in,datain)
//    `RECEIVE(out1, dataout1)
    `RECEIVE(out2, dataout2)
    
    #10;
     
    datain = 11'b00000000001;   
    `SEND(in,datain)
    `RECEIVE(out1, dataout1)
//    `RECEIVE(out2, dataout2)
    
    #10;
    
     
    datain = 11'b00000111101;   
    `SEND(in,datain)
    `RECEIVE(out1, dataout1)
//    `RECEIVE(out2, dataout2)
    
  end

endmodule