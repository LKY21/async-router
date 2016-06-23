`timescale 1ns / 1ps
`include "macros.v"
`include "tree.v"
`include "bitbucket.v"

module tree_tb();
	 `USES_CHANNEL
	  parameter WIDTH = 9;
	  //input channels 
	`CHANNEL(CA4,WIDTH) 
  `CHANNEL(CB4,WIDTH) 
  `CHANNEL(CC5,WIDTH) 
  `CHANNEL(CD5,WIDTH) 
  `CHANNEL(CE6,WIDTH) 
  `CHANNEL(CF6,WIDTH) 
  `CHANNEL(CG7,WIDTH) 
  `CHANNEL(CH7,WIDTH) 
  
  //output channels
  `CHANNEL(C4A,WIDTH)
  `CHANNEL(C4B,WIDTH)  
  `CHANNEL(C5C,WIDTH)
  `CHANNEL(C5D,WIDTH)
  `CHANNEL(C6E,WIDTH)
  `CHANNEL(C6F,WIDTH)  
  `CHANNEL(C7G,WIDTH)
  `CHANNEL(C7H,WIDTH)  
   
  
	tree DUT(CA4, CB4, CC5, CD5, CE6, CF6, CG7, CH7, C4A, C4B, C5C, C5D, C6E, C6F, C7G, C7H);
	
  bitbucket bb1(C4A);
	bitbucket bb2(C4B);
  bitbucket bb3(C5C);
	bitbucket bb4(C5D);
  bitbucket bb5(C6E);
	bitbucket bb6(C6F);
  bitbucket bb7(C7G);
	bitbucket bb8(C7H);
	
//	integer out_file;
	
	initial
		begin
		
		$monitor("Aout=%b, Bout=%b, Cout=%b, Dout=%b, Eout=%b, Fout=%b, Gout=%b, Hout=%b", bb1.d, bb2.d, bb3.d, bb4.d, bb5.d, bb6.d, bb7.d, bb8.d);
  
  
 //  out_file = $fopen("onetoall.out");
//		$fmonitor(out_file, "Aout=%b, Bout=%b, Cout=%b, Dout=%b, Eout=%b, Fout=%b, Gout=%b, Hout=%b", bb1.d, bb2.d, bb3.d, bb4.d, bb5.d, bb6.d, bb7.d, bb8.d);


	// send A to all	 
	 `SEND(CA4, 9'b100000000) //AB
	 `SEND(CA4, 9'b010111111) //AC
	 `SEND(CA4, 9'b011110101) //AD
	 `SEND(CA4, 9'b001000101) //AE
	 `SEND(CA4, 9'b001011111) //AF
	 `SEND(CA4, 9'b001100101) //AG
	 `SEND(CA4, 9'b001110101) //AH
	 #1;


/*
		//send B to all
		`SEND(CB4, 9'b100000000) //BA
		`SEND(CB4, 9'b010110000) //BC
		`SEND(CB4, 9'b011110000) //BD
		`SEND(CB4, 9'b001000000) //BE
		`SEND(CB4, 9'b001010000) //BF
		`SEND(CB4, 9'b001100000) //BG
		`SEND(CB4, 9'b001110000) //BH
	 #1;
*/
	 
/*
		//send C to all
		`SEND(CC5, 9'b010000000) //CA
		`SEND(CC5, 9'b011000000) //CB
		`SEND(CC5, 9'b100000000) //CD
		`SEND(CC5, 9'b001000000) //CE
		`SEND(CC5, 9'b001010000) //CF
		`SEND(CC5, 9'b001100000) //CG
		`SEND(CC5, 9'b001110000) //CH
	 #1;	 
	*/ 
	 
	/* 
	 		//send D to all
		`SEND(CD5, 9'b010000000) //DA
		`SEND(CD5, 9'b011000000) //DB
		`SEND(CD5, 9'b100000000) //DC
		`SEND(CD5, 9'b001000000) //DE
		`SEND(CD5, 9'b001010000) //DF
		`SEND(CD5, 9'b001100000) //DG
		`SEND(CD5, 9'b001110000) //DH
	 #1;	 
	*/ 
	 
/*	 

	 		//send E to all
		`SEND(CE6, 9'b001000000) //EA
		`SEND(CE6, 9'b001010000) //EB
		`SEND(CE6, 9'b001100000) //EC
		`SEND(CE6, 9'b001110000) //ED
		`SEND(CE6, 9'b100000000) //EF
		`SEND(CE6, 9'b010000000) //EG
		`SEND(CE6, 9'b011000000) //EH
	 #1;	 
*/	 
/*
		 		//send F to all
		`SEND(CF6, 9'b001000000) //FA
		`SEND(CF6, 9'b001010000) //FB
		`SEND(CF6, 9'b001100000) //FC
		`SEND(CF6, 9'b001110000) //FD
		`SEND(CF6, 9'b100000000) //FE
		`SEND(CF6, 9'b010000000) //FG
		`SEND(CF6, 9'b011000000) //FH
	 #1;	  
*/
	/*
			 		//send G to all
		`SEND(CG7, 9'b001000000) //GA
		`SEND(CG7, 9'b001010000) //GB
		`SEND(CG7, 9'b001100000) //GC
		`SEND(CG7, 9'b001110000) //GD
		`SEND(CG7, 9'b010000000) //GE
		`SEND(CG7, 9'b011000000) //GF
		`SEND(CG7, 9'b100000000) //GH
	 #1;	
	*/ 
	/* 
			 		//send H to all
		`SEND(CH7, 9'b001000000) //HA
		`SEND(CH7, 9'b001010000) //HB
		`SEND(CH7, 9'b001100000) //HC
		`SEND(CH7, 9'b001110000) //HD
		`SEND(CH7, 9'b010000000) //HE
		`SEND(CH7, 9'b011000000) //HF
		`SEND(CH7, 9'b100000000) //HG
	 #1;	
	
	 */
	
	
//   $fclose(out_file);
  // $finish;	 
	end
	
endmodule