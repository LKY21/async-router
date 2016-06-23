`include "CSP_mux1.v"
`include "macros.v"

module CSP_mux11(X,Y,C,Z,reset);

input reset;

  parameter width = 11;  
  `USES_CHANNEL  
  `INPORT(X, width) 
  `INPORT(Y, width)
  `INPORT(C, 1)
  `OUTPORT(Z, width)
  
  reg [width-1:0] x, y, z;
  reg c;
  
  `CHANNEL(X0  ,  1)
  `CHANNEL(X1  ,  1)
  `CHANNEL(X2  ,  1)
  `CHANNEL(X3  ,  1)
  `CHANNEL(X4  ,  1)
  `CHANNEL(X5  ,  1)
  `CHANNEL(X6  ,  1)
  `CHANNEL(X7  ,  1)
  `CHANNEL(X8  ,  1)
  `CHANNEL(X9  ,  1)
  `CHANNEL(X10 ,  1)
  
  `CHANNEL(C0 , 1)
  `CHANNEL(C1 , 1)
  `CHANNEL(C2 , 1)
  `CHANNEL(C3 , 1)
  `CHANNEL(C4 , 1)
  `CHANNEL(C5 , 1)
  `CHANNEL(C6 , 1)
  `CHANNEL(C7 , 1)
  `CHANNEL(C8 , 1)
  `CHANNEL(C9 , 1)
  `CHANNEL(C10, 1)
  
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
  
  //module CSP_mux1(X,Y,C,Z, reset);
  CSP_mux1 MUX_0  (X0 ,  Y0 , C0 , Z0 , reset);
  CSP_mux1 MUX_1  (X1 ,  Y1 , C1 , Z1 , reset);
  CSP_mux1 MUX_2  (X2 ,  Y2 , C2 , Z2 , reset);
  CSP_mux1 MUX_3  (X3 ,  Y3 , C3 , Z3 , reset);
  CSP_mux1 MUX_4  (X4 ,  Y4 , C4 , Z4 , reset);
  CSP_mux1 MUX_5  (X5 ,  Y5 , C5 , Z5 , reset);
  CSP_mux1 MUX_6  (X6 ,  Y6 , C6 , Z6 , reset);
  CSP_mux1 MUX_7  (X7 ,  Y7 , C7 , Z7 , reset);
  CSP_mux1 MUX_8  (X8 ,  Y8 , C8 , Z8 , reset);
  CSP_mux1 MUX_9  (X9 ,  Y9 , C9 , Z9 , reset);
  CSP_mux1 MUX_10 (X10,  Y10, C10, Z10, reset);
  
  always
  begin
    `RECEIVE(C,c)
	fork
	`SEND(C0,c)
	`SEND(C1,c)
	`SEND(C2,c)
	`SEND(C3,c)
	`SEND(C4,c)
	`SEND(C5,c)
	`SEND(C6,c)
	`SEND(C7,c)
	`SEND(C8,c)
	`SEND(C9,c)
	`SEND(C10,c)
	join
	
	if(c==0)
		begin
	    `RECEIVE(X,x)
		fork
		`SEND(X0, x[0] )
		`SEND(X1, x[1] )
		`SEND(X2, x[2] )
		`SEND(X3, x[3] )
		`SEND(X4, x[4] )
		`SEND(X5, x[5] )
		`SEND(X6, x[6] )
		`SEND(X7, x[7] )
		`SEND(X8, x[8] )
		`SEND(X9, x[9] )
		`SEND(X10,x[10])	
		join
		end
	else //if c==1
		begin
	    `RECEIVE(Y,y)  
		fork
		`SEND(Y0, y[0])
		`SEND(Y1, y[1])
		`SEND(Y2, y[2])
		`SEND(Y3, y[3])
		`SEND(Y4, y[4])
		`SEND(Y5, y[5])
		`SEND(Y6, y[6])
		`SEND(Y7, y[7])
		`SEND(Y8, y[8])
		`SEND(Y9, y[9])
		`SEND(Y10,y[10])
		join	
		end
       
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
endmodule
