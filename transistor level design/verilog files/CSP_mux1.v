`timescale 1ns/1ps 
`include "mux.v"
`include "macros.v"
`include "lib.v"

module CSP_mux1(X,Y,C,Z, reset);

input reset;

  parameter width = 1;  
  `USES_CHANNEL  
  `INPORT(X, width) //input 1
  `INPORT(Y, width) //input 2
  `INPORT(C, width)  
  `OUTPORT(Z, width)

  wire [1:0] L0, L1, R, SELECT; 
  wire L0e, L1e, Re, SELECTe;
  
PCHB_mux mux0(L0, L0e, L1, L1e, SELECT, SELECTe, R, Re, reset);

CSP_to_Oneof2 X_to_L0 		(X,  L0e,  L0); // convert X input to L0 11 one-of-2s
CSP_to_Oneof2 Y_to_L1 		(Y,  L1e,  L1); // convert Y input to L1 11 one-of-2s
CSP_to_Oneof2 C_to_select 	(C,  SELECTe,  SELECT); // convert C inputs to select 11 one-of-2s

Oneof2_to_CSP R_to_Z	(R, Re, Z); //output R to Z CSP

endmodule