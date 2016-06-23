`include "macros.v"
`timescale 1ns / 1ps

module MUX(X,Y,C,Z);
  
  parameter width = 11;
  `INPORT(X, width)  //input 1
  `INPORT(Y, width)  //input 2
  `INPORT(C, 1) 	 //select bit
  `OUTPORT(Z, width) //output
  `USES_CHANNEL

  reg [width-1:0] d1;
  reg [width-1:0] d2;
  reg select;
  
  always begin
    
  `RECEIVE(C, select)
  
/*  
  wait(`PROBE(X) || `PROBE(Y) );
 
  if(`PROBE(X) && `PROBE(Y))
  	begin
  	`RECEIVE(X,d1)
  	`RECEIVE(Y,d2)
	end
  else if(`PROBE(X))
	`RECEIVE(X,d1)
  else
	`RECEIVE(Y,d2)
	*/
	
	if (select==0)
		begin
	//	wait(`PROBE(X));
		//if(`PROBE(X))
			//begin
	  	`RECEIVE(X,d1) 
		  `SEND(Z, d1)
	  	//end
	  end
	else
		begin
//		wait(`PROBE(Y));
		//if(`PROBE(Y))
			//begin
			`RECEIVE(Y,d2)	
		  `SEND(Z, d2)
	  	//end
	  end
	end
	
endmodule

