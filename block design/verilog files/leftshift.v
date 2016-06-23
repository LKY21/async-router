`include "macros.v"

module leftshift(L,R);
  
  parameter width = 11;
  `INPORT(L, width)
  `OUTPORT(R, width)
  `USES_CHANNEL

  reg [width-1:0] d;
  
  always begin
    `RECEIVE(L, d)
    d[width-1:width-5] = d[width-1:width-5]*2'd2;
    `SEND(R, d)
  end
  
endmodule