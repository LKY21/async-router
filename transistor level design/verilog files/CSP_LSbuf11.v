`timescale 1ns/1ps 
`include "lib.v"
`include "macros.v"
`include "CSP_BUF1.v"
`include "bitbucket1.v"
//`include "zerogen.v"

module CSP_LSbuf11( L, R, reset);

input reset;
parameter width = 11;
`USES_CHANNEL
`INPORT(L, width)
`OUTPORT(R, width)

reg [width-1:0] x, y;


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
//`CHANNEL(R6 , 1)
`CHANNEL(R7 , 1)
`CHANNEL(R8 , 1)
`CHANNEL(R9 , 1)
`CHANNEL(R10, 1)

`CHANNEL(bucket,1)
//`CHANNEL(zero,1)


// module CSP_BUF1( inport, outport, reset);
CSP_BUF1 b0  (  L0 , R0 , reset);
CSP_BUF1 b1  (  L1 , R1 , reset);
CSP_BUF1 b2  (  L2 , R2 , reset);
CSP_BUF1 b3  (  L3 , R3 , reset);
CSP_BUF1 b4  (  L4 , R4 , reset);
CSP_BUF1 b5  (  L5 , R5 , reset); //bits 0 to 5 are unaffected (data)

//routing information
CSP_BUF1 b6  (  L6 , R7 , reset);
CSP_BUF1 b7  (  L7 , R8 , reset);
CSP_BUF1 b8  (  L8 , R9 , reset);
CSP_BUF1 b9  (  L9 , R10 , reset);
CSP_BUF1 b10 (  L10, bucket, reset);

//bit bucket
bitbucket1 bb1( bucket );

//zero generator
//zerogen zg1( R6 );

always 
	begin
	y[6]=1'b0;
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
//	`RECEIVE( R6 , y[6 ] )
	`RECEIVE( R7 , y[7 ] )
	`RECEIVE( R8 , y[8 ] )
	`RECEIVE( R9 , y[9 ] )
	`RECEIVE( R10, y[10] )
	join
	`SEND(R, y)
	
	end

endmodule


