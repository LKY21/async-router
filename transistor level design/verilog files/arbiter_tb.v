`timescale 1ns/1ps 
`include "arbiter.v"

module arbiter_tb;

reg RESET;

//input signal L0
reg [1:0] L0;
wire L0e;

//input signal L1
reg [1:0] L1;
wire L1e;

//output signal R
reg Re;
wire [1:0] R;

PCHB_arbiter DUT(L0, L0e, L1, L1e, R, Re, RESET);


initial
	begin
		$monitor( "L0e = %b, L1e = %b, R = %b", DUT.L0e, DUT.L1e, DUT.R);

		RESET=1;
		#2;
		RESET=0;
		#2;
///////////////////////

		L0=2'b10;
		L1=2'b10;
		#1;
		
		Re=1'b1;
		#2;
		
		/*
		//set neutrality
		L0=1'b0;
		Re=1'b0;
		#2;
		Re=1'b1;
		*/
		
		L0=2'b00;
		Re=1'b0;
		#2;
		
		Re=1'b1;
	end

endmodule
