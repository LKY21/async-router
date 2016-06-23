`timescale 1ns/1ps 
`include "lib.v"
`include "mutex.v"

module PCHB_arbiter(L0, L0e, L1, L1e, R, Re, RESET);
   
	input RESET;
	   
	//input L0
	input[1:0] L0; 		
	output L0e;
	
	//input L1
	input[1:0] L1;			
	output L1e;
	
	//output R
	output R;
	input Re;
   
	//internal registers
	reg[1:0] R;
	wire[1:0] Rtemp;
	//internal signals
	wire en;

	//Mutual exclusive arbitration element
   mutex mutex1(L0[1], L1[1], Rtemp[0], Rtemp[1], RESET);


   
   invcelement_r L0e_c(L0e, L0[1], R[0], RESET);
   invcelement_r L1e_c(L1e, L1[1], R[1], RESET);
   and2_d en_and(en, L0e, L1e);

   always@(*)
		begin
			if(RESET==1)
				begin
				R <= 2'b00;
				end
			else //if RESET==0
				begin
					if (en==1 && Re==1)
						begin
						R[0] <= Rtemp[0];
						R[1] <= Rtemp[1];
						end
					else if (en==0 && Re==0)
						begin
						R <= 2'b00;
						end
				end
		end
		
           
endmodule