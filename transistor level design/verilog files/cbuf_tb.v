`timescale 1ns/1ps 
`include "cbuf.v"

module cbuf_tb;

reg RESET;

//input signal L
reg [1:0] L;
wire Le;

//output signal R
reg Re;
wire [1:0] R;

//output signal d
reg De;
wire D;


PCHB_cBUF DUT(L, Le, R, Re, D, De, RESET);

initial
	begin
		$monitor( "Le = %b, R = %b, D = %b", DUT.le, DUT.r, DUT.d);

		RESET=1;
		#2;
		RESET=0;
		#2;
///////////////////////
		L=2'b01;
		#1;
		
		Re=1'b1;
		De=1'b1;
		#1;
	/*
		L=2'b00;
		#1;
		
		Re=1'b0;
		De=1'b0;
		#1;
	*/
	
		L=2'b10;
		#1;
		
		Re=1'b1;
		De=1'b1;
		#1;		
	end

endmodule
