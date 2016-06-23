`include "macros.v"
`timescale 1ns / 1ps

module BUF(L,R);
  
  parameter width = 11;
  `INPORT(L, width)
  `OUTPORT(R, width)
  `USES_CHANNEL

  reg [width-1:0] d;
  always begin
    `RECEIVE(L, d)
    `SEND(R, d)
  end
  
endmodule

