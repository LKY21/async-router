`timescale 1ns/1ps 
`include "macros.v"
`include "CSP_split11.v"
`include "bitbucket11.v"

module CSP_split11_TB;
  
  parameter width = 11;
  `USES_CHANNEL
  `CHANNEL(in,width) 
  `CHANNEL(out1,width)
  `CHANNEL(out2,width)

  reg [10:0] datain;
 // reg [10:0] dataout1;
 // reg [10:0] dataout2;
  
  reg reset;
  
  CSP_split11 split_tb(in, out1, out2, reset);
  bitbucket11 bb1(out1);
  bitbucket11 bb2(out2);
  
  initial
  begin
  
  $monitor ("out1=%b, out2=%b", bb1.d, bb2.d);
  
    reset = 1;
	#2;
	reset = 0;
	
    datain = 11'b10111000111;   
    `SEND(in,datain)
//    `RECEIVE(out1, dataout1)
 //   `RECEIVE(out2, dataout2)
    
    #10;
     
    datain = 11'b00000000001;   
    `SEND(in,datain)
//    `RECEIVE(out1, dataout1)
//    `RECEIVE(out2, dataout2)
    
    #10;
    
     
    datain = 11'b00000111101;   
    `SEND(in,datain)
 //   `RECEIVE(out1, dataout1)
//    `RECEIVE(out2, dataout2)
    
    #10;
    
     
    datain = 11'b11111111111;   
    `SEND(in,datain)
 //   `RECEIVE(out1, dataout1)
//    `RECEIVE(out2, dataout2)

    #10;
    
     
    datain = 11'b00000000000;   
    `SEND(in,datain)
 //   `RECEIVE(out1, dataout1)
//    `RECEIVE(out2, dataout2)
  end

endmodule