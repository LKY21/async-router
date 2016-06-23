`timescale 1ns/1ps 
`include "lib.v"

module PCHB_cBUF(l, le, r, re, d, de, RESET);

input RESET;

//input signal l
input [1:0] l;
output le;

//output signal r
output [1:0] r;
input re;

//output signal d
output d;
input de;

//internal signals
wire lvalid, rvalid, nle, ndv, en, nen, int;


reg[1:0] r, temp;

or2_d or1( lvalid, l[0], l[1] ); //lvalid signal
invcelement_r invc1( int, en, lvalid, RESET);
invcelement_r invc2( nle, int, ndv, RESET);
inverter inv1(le, nle);
invcelement_r invc3( nen, nle, ndv, RESET);
inverter inv2(en, nen); // internal en signal

nand2_d  nand_1( rvalid, temp[0], temp[1] );  //rvalid signal
invcelement_r invc4( ndv, de, rvalid, RESET);
inverter inv3(d, ndv); //d output signal



initial
 begin
 r <= 2'b00;
 temp <= 2'b11;
 end
  
 
always@(*)
 begin
  if(RESET == 1)
  begin
  r <= #2 2'b00;
  temp <= #1 2'b11;
  end 
 
  else if (RESET == 0)
  begin
   
   if(en == 0 && re == 0)
   begin
   r <= #2 2'b00;
   temp <= #1 2'b11;
   end
   else if (en == 1 && re == 1)
   begin
   r <= #2 l ;
   temp <= #1 (~l);
   end
  end
 end



endmodule