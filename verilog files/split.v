`include "macros.v"

module SPL(X,Y,Z);
  
  parameter width = 11;  
  `INPORT(X, width)
  `OUTPORT(Y, width)
  `OUTPORT(Z, width)
  `USES_CHANNEL

  reg [width-1:0] d;
  
  always begin
    wait(`PROBE(X));
    if(`PROBE(X))
    begin
	    `RECEIVE(X, d)

      if (d[width-1]==0)
        `SEND(Y, d)
      else 
        `SEND(Z, d)
    end
  end //always block
    
endmodule

