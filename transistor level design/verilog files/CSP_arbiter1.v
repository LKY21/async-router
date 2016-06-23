`timescale 1ns/1ps 
`include "arbiter.v"
`include "macros.v"
`include "lib.v"

module CSP_arbiter1(req1, req2, winner, reset);

input reset;

  parameter width = 1;  
  `USES_CHANNEL  
  `INPORT(req1, width) //input 1
  `INPORT(req2, width) //input 2
  `OUTPORT(winner, width)

  wire [1:0] L0, L1, R; 
  wire L0e, L1e, Re;
 
PCHB_arbiter arb0(L0, L0e, L1, L1e, R, Re, reset);

CSP_to_Oneof2 req1_to_L0 		(req1,  L0e,  L0); // convert req1 input to L0 11 one-of-2s
CSP_to_Oneof2 req2_to_L1 		(req2,  L1e,  L1); // convert req2 input to L1 11 one-of-2s

Oneof2_to_CSP R_to_winner	(R, Re, winner); //output R to winner CSP

endmodule