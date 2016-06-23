`include "macros.v"
`include "CSP_arbiter1.v"
`include "bitbucket1.v"

module CSP_arbiter1_tb;
	parameter width = 1;
	`USES_CHANNEL;
	`CHANNEL(r1,width);
	`CHANNEL(r2,width);
	`CHANNEL(win,1);



reg reset;
reg  in1;
reg  in2;
//reg  w;

CSP_arbiter1 arb_DUT(r1, r2, win, reset);	
	
bitbucket1 bb1(win);

initial
	begin
	
	  $monitor ("out=%b", bb1.d);
reset = 1;
#2;
reset=0;
#2;
	in1=1'b1;
	in2=1'b1;
	fork
	`SEND(r1, in1)
	`SEND(r2, in2) 
	join
	#1;
	
#5;

	fork
	`SEND(r1, in1)
	`SEND(r2, in2) 
	join
	#1;
	
#5;

	`SEND(r1, in1)
//	`SEND(r2, in2) 

	
	#1;
//`SEND(r2, in2) 
//`SEND(r2, in2) 
//`SEND(r2, in2) 
//`SEND(r2, in2) 
	
#5;


	end //initial block
endmodule