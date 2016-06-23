`timescale 1ns/1ps
`include "macros.v"
`include "CSP_mux1.v"
`include "bitbucket1.v"

module CSP_mux1_TB;
  
  parameter width = 1;
  `USES_CHANNEL
  `CHANNEL(in1,width) 
  `CHANNEL(in2,width)
  `CHANNEL(out,width)
  `CHANNEL(select,width) 

  reg datain1, datain2;
  reg sel;   
  reg reset;
  reg dataout;
  
  CSP_mux1 DUT(in1, in2, select, out, reset);
   bitbucket1 bb1(out);
  
  initial
  begin
  
  $monitor ("out=%b", bb1.d);
  
  reset = 1;
	#10;
	reset = 0;
	#10;
	
	// test1
	
    datain1 = 1'b0;  
    datain2 = 1'b1;   
	  sel=1'b1;
	
	fork
    `SEND(in1,datain1)
    `SEND(in2,datain2)
	  `SEND(select,sel)
  join
  //  `RECEIVE(out,dataout)
    
    #10;
    
  // test2
  
    datain1 = 1'b0;  
    datain2 = 1'b1;   
		sel=1'b0;
	
	fork
  //  `SEND(in1,datain1)
  //  `SEND(in2,datain2)
	  `SEND(select,sel)
  join
  //  `RECEIVE(out,dataout)
    
    #10;
    
  // test3
  
    datain1 = 1'b0;  
    datain2 = 1'b1;   
	  sel=1'b1;
	
	fork
    `SEND(in1,datain1)
    `SEND(in2,datain2)
    `SEND(select,sel)
  join
  //  `RECEIVE(out,dataout)

    #10;
  
  //test4
  
    datain1 = 1'b0;  
    datain2 = 1'b1;   
	  sel=1'b0;
	
	fork
    `SEND(in1,datain1)
    `SEND(in2,datain2)
    `SEND(select,sel)
  join
  //  `RECEIVE(out,dataout)
      
  end

endmodule