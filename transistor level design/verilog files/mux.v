`timescale 1ns/1ps 
`include "lib.v"

module PCHB_mux(L0, L0e, L1, L1e, SELECT, SELECTe, R, Re, RESET);

input RESET;

//input L0
input [1:0] L0;
output L0e;

//input L1
input [1:0] L1;
output L1e;

//select input
input [1:0] SELECT;
output SELECTe;

//output R
output R;
input Re;

//internal registers
reg[1:0] R;
reg[1:0] temp;

//internal signals
wire Rv, L0v, L1v, SELv;

or2_d L0_valid_or( L0v, L0[0], L0[1] ); //L0 input valid
or2_d L1_valid_or( L1v, L1[0], L1[1] ); //L1 input valid
or2_d SELECT_valid_or( SELv, SELECT[0], SELECT[1] ); //SELECT input valid
nand2_d  R_valid_nand( Rv, temp[0], temp[1] ); //R output valid

invcelement3_r L0e_invc(L0e, L0v, SELECT[0], Rv, RESET);
invcelement3_r L1e_invc(L1e, L1v, SELECT[1], Rv, RESET);

and2_d SELECTe_and(SELECTe, L0e, L1e);


initial
 begin
 R <= 2'b00;
 temp <= 2'b11;
 end
 
always@(*)
 begin

  if(RESET == 1)
	  begin
	  R <= 2'b00;
	  temp <= 2'b11;
	  end  
  
  else if (RESET == 0)
  begin
   
   if(SELECTe == 0 && Re == 0)
	   begin
	   R <= 2'b00;
	   temp <= 2'b11;
	   end
   else if(SELECTe==1 && Re==1)
   	begin 
	   if ( (SELECT[0]==1 && L0[0]==1) || (SELECT[1]==1 && L1[0]==1) )
		   begin
		   R[0] <= 1'b1;
		   temp[0] <= 1'b0;
		   end
	   else
		   begin
		   R[0] <= R[0];
		   temp[0] <= temp[0];	   
		   end
	   
	   
	   if ( (SELECT[0]==1 && L0[1]==1) || (SELECT[1]==1 && L1[1]==1) )
		   begin
		   R[1] <= 1'b1;
		   temp[1] <= 1'b0;
		   end
	   else
		   begin
		   R[1] <= R[1];
		   temp[1] <= temp[1];
		   end	   
	   
   end
 
  end //if reset==0
 end //always block

endmodule