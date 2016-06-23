`timescale 1ns/1ps
/***********************************************************
* Arbiter using burst mode
* Author	: Mallika Prakash
* Last Update	: 04/03/06 - Mutex
*		: 04/13/06 - Fixed the always@(sesitivity list) 
*		: issue and put waits instead. 
*
* edited by Lawrence Yu
* 5/2/10 - rotating priority bit
************************************************************/

//Behavioral implementation of a Mutex Element
module mutex(req0, req1, grant0, grant1, reset);

	input req0, req1, reset;
	output reg grant0, grant1;

	reg a; //rotating priority bit
	
	initial
	begin
	 wait(reset);
	 #0 grant0=0;  grant1=0;
	 a=0;
	end

	always
	begin
	   wait (req0 || req1);
		if (req0 && req1)
		begin
		//  a = ($random)%2;
		  if (a)
		  begin
		    #2 grant1=1;
		    //$display("req1 granted");	//for checking purpose. 
		    wait(~req1);
		    #2 grant1=0;
		    a=~a; //rotating priority
		  end
		  else
		  begin
		    #2 grant0=1;
		    //$display("req0 granted");	//for checking purpose. 
		    wait(~req0);
		    #2 grant0=0;
		    a=~a; //rotating priority
		  end
		end
		else if (req0)
		begin
		  #2 grant0=1;
		  //$display("req0 granted");	//for checking purpose. 
		  wait(~req0);
		  #2 grant0=0;
		end
		else if (req1)
		begin
		  #2 grant1=1;
		  //$display("req1 granted");	//for checking purpose. 
		  #2 wait(~req1);
		  grant1=0;
		end
	end
endmodule
