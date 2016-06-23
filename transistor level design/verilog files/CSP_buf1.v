`timescale 1ns/1ps 
`include "lib.v"
`include "macros.v"
`include "buf.v"

module CSP_BUF1( inport, outport, reset);

input reset;

`USES_CHANNEL
`INPORT(inport, 1)
`OUTPORT(outport, 1)

wire [1:0] L, R;
wire Le, Re;

CSP_to_Oneof2 inport_to_L(inport,Le,L); // for inputs
Oneof2_to_CSP R_to_outport(R,Re,outport); //outputs

PCHB_BUF buf0(L, Le, R, Re, reset);

endmodule


