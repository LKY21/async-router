`include "macros.v"
`include "CSP_buf1.v"
`include "bitbucket1.v"
module CSP_BUF1_TB;
  
  
  `USES_CHANNEL
  `CHANNEL(in,1) 
  `CHANNEL(out,1)
  
  reg datain;
  reg reset;
  
  
CSP_BUF1 DUT( in, out, reset);  
bitbucket1 bb1(out);

  initial
  begin
    
	$monitor ("out=%b", bb1.d);
	
	reset=1;
	#2;
	reset=0;
	#2;
	
    datain = 1'b0;   
    `SEND(in,datain)

    #10;
    
    datain = 1'b1;   
    `SEND(in,datain)

    #10;
 
    datain = 1'b1;   
    `SEND(in,datain)

    #10; 


  end

endmodule