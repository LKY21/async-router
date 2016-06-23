`include "macros.v"
`include "router.v"
`include "bitbucket.v"

module router_tb();

  parameter WIDTH = 11;
	`USES_CHANNEL	
	`CHANNEL(c1,WIDTH)
	`CHANNEL(c2,WIDTH)	
	`CHANNEL(p,WIDTH)	
	
	`CHANNEL(c1out,WIDTH)
	`CHANNEL(c2out,WIDTH)	
	`CHANNEL(pout,WIDTH)
	
//	reg [WIDTH-1:0] C1OUT, C2OUT, POUT;
	
	
	router DUT(p, pout, c1, c1out, c2, c2out);
	
	bitbucket bb1(c1out);
	bitbucket bb2(c2out);
	bitbucket bb3(pout);
	
	
	initial
	begin
		$monitor("c1out=%b, c2out=%b, pout=%b", bb1.d, bb2.d, bb3.d);

   // c1 sends to c2, c2 sends to parent, parent sends to c0
	 fork
	 `SEND(c1,11'b00000000000)
	 `SEND(c2,11'b11111111111)
	 `SEND(p, 11'b01010101010)	
	
	 join

	 #1;
	 // c1 sends to c2, c2 sends to parent, parent sends to c1
	 fork
	 `SEND(c1,11'b11111111111)
	 `SEND(c2,11'b00000000000)
	 `SEND(p, 11'b11010101010)	
	 

	 join
	 #1;	 
	 // c1 sends to c2, c2 sends to parent, parent sends to c0
	 fork
	 `SEND(c1,11'b11111100000)
	 `SEND(c2,11'b00000011111)
	 `SEND(p, 11'b01010100000)	
	 

	 join
	 #1;	
	 // c1 and c2 both send to parent, parent sends to c0
	 fork
	 `SEND(c1,11'b01111111111)
	 `SEND(c2,11'b00000000000)
	 `SEND(p, 11'b01010101010)	
	 

	 join
	 #1;	 
	 
	 
	end
	
endmodule