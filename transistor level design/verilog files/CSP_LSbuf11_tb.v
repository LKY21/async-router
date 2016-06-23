`include "macros.v"
`include "CSP_LSbuf11.v"
`include "bitbucket11.v"
module CSP_LSbuf11_TB;
  
  parameter width=11;
  `USES_CHANNEL
  `CHANNEL(in,width) 
  `CHANNEL(out,width)
  
  reg [width-1:0] datain;
  reg reset;
  
CSP_LSbuf11 DUT( in, out, reset);

bitbucket11 bb1(out);

  initial
  begin
    
	$monitor ("out=%b", bb1.d);
	
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