`include "split.v"
`include "macros.v"
`include "lib.v"

module CSP_split11(X,Y,Z,reset);

input reset;

  parameter width = 11;  
  `USES_CHANNEL  
  `INPORT(X, width) 
  `OUTPORT(Y, width)
  `OUTPORT(Z, width)
  
  reg [width-1:0] x, y, z;
  
  `CHANNEL(X0, 1)
  `CHANNEL(X1, 1)
  `CHANNEL(X2, 1)
  `CHANNEL(X3, 1)
  `CHANNEL(X4, 1)
  `CHANNEL(X5, 1)
  `CHANNEL(X6, 1)
  `CHANNEL(X7, 1)
  `CHANNEL(X8, 1)
  `CHANNEL(X9, 1)
  `CHANNEL(X10,1)
  
  `CHANNEL(C0, 1)
  `CHANNEL(C1, 1)
  `CHANNEL(C2, 1)
  `CHANNEL(C3, 1)
  `CHANNEL(C4, 1)
  `CHANNEL(C5, 1)
  `CHANNEL(C6, 1)
  `CHANNEL(C7, 1)
  `CHANNEL(C8, 1)
  `CHANNEL(C9, 1)
  `CHANNEL(C10,1)
  
  `CHANNEL(Y0, 1)
  `CHANNEL(Y1, 1)
  `CHANNEL(Y2, 1)
  `CHANNEL(Y3, 1)
  `CHANNEL(Y4, 1)
  `CHANNEL(Y5, 1)
  `CHANNEL(Y6, 1)
  `CHANNEL(Y7, 1)
  `CHANNEL(Y8, 1)
  `CHANNEL(Y9, 1)
  `CHANNEL(Y10,1)
  
  `CHANNEL(Z0, 1)
  `CHANNEL(Z1, 1)
  `CHANNEL(Z2, 1)
  `CHANNEL(Z3, 1)
  `CHANNEL(Z4, 1)
  `CHANNEL(Z5, 1)
  `CHANNEL(Z6, 1)
  `CHANNEL(Z7, 1)
  `CHANNEL(Z8, 1)
  `CHANNEL(Z9, 1)
  `CHANNEL(Z10,1)
  
  
  CSP_split1 SPLIT_0  (X0, Y0, Z0, C0, reset);
  CSP_split1 SPLIT_1  (X1, Y1, Z1, C1, reset);
  CSP_split1 SPLIT_2  (X2, Y2, Z2, C2, reset);
  CSP_split1 SPLIT_3  (X3, Y3, Z3, C3, reset);
  CSP_split1 SPLIT_4  (X4, Y4, Z4, C4, reset);
  CSP_split1 SPLIT_5  (X5, Y5, Z5, C5, reset);
  CSP_split1 SPLIT_6  (X6, Y6, Z6, C6, reset);
  CSP_split1 SPLIT_7  (X7, Y7, Z7, C7, reset);
  CSP_split1 SPLIT_8  (X8, Y8, Z8, C8, reset);
  CSP_split1 SPLIT_9  (X9, Y9, Z9, C9, reset);
  CSP_split1 SPLIT_10 (X10, Y10, Z10, C10, reset);
  
  always
  begin
    `RECEIVE(X,x)
    fork
    `SEND(X0,x[0])
    `SEND(X1,x[1])
    `SEND(X2,x[2])
    `SEND(X3,x[3])
    `SEND(X4,x[4])
    `SEND(X5,x[5])
    `SEND(X6,x[6])
    `SEND(X7,x[7])
    `SEND(X8,x[8])
    `SEND(X9,x[9])
    `SEND(X10,x[10])
    
    `SEND(C0,x[10])
    `SEND(C1,x[10])
    `SEND(C2,x[10])
    `SEND(C3,x[10])
    `SEND(C4,x[10])
    `SEND(C5,x[10])
    `SEND(C6,x[10])
    `SEND(C7,x[10])
    `SEND(C8,x[10])
    `SEND(C9,x[10])
    `SEND(C10,x[10])
    join
    
    if (x[10] == 0)
      begin
      fork
      `RECEIVE(Y0,y[0])
      `RECEIVE(Y1,y[1])
      `RECEIVE(Y2,y[2])
      `RECEIVE(Y3,y[3])
      `RECEIVE(Y4,y[4])
      `RECEIVE(Y5,y[5])
      `RECEIVE(Y6,y[6])
      `RECEIVE(Y7,y[7])
      `RECEIVE(Y8,y[8])
      `RECEIVE(Y9,y[9])
      `RECEIVE(Y10,y[10])
      join
      `SEND(Y,y)
      end
    else
      begin
      fork
      `RECEIVE(Z0,z[0])
      `RECEIVE(Z1,z[1])
      `RECEIVE(Z2,z[2])
      `RECEIVE(Z3,z[3])
      `RECEIVE(Z4,z[4])
      `RECEIVE(Z5,z[5])
      `RECEIVE(Z6,z[6])
      `RECEIVE(Z7,z[7])
      `RECEIVE(Z8,z[8])
      `RECEIVE(Z9,z[9])
      `RECEIVE(Z10,z[10])
      join
      `SEND(Z,z)
      end
  end
endmodule