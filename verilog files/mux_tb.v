`include "macros.v"
`include "mux.v"

module MUX_TB;
  
  `USES_CHANNEL
  `CHANNEL(in1,11) 
  `CHANNEL(in2,11)
  `CHANNEL(out,11)
  `CHANNEL(s,1)
  
  reg [10:0] dataout;
  reg [10:0] datain1;
  reg [10:0] datain2;
  reg select;
  
  MUX mux_tb(in1, in2, s, out);
  
  initial
  begin
    
    datain1 = 11'b00111000001;   
    datain2 = 11'b00001001110;
    select = 1'b0;
    fork
    `SEND(in1,datain1)
  //  `SEND(in2,datain2)
    `SEND(s,select)
    join
    `RECEIVE(out, dataout)
    
    #10;
    
    datain1 = 11'b11111111111;   
    datain2 = 11'b00000000000;
    select = 1'b1;
    fork
//    `SEND(in1,datain1)
    `SEND(in2,datain2)
    `SEND(s,select)
    join
    `RECEIVE(out, dataout)
    
    #10;
    
    datain1 = 11'b00000111111;   
    datain2 = 11'b11111000000;
    select = 1'b1;
    fork
//    `SEND(in1,datain1)
    `SEND(in2,datain2)
    `SEND(s,select)
    join
    `RECEIVE(out, dataout)
    
    #10;
    
    datain1 = 11'b11111011111;   
    datain2 = 11'b00000100000;
    select = 1'b0;
    fork
    `SEND(in1,datain1)
//    `SEND(in2,datain2)
    `SEND(s,select)
    join
    `RECEIVE(out, dataout)
    
  end

endmodule
