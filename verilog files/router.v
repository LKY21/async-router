`include "macros.v"
`include "split.v"
`include "mux.v"
`include "arbiter.v"
`include "cbuf.v"
`include "leftshift.v"

module router (P, Pout, C1, C1out, C2, C2out);
  
	parameter WIDTH = 11; 
	parameter	F_DELAY = 1;
	parameter B_DELAY = 2;
	
	`USES_CHANNEL	
	`INPORT(C1,WIDTH)
	`INPORT(C2,WIDTH)	
	`INPORT(P,WIDTH)	
	`OUTPORT(C1out,WIDTH)
	`OUTPORT(C2out,WIDTH)	
	`OUTPORT(Pout,WIDTH)
	
	`CHANNEL(Pa,WIDTH)
	`CHANNEL(Pb,WIDTH)
	`CHANNEL(C1a,WIDTH)
	`CHANNEL(C1b,WIDTH)
	`CHANNEL(C2a,WIDTH)
	`CHANNEL(C2b,WIDTH)
	
	`CHANNEL(Pareq,1)
	`CHANNEL(Pbreq,1)
	`CHANNEL(C1areq,1)
	`CHANNEL(C1breq,1)
	`CHANNEL(C2breq,1)
	`CHANNEL(C2areq,1)
	
	`CHANNEL(PaDR,WIDTH)
	`CHANNEL(PbDR,WIDTH)
	`CHANNEL(C1aDR,WIDTH)
	`CHANNEL(C1bDR,WIDTH)	
	`CHANNEL(C2aDR,WIDTH)
	`CHANNEL(C2bDR,WIDTH)
			
	`CHANNEL(arb1,1)
	`CHANNEL(arb2,1)
	`CHANNEL(arb3,1)
	
	`CHANNEL(mux1out, WIDTH)
	`CHANNEL(mux2out, WIDTH)
	`CHANNEL(mux3out, WIDTH)
	
	
	SPL split1(P,  Pa,  Pb);
	SPL split2(C1, C1a, C1b);
	SPL split3(C2, C2a, C2b);
	
	MUX mux1(PaDR,  C2bDR, arb1, mux1out);
	MUX mux2(C1aDR, C2aDR, arb2, mux2out);
	MUX mux3(C1bDR, PbDR,  arb3, mux3out);
	
	ARB arbiter1(Pareq,  C2breq, arb1);
	ARB arbiter2(C1areq, C2areq, arb2);
	ARB arbiter3(C1breq, Pbreq,  arb3);
	
	cBUF buf1(Pa,  PaDR,  Pareq);
	cBUF buf2(Pb,  PbDR,  Pbreq);
	cBUF buf3(C1a, C1aDR, C1areq);
	cBUF buf4(C1b, C1bDR, C1breq);	
	cBUF buf5(C2a, C2aDR, C2areq);
	cBUF buf6(C2b, C2bDR, C2breq);	
	
	leftshift ls1(mux1out, C1out);
	leftshift ls2(mux2out,  Pout);
	leftshift ls3(mux3out, C2out);
	

	
endmodule