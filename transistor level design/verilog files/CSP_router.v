`include "macros.v"
`include "CSP_split11.v"
`include "CSP_mux11.v"
`include "CSP_arbiter1.v"
`include "CSP_cBUF11.v"
`include "CSP_LSbuf11.v"

module CSP_router (P, Pout, C1, C1out, C2, C2out, reset);
  
	input reset;
  
	parameter WIDTH = 11; 
	parameter	F_DELAY = 1;
	parameter B_DELAY = 2;
	
	`USES_CHANNEL	
	`INPORT(C1,WIDTH)
	`INPORT(C2,WIDTH)	
	`INPORT(P, WIDTH)	
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
	
	//module CSP_split11(X,Y,Z,reset);
	CSP_split11 split1(P,  Pa,  Pb , reset);
	CSP_split11 split2(C1, C1a, C1b, reset);
	CSP_split11 split3(C2, C2a, C2b, reset);
	
	//module CSP_mux11(X,Y,C,Z,reset);
	CSP_mux11 mux1(PaDR,  C2bDR, arb1, mux1out, reset);
	CSP_mux11 mux2(C1aDR, C2aDR, arb2, mux2out, reset);
	CSP_mux11 mux3(C1bDR, PbDR,  arb3, mux3out, reset);
	
	//module CSP_arbiter1(req1, req2, winner, reset);
	CSP_arbiter1 arbiter1(Pareq,  C2breq, arb1, reset);
	CSP_arbiter1 arbiter2(C1areq, C2areq, arb2, reset);
	CSP_arbiter1 arbiter3(C1breq, Pbreq,  arb3, reset);
	
	//module CSP_cBUF11( L, R, C, reset);
	CSP_cBUF11 buf1(Pa,  PaDR,  Pareq , reset);
	CSP_cBUF11 buf2(Pb,  PbDR,  Pbreq , reset);
	CSP_cBUF11 buf3(C1a, C1aDR, C1areq, reset);
	CSP_cBUF11 buf4(C1b, C1bDR, C1breq, reset);	
	CSP_cBUF11 buf5(C2a, C2aDR, C2areq, reset);
	CSP_cBUF11 buf6(C2b, C2bDR, C2breq, reset);	
	
	//module CSP_LSbuf11( L, R, reset);
	CSP_LSbuf11 ls1(mux1out, C1out, reset);
	CSP_LSbuf11 ls2(mux2out,  Pout, reset);
	CSP_LSbuf11 ls3(mux3out, C2out, reset);
	

	
endmodule