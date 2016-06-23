`timescale 1ns/1ps 
`include "lib.v"

module PCHB_BUF(L,Le,R,Re,RESET);

input Re,RESET;
input [1:0] L;
output Le,R;
reg[1:0] R;
wire Le; 

wire lv,rv;

reg[1:0] temp;

or2_d  or_i0(.Z(lv),.A(L[0]),.B(L[1]));  //inputs L valid
nand2_d  nand_i0(.Z(rv),.A(temp[0]),.B(temp[1])); //output R valid
invcelement_r invcelement_i0(.Z(Le),.A(lv),.B(rv),.reset(RESET));  //completion signal

 initial
 begin
 R <= 2'b00;
 temp <= 2'b11;
 end
  
 
 always@(*)
 begin
 
   if(RESET == 1)
	  begin
	  R <= #2 2'b00;
	  temp <= #1 2'b11;
	  end
 
  else //if (RESET == 0)
  begin
   
   if(Re == 0 && Le == 0)
   begin
   R <= #2 2'b00;
   temp <= #1 2'b11;
   end
   else if (Re == 1 && Le == 1)
   begin
   R <= #2 L ;
   temp <= #1 (~L);
   end
  end
 end

endmodule