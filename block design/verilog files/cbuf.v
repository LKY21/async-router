`include "macros.v"
`timescale 1ns / 1ps

module cBUF(L,R,c);
  
  parameter width = 11;
  `INPORT(L, width)
  `OUTPORT(R, width)
  `OUTPORT(c, 1)
  `USES_CHANNEL

  reg [width-1:0] d;
  always begin
    `RECEIVE(L, d)
    fork
    `SEND(R, d)
    `SEND(c,1'b1)
    join
  end
  
endmodule