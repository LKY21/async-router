`timescale 1ns/1ps 
`include "split.v"

module split_tb;

reg RESET;

//input signal L
reg [1:0] L;
wire Le;

//input signal select
reg [1:0] sel;
wire sele;

//output signal R0
reg R0e;
wire [1:0] R0;

//output signal R1
reg R1e;
wire [1:0] R1;

PCHB_split DUT(L, Le, R0, R0e, R1, R1e, sel, sele, RESET);


initial
	begin
		$monitor( "Le = %b, SEL = %b, R0 = %b, R1 = %b", DUT.Le, DUT.SELECT, DUT.R0, DUT.R1);

		RESET=1;
		#2;
		RESET=0;
		#2;
///////////////////////
		L=2'b01;
		#1;
		
		R0e=1'b1;
		R1e=1'b1;		
		#1;
		sel=2'b01;
		#2;
		sel=2'b10;
		#4;
		
		L=2'b00;
		R0e=1'b0;
		R1e=1'b0;	
		
	end

endmodule
