`include "macros.v"

module bitbucket(L);
	`USES_CHANNEL
  
  parameter width = 11;
  `INPORT(L, width)

  reg [width-1:0] d;
  
  always begin
    `RECEIVE(L, d)
  end
  
endmodule