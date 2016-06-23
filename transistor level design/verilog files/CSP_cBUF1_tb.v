`include "macros.v"
`include "CSP_cBUF1.v"
`include "bitbucket1.v"
module CSP_cBUF1_TB;
  
  
  `USES_CHANNEL
  `CHANNEL(in,1) 
  `CHANNEL(out,1)
  `CHANNEL(req,1)
  
  reg dataout;
  reg datain;
  reg r;
  reg reset;
  
  
CSP_cBUF1 DUT( in, out, req, reset);  
bitbucket1 bb1(out);
bitbucket1 bb2(req);

  initial
  begin
    
	$monitor ("out=%b, req=%b", bb1.d, bb2.d);
	
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