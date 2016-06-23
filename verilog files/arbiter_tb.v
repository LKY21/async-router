`include "macros.v"
`include "arbiter.v"

module arbiter_tb();
	parameter width = 1;
	`USES_CHANNEL;
	`CHANNEL(r1,width);
	`CHANNEL(r2,width);
	`CHANNEL(win,1);

ARB DUT(r1, r2, win);

reg [width-1:0] in1;
reg [width-1:0] in2;
reg w;

initial
	begin
	in1=1'b0;
	in2=1'b1;
	fork
	`SEND(r1, in1)
	`SEND(r2, in2) 
	`RECEIVE(win, w)
	join
	#1;
	`RECEIVE(win,w)
	
#5;

	fork
	`SEND(r1, in1)
	`SEND(r2, in2) 
	`RECEIVE(win, w)
	join
	#1;
	`RECEIVE(win,w)
	
#5;

	fork
	`SEND(r1, in1)
//	`SEND(r2, in2) 
	`RECEIVE(win, w)
	join
	#1;
//	`RECEIVE(win,w)
	
#5;

/*
	fork
	`SEND(r1, in1)
	`SEND(r2, in2) 
	`RECEIVE(win, w)
	join
#10;
  in1=9'b101010101;
	in2=9'b000011111;
	fork
	`SEND(r1, in1)
	`SEND(r2, in2) 
	`RECEIVE(win, w)
	join
#10;
  in1=9'b101010101;
	in2=9'b000011111;
	fork
	`SEND(r1, in1)
	`SEND(r2, in2) 
	`RECEIVE(win, w)
	join
#10;
  in1=9'b101010101;
	in2=9'b000011111;
	fork
	`SEND(r1, in1)
//	`SEND(r2, in2) 
	`RECEIVE(win, w)
	join
#10;
  in1=9'b101010101;
	in2=9'b000011111;
	fork
//	`SEND(r1, in1)
	`SEND(r2, in2) 
	`RECEIVE(win, w)
	join
#10;
  in1=9'b101010101;
	in2=9'b000011111;
	`SEND(r1, in1)
	#1;
	`SEND(r2, in2) 
	`RECEIVE(win, w)
#10;
	*/	
	end //initial block
endmodule