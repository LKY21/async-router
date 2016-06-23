`timescale 1ns/1ps 
`include "lib.v"

module PCHB_split(L, Le, R0, R0e, R1, R1e, SELECT, SELECTe, RESET);

input RESET;

//input L
input [1:0] L;
output Le;

//select input
input [1:0] SELECT;
output SELECTe;

//first output
output R0;
input R0e;

//second output
output R1;
input R1e;

//internal registers
reg[1:0] R0, R1;
reg[1:0] temp0, temp1;

//internal signals
wire R0v, R1v, Lv, SELv, outputsv;
wire nLe,  nSELECTe;
wire en;

or2_d L_valid_or( Lv, L[0], L[1] ); //L input valid
or2_d SEL_valid_or( SELv, SELECT[0], SELECT[1] ); //SELECT input valid
nand2_d  R0_valid_nand( R0v, temp0[0], temp0[1] ); //R0 output valid
nand2_d  R1_valid_nand( R1v, temp1[0], temp1[1] ); //R1 output valid

or2_d output_valid_or( outputsv, R0v, R1v ); //outputs valid
celement_r nLe_c(nLe, Lv, outputsv, RESET);
celement_r nSELe_c(nSELECTe, SELv, outputsv, RESET);

invcelement_r en_invc(en, nLe, nSELECTe, RESET);


inverter inv1(Le, nLe);
inverter inv2(SELECTe, nSELECTe);


initial
 begin
 R0 <= 2'b00;
 R1 <= 2'b00;
 temp0 <= 2'b11;
 temp1 <= 2'b11;
 end
  
always@(*)
 begin
 	if (RESET == 1)
 		begin
		R0 <= 2'b00;
		R1 <= 2'b00;
		temp0 <= 2'b11;
		temp1 <= 2'b11;
  	end 		
  else if (RESET == 0)
  	begin  		
		if (en==0)
			begin
				if(R0e==0)
					begin
	   			R0 <= 2'b00;
   				temp0 <= 2'b11;
   				end		
   			else
   				begin
   				R0 <= R0;
   				temp0 <= temp0;
   				end	
   			
   			if(R1e==0)
   				begin
		   		R1 <= 2'b00;
		   		temp1 <= 2'b11;
		   		end
		   	else
		   		begin
		   		R1 <= R1;
		   		temp1 <= temp1; 
		   		end  	
		   end //if en==0				
		else if(en==1)
			begin
				if(SELECT[0]==1)
					begin
						if(R0e==1)
							begin
							R0 <= L;
							temp0 <= (~L);
							end
						else
							begin
							R0 <= R0;
							temp0 <= temp0;
							end							
					end//if SELECT==0
				else if(SELECT[1]==1) //if SELECT[1] ==1
					begin
						if(R1e==1)
							begin
							R1 <= L;
							temp1 <= (~L);
							end
						else
							begin
							R1 <= R1;
							temp1 <= temp1;
							end						
					end//if SELECT[1]==1

			end //if en==1
 
  	end //if RESET==0
 end //always block

endmodule