`timescale 1ns/1ps 
`include "lib.v"
`include "macros.v"
`include "cbuf.v"

module CSP_cBUF1( inport, outport, c, reset);

input reset;

`USES_CHANNEL
`INPORT(inport, 1)
`OUTPORT(outport, 1)
`OUTPORT(c, 1)

wire [1:0] L, R;
wire Le, Re;
wire d, de; 

//makes the 'completion' output of the PCHB cBUF into a 1-bit 1-of-2 signal
wire[1:0] completion;
assign completion[1] = d;
assign completion [0] = 0;

CSP_to_Oneof2 inport_to_L(inport,Le,L); // for inputs
Oneof2_to_CSP R_to_outport(R,Re,outport); //outputs
Oneof2_to_CSP completion_to_c(completion,de,c);

PCHB_cBUF cbuf(L, Le, R, Re, d, de, reset);

endmodule


