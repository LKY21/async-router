`timescale 1ns / 1ps
`include "macros.v"
`include "CSP_tree.v"
`include "bitbucket11.v"

module CSP_tree_tb;						//all to all testbench
	 `USES_CHANNEL
	  parameter WIDTH = 11;
	  
	  reg reset;
	  
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
   
  //module CSP_tree (CA4, CB4, CC5, CD5, CE6, CF6, CG7, CH7, C4A, C4B, C5C, C5D, C6E, C6F, C7G, C7H, reset);

	CSP_tree DUT(CA4, CB4, CC5, CD5, CE6, CF6, CG7, CH7, C4A, C4B, C5C, C5D, C6E, C6F, C7G, C7H, reset);
	
	bitbucket11 bb1(C4A);
	bitbucket11 bb2(C4B);
	bitbucket11 bb3(C5C);
	bitbucket11 bb4(C5D);
	bitbucket11 bb5(C6E);
	bitbucket11 bb6(C6F);
	bitbucket11 bb7(C7G);
	bitbucket11 bb8(C7H);
	
	
	initial
		begin
		
		reset=1;
		#2;
		reset=0;
		#2;
		
		$monitor("Aout=%b %b %b, Bout=%b %b %b, Cout=%b %b %b, Dout=%b %b %b, Eout=%b %b %b, Fout=%b %b %b, Gout=%b %b %b, Hout=%b %b %b",
		         bb1.d[WIDTH-1:WIDTH-5], bb1.d[WIDTH-6:WIDTH-8], bb1.d[WIDTH-9:0], 
		         bb2.d[WIDTH-1:WIDTH-5], bb2.d[WIDTH-6:WIDTH-8], bb2.d[WIDTH-9:0], 
		         bb3.d[WIDTH-1:WIDTH-5], bb3.d[WIDTH-6:WIDTH-8], bb3.d[WIDTH-9:0], 
		         bb4.d[WIDTH-1:WIDTH-5], bb4.d[WIDTH-6:WIDTH-8], bb4.d[WIDTH-9:0], 
		         bb5.d[WIDTH-1:WIDTH-5], bb5.d[WIDTH-6:WIDTH-8], bb5.d[WIDTH-9:0], 
		         bb6.d[WIDTH-1:WIDTH-5], bb6.d[WIDTH-6:WIDTH-8], bb6.d[WIDTH-9:0], 
		         bb7.d[WIDTH-1:WIDTH-5], bb7.d[WIDTH-6:WIDTH-8], bb7.d[WIDTH-9:0], 
		         bb8.d[WIDTH-1:WIDTH-5], bb8.d[WIDTH-6:WIDTH-8], bb8.d[WIDTH-9:0]);
  
  //all to all
		
	 //	 packet is encoded with source and destination information in data field
		// (5 bits routing) -- (3 bits source info) -- (3 bits destination info)
// all to A 
		
		`SEND(CB4, 11'b10000_001_000) //BA
		`SEND(CC5, 11'b01000_010_000) //CA
		`SEND(CD5, 11'b01000_011_000) //DA
		`SEND(CE6, 11'b00100_100_000) //EA
		`SEND(CF6, 11'b00100_101_000) //FA
		`SEND(CG7, 11'b00100_110_000) //GA
		`SEND(CH7, 11'b00100_111_000) //HA

// all to B
		
	 	`SEND(CA4, 11'b10000_000_001) //AB
		`SEND(CC5, 11'b01100_010_001) //CB
		`SEND(CD5, 11'b01100_011_001) //DB
		`SEND(CE6, 11'b00101_100_001) //EB
		`SEND(CF6, 11'b00101_101_001) //FB
		`SEND(CG7, 11'b00101_110_001) //GB
		`SEND(CH7, 11'b00101_111_001) //HB

//all to C
		
	 	`SEND(CA4, 11'b01000_000_010) //AC
		`SEND(CB4, 11'b01000_001_010) //BC
		`SEND(CD5, 11'b10000_011_010) //DC
		`SEND(CE6, 11'b00110_100_010) //EC
		`SEND(CF6, 11'b00110_101_010) //FC
		`SEND(CG7, 11'b00110_110_010) //GC
		`SEND(CH7, 11'b00110_111_010) //HC

//all to D
		
	 	`SEND(CA4, 11'b01100_000_011) //AD
		`SEND(CB4, 11'b01100_001_011) //BD
		`SEND(CC5, 11'b10000_010_011) //CD
		`SEND(CE6, 11'b00111_100_011) //ED
		`SEND(CF6, 11'b00111_101_011) //FD
		`SEND(CG7, 11'b00111_110_011) //GD
		`SEND(CH7, 11'b00111_111_011) //HD
 	
//all to E
		
		`SEND(CA4, 11'b00100_000_100) //AE
		`SEND(CB4, 11'b00100_001_100) //BE
		`SEND(CC5, 11'b00100_010_100) //CE
		`SEND(CD5, 11'b00100_011_100) //DE
		`SEND(CF6, 11'b10000_101_100) //FE
		`SEND(CG7, 11'b01000_110_100) //GE
		`SEND(CH7, 11'b01000_111_100) //HE
	 	
	
//all to F
		
		`SEND(CA4, 11'b00101_000_101) //AF
		`SEND(CB4, 11'b00101_001_101) //BF
		`SEND(CC5, 11'b00101_010_101) //CF
		`SEND(CD5, 11'b00101_011_101) //DF
		`SEND(CE6, 11'b10000_100_101) //EF
		`SEND(CG7, 11'b01100_110_101) //GF
		`SEND(CH7, 11'b01100_111_101) //HF

//all to G

	  `SEND(CA4, 11'b00110_000_110) //AG
		`SEND(CB4, 11'b00110_001_110) //BG
		`SEND(CC5, 11'b00110_010_110) //CG
		`SEND(CD5, 11'b00110_011_110) //DG
		`SEND(CE6, 11'b01000_100_110) //EG
		`SEND(CF6, 11'b01000_101_110) //FG
		`SEND(CH7, 11'b10000_111_110) //HG

		
//all to H

	 	`SEND(CA4, 11'b00111_000_111) //AH
		`SEND(CB4, 11'b00111_001_111) //BH
		`SEND(CC5, 11'b00111_010_111) //CH
		`SEND(CD5, 11'b00111_011_111) //DH
		`SEND(CE6, 11'b01100_100_111) //EH
		`SEND(CF6, 11'b01100_101_111) //FH
		`SEND(CG7, 11'b10000_110_111) //GH
	
	 	

	 	


	end
	
endmodule