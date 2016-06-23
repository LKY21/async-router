`include "macros.v"
`include "CSP_split1.v"
`include "bitbucket.v"

module CSP_split1_TB;
  
  parameter width = 1;
  `USES_CHANNEL
  `CHANNEL(in,width) 
  `CHANNEL(out1,width)
  `CHANNEL(out2,width)
  `CHANNEL(select,width) 

  reg datain;
  reg sel; 
  // reg [10:0] dataout1;
 // reg [10:0] dataout2;
  
  reg reset;
  
  CSP_split1 split_tb(in, out1, out2, select, reset);
  bitbucket bb1(out1);
  bitbucket bb2(out2);
  
  initial
  begin
  
  $monitor ("out1=%b, out2=%b", bb1.d, bb2.d);
  
    reset = 1;
	#2;
	reset = 0;
	#2;
    datain = 1'b1;   
	sel=1'b1;
    `SEND(in,datain)
	`SEND(select,sel)

//    `RECEIVE(out1, dataout1)
 //   `RECEIVE(out2, dataout2)
    
    #10;
     
    datain = 1'b0;  
		sel=1'b0;
    `SEND(in,datain)
	`SEND(select,sel)

//    `RECEIVE(out1, dataout1)
//    `RECEIVE(out2, dataout2)
    
    #10;
    
     
    datain = 1'b0;  
		sel=1'b0;
    `SEND(in,datain)
	`SEND(select,sel)	
 //   `RECEIVE(out1, dataout1)
//    `RECEIVE(out2, dataout2)
    
  end

endmodule