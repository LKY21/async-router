`timescale 1ns/1ps 
`include "split.v"
`include "macros.v"
`include "lib.v"

module CSP_split1(X,Y,Z, C, reset);

input reset;

  parameter width = 1;  
  `USES_CHANNEL  
  `INPORT(X, width)
  `INPORT(C, width)  
  `OUTPORT(Y, width)
  `OUTPORT(Z, width)

  wire [1:0] L, R0, R1, select; //REMEMBER TO DO THIS
  wire Le, R0e, R1e, SELECTe;
  
PCHB_split split0 (L, Le, R0, R0e, R1, R1e, select, SELECTe, reset);

CSP_to_Oneof2 X_to_L 		(X,  Le,  L); // convert inputs to 11 one-of-2s
CSP_to_Oneof2 C_to_select 	(C,  SELECTe,  select); // convert inputs to 11 one-of-2s

Oneof2_to_CSP R0_to_Y	(R0, R0e, Y); //output R0
Oneof2_to_CSP R1_to_Z	(R1, R1e, Z); //output R1

endmodule