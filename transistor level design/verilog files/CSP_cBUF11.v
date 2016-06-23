`timescale 1ns/1ps 
`include "lib.v"
`include "macros.v"
`include "CSP_cBUF1.v"

module CSP_cBUF11( L, R, C, reset);

input reset;
parameter width = 11;
`USES_CHANNEL
`INPORT(L, width)
`OUTPORT(R, width)
`OUTPORT(C, 1)

reg [width-1:0] x, y, d;


`CHANNEL(L0 , 1)
`CHANNEL(L1 , 1)
`CHANNEL(L2 , 1)
`CHANNEL(L3 , 1)
`CHANNEL(L4 , 1)
`CHANNEL(L5 , 1)
`CHANNEL(L6 , 1)
`CHANNEL(L7 , 1)
`CHANNEL(L8 , 1)
`CHANNEL(L9 , 1)
`CHANNEL(L10, 1)

`CHANNEL(R0 , 1)
`CHANNEL(R1 , 1)
`CHANNEL(R2 , 1)
`CHANNEL(R3 , 1)
`CHANNEL(R4 , 1)
`CHANNEL(R5 , 1)
`CHANNEL(R6 , 1)
`CHANNEL(R7 , 1)
`CHANNEL(R8 , 1)
`CHANNEL(R9 , 1)
`CHANNEL(R10, 1)

`CHANNEL(C0 , 1)
`CHANNEL(C1 , 1)
`CHANNEL(C2 , 1)
`CHANNEL(C3 , 1)
`CHANNEL(C4 , 1)
`CHANNEL(C5 , 1)
`CHANNEL(C6 , 1)
`CHANNEL(C7 , 1)
`CHANNEL(C8 , 1)
`CHANNEL(C9 , 1)
`CHANNEL(C10, 1)

// module CSP_cBUF1( L, R, c, reset);
CSP_cBUF1 cb0  (  L0 , R0 , C0 , reset);
CSP_cBUF1 cb1  (  L1 , R1 , C1 , reset);
CSP_cBUF1 cb2  (  L2 , R2 , C2 , reset);
CSP_cBUF1 cb3  (  L3 , R3 , C3 , reset);
CSP_cBUF1 cb4  (  L4 , R4 , C4 , reset);
CSP_cBUF1 cb5  (  L5 , R5 , C5 , reset);
CSP_cBUF1 cb6  (  L6 , R6 , C6 , reset);
CSP_cBUF1 cb7  (  L7 , R7 , C7 , reset);
CSP_cBUF1 cb8  (  L8 , R8 , C8 , reset);
CSP_cBUF1 cb9  (  L9 , R9 , C9 , reset);
CSP_cBUF1 cb10 (  L10, R10, C10, reset);

always 
	begin
	
	`RECEIVE(L,x)
	fork
	`SEND( L0 , x[0 ] ) //send individual input bits
	`SEND( L1 , x[1 ] )
	`SEND( L2 , x[2 ] )
	`SEND( L3 , x[3 ] )
	`SEND( L4 , x[4 ] )
	`SEND( L5 , x[5 ] )
	`SEND( L6 , x[6 ] )
	`SEND( L7 , x[7 ] )
	`SEND( L8 , x[8 ] )
	`SEND( L9 , x[9 ] )
	`SEND( L10, x[10] )
	join
	
	fork
	`RECEIVE( R0 , y[0 ] ) //receive individual output Y bits
	`RECEIVE( R1 , y[1 ] )
	`RECEIVE( R2 , y[2 ] )
	`RECEIVE( R3 , y[3 ] )
	`RECEIVE( R4 , y[4 ] )
	`RECEIVE( R5 , y[5 ] )
	`RECEIVE( R6 , y[6 ] )
	`RECEIVE( R7 , y[7 ] )
	`RECEIVE( R8 , y[8 ] )
	`RECEIVE( R9 , y[9 ] )
	`RECEIVE( R10, y[10] )
	
	`RECEIVE( C0 , d[0 ] ) //receive individual output C bits
	`RECEIVE( C1 , d[1 ] )
	`RECEIVE( C2 , d[2 ] )
	`RECEIVE( C3 , d[3 ] )
	`RECEIVE( C4 , d[4 ] )
	`RECEIVE( C5 , d[5 ] )
	`RECEIVE( C6 , d[6 ] )
	`RECEIVE( C7 , d[7 ] )
	`RECEIVE( C8 , d[8 ] )
	`RECEIVE( C9 , d[9 ] )
	`RECEIVE( C10, d[10] )	
	join
	fork
	`SEND(R, y)
	`SEND(C, d[0])
	join
	end

endmodule


