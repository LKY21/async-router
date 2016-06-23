`timescale 1ns/1ps 
`include "macros.v"
`include "CSP_mux11.v"
`include "bitbucket11.v"

module CSP_mux11_TB;
  
  parameter width = 11;
  `USES_CHANNEL
  `CHANNEL(in1,width) 
  `CHANNEL(in2,width) 
  `CHANNEL(s,1)
  `CHANNEL(out,width)

  reg [width-1:0] datain1, datain2;
  reg select;
  reg reset;
  
  // module CSP_mux11(X,Y,C,Z,reset);
  CSP_mux11 mux_tb(in1, in2, s, out, reset);
  bitbucket11 bb1(out);
 
  initial
  begin
  
  $monitor ("out=%b", bb1.d);
  
    reset = 1;
	#2;
	reset = 0;
	
    datain1 = 11'b00111000001;   
    datain2 = 11'b00001001110;
    select = 1'b0;
    fork
    `SEND(in1,datain1)
  //  `SEND(in2,datain2)
    `SEND(s,select)
    join
    
    #10;
    
    datain1 = 11'b11111111111;   
    datain2 = 11'b00000000000;
    select = 1'b1;
    fork
//    `SEND(in1,datain1)
    `SEND(in2,datain2)
    `SEND(s,select)
    join
    
    #10;
    
    datain1 = 11'b00000111111;   
    datain2 = 11'b11111000000;
    select = 1'b1;
    fork
//    `SEND(in1,datain1)
    `SEND(in2,datain2)
    `SEND(s,select)
    join
    
    #10;
    
    datain1 = 11'b11111011111;   
    datain2 = 11'b00000100000;
    select = 1'b0;
    fork
    `SEND(in1,datain1)
//    `SEND(in2,datain2)
    `SEND(s,select)
    join

	
	
  end

endmodule