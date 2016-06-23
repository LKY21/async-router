`include "macros.v"

module ARB (req1, req2, winner);
	parameter width = 1;
	`USES_CHANNEL;
	`INPORT(req1,width);
	`INPORT(req2,width);
	`OUTPORT(winner,1);
	reg [width-1:0] r1;
	reg [width-1:0] r2;
  reg priority;
	
	initial
		begin
		priority = 0;
		end
	always
		begin
			wait(`PROBE(req1) || `PROBE(req2) );
			if( `PROBE(req1) && `PROBE(req2) )
			
			begin
				// Both ports have tokens: select one randomly
		//		if ( {$random}%2 == 0)
			
			  `RECEIVE(req1, r1)
			  `RECEIVE(req2, r2)
			
				if ( priority == 0) //rotating priority bit						
				begin	
					`SEND(winner, 1'b0)
					`SEND(winner, 1'b1)				
					priority = ~priority;		
				end else
				begin	
					`SEND(winner, 1'b1)
					`SEND(winner, 1'b0)					
					priority = ~priority;
				end
				
			end else if (`PROBE(req1))
				begin //only req1 has a token
					`RECEIVE(req1, r1)
					`SEND(winner, 1'b0)
				end
			else
				begin //only req2 has a token
					`RECEIVE(req2, r2)
					`SEND(winner, 1'b1)
				end
			end
		endmodule