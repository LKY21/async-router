`timescale 1ns/1ps

`include "macros.v"

module nor2_d (Z, A, B);
   input A;
   input B;
   output Z;
   nor #1 o0(Z,A,B);
endmodule

module or2_d (Z, A, B);
   input A;
   input B;
   output Z;
   or #1 o0(Z,A,B);
endmodule

module nor3_d (Z, A, B, C);
   input A;
   input B;
   input C;
   output Z;
   nor #1 o1(Z,A,B,C);
endmodule

module nor4_d (Z, A, B, C, D);
   input A;
   input B;
   input C;
   input D;
   output Z;
   nor #1 o1(Z,A,B,C,D);
endmodule

module nand4_d (Z, A, B, C, D);
   input A, B, C, D;
   output Z;
   nand #1 n0(Z,A,B, C, D);
endmodule

module nand2_d (Z, A, B);
   input A, B;
   output Z;
   nand #1 n0(Z,A,B);
endmodule

module and2_d (Z, A, B);
   input A, B;
   output Z;
   and #1 n0(Z,A,B);
endmodule

module inverter (Z, A);
   input A;
   output Z;
   not #1 n1(Z,A);
endmodule

module invcelement_r (Z, A, B, reset);
	
	input A;
	input B;
	input reset;
	
	output Z;
	reg Z;
	
	always @(A or B or reset)
	begin
	   if (reset)
	      #1 Z <=1;
	   else
	   begin	
		if (A==1 && B==1)
		   #1 Z <=0;
		else if (A==0 && B==0)
		   #1 Z <=1;
	   end
	end
endmodule 

module celement_r (Z, A, B, reset);
	
	input A;
	input B;
	input reset;
	
	output Z;
	reg Z;
	
	always @(A or B or reset)
	begin
	   if (reset)
	      #1 Z <=0;
	   else
	   begin	
		if (A==1 && B==1)
		   #1 Z <=1;
		else if (A==0 && B==0)
		   #1 Z <=0;
	   end
	end
endmodule 

module celement3_r (Z, A, B, C, reset);
	
	input A;
	input B;
	input C;
	input reset;
	
	output Z;
	reg Z;
	
	always @(A or B or C or reset)
	begin
	   if (reset)
	      #1 Z <=0;
	   else
	   begin	
		if (A==1 && B==1 && C==1)
		   #1 Z <=1;
		else if (A==0 && B==0 && C==0)
		   #1 Z <=0;
	   end
	end
endmodule

module invcelement3_r (Z, A, B, C, reset);
	
	input A;
	input B;
	input C;
	input reset;
	
	output Z;
	reg Z;
	
	always @(A or B or C or reset)
	begin
	   if (reset)
	      #1 Z <=1;
	   else
	   begin	
		if (A==1 && B==1 && C==1)
		   #1 Z <=0;
		else if (A==0 && B==0 && C==0)
		   #1 Z <=1;
	   end
	end
endmodule

module CSP_to_Oneof2(inprt,Le,L); // for inputs

	parameter N = 2;
	parameter WIDTH = 1;

	`USES_CHANNEL
	`INPORT(inprt,WIDTH)
	input Le;   
	output reg [N-1:0] L;
	
	reg [WIDTH-1:0] indata;

	initial
		L = 'b0;	

	always
	begin	
		wait(`PROBE(inprt));
		`RECEIVE(inprt, indata)
		wait(Le);
		L[indata] = 1'b1;	//Data Token
		wait(~Le);
		L = 'b0;		//Null Token
	end
endmodule

module Oneof2_to_CSP(R,Re,outprt);

	parameter N = 2;
	parameter WIDTH = 1;

	`USES_CHANNEL
	`OUTPORT(outprt,WIDTH)
	output reg Re;   
	input [N-1:0] R;
	
	reg outdata;
	
	initial
		Re = 1'b1;

	always
	begin
		wait(R[1] || R[0]);
		case(R)
		2'b01: outdata = 1'b0;
		2'b10: outdata = 1'b1;
		default:;
		endcase
		Re = 1'b0;
		`SEND(outprt, outdata)
		wait(~R[1] && ~R[0]);
		Re = 1'b1;
	end
endmodule