`include "macros.v"
`include "CSP_cBUF11.v"
`include "bitbucket11.v"
module CSP_cBUF11_TB;
  
  parameter width=11;
  `USES_CHANNEL
  `CHANNEL(in,width) 
  `CHANNEL(out,width)
  `CHANNEL(req,1)
  
  reg [width-1:0] dataout;
  reg [width-1:0] datain;
  reg r;
  reg reset;
  
  
CSP_cBUF11 DUT( in, out, req, reset);  
bitbucket11 bb1(out);
bitbucket1 bb2(req);

  initial
  begin
    
	$monitor ("out=%b, req=%b", bb1.d, bb2.d);
	
	reset=1;
	#2;
	reset=0;
	#2;
	
    datain = 11'b00000000000;   
    `SEND(in,datain)

    #10;
    
    datain = 11'b11111111111;   
    `SEND(in,datain)

    #10;
 
    datain = 11'b10101010101;   
    `SEND(in,datain)

    #10; 


  end

endmodule